import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/data/datasources/local/isar_service.dart';
import 'package:money/data/models/driver_profile.dart';
import 'package:money/data/models/monk_profile.dart';
import 'package:money/data/models/transaction_record.dart';
import 'package:money/data/models/driver_expense_record.dart';
import 'package:money/data/models/app_user.dart'; // For UserRole
import 'package:money/data/datasources/local/isar_service_provider.dart';
import 'package:money/features/treasurer/notifiers/monk_account_notifier.dart';
import 'package:money/features/treasurer/notifiers/driver_account_notifier.dart';
import 'package:money/features/treasurer/notifiers/central_fund_notifier.dart';

@immutable
class DataProcessingState {
  final bool isLoading;
  final String? successMessage;
  final String? errorMessage;
  final int processedMonkTransactions;
  final int processedDriverExpenses;

  const DataProcessingState({
    this.isLoading = false,
    this.successMessage,
    this.errorMessage,
    this.processedMonkTransactions = 0,
    this.processedDriverExpenses = 0,
  });

  DataProcessingState copyWith({
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
    int? processedMonkTransactions,
    int? processedDriverExpenses,
    bool clearMessages = false,
  }) {
    return DataProcessingState(
      isLoading: isLoading ?? this.isLoading,
      successMessage: clearMessages
          ? null
          : successMessage ?? this.successMessage,
      errorMessage: clearMessages ? null : errorMessage ?? this.errorMessage,
      processedMonkTransactions:
          processedMonkTransactions ?? this.processedMonkTransactions,
      processedDriverExpenses:
          processedDriverExpenses ?? this.processedDriverExpenses,
    );
  }
}

class TreasurerDataProcessingNotifier
    extends StateNotifier<DataProcessingState> {
  final IsarService _isarService;
  final Ref _ref; // To read other notifiers

  TreasurerDataProcessingNotifier(this._isarService, this._ref)
    : super(const DataProcessingState());

  Future<void> processDriverSubmission({
    required String submittingDriverId,
    required List<TransactionRecord> monkTransactions,
    required List<DriverExpenseRecord> driverExpenses,
    required AppUser treasurerUser, // The treasurer performing the import
  }) async {
    state = state.copyWith(
      isLoading: true,
      clearMessages: true,
      processedMonkTransactions: 0,
      processedDriverExpenses: 0,
    );
    int currentMonkTxCount = 0;
    int currentDriverExCount = 0;

    try {
      // 1. Validate submittingDriverId
      final driverProfile = await _isarService.getDriverProfileByPrimaryId(
        submittingDriverId,
      );
      if (driverProfile == null) {
        throw Exception('ไม่พบคนขับรถ ID: $submittingDriverId ในระบบ');
      }

      // 2. Process Monk Transactions
      for (final txRecord in monkTransactions) {
        // Ensure the transaction is linked to the correct driver and processed by treasurer
        txRecord.driverPrimaryId = submittingDriverId;
        txRecord.processedByUserId = treasurerUser.primaryId;
        txRecord.processedByUserRole = treasurerUser.role;
        // txRecord.source is already set by driver (driverCollection or driverWithdrawal)

        await _isarService.saveTransactionRecord(txRecord);

        // Update MonkProfile's balance
        final monkProfile = await _isarService.getMonkProfileByPrimaryId(
          txRecord.monkPrimaryId,
        );
        if (monkProfile != null) {
          if (txRecord.type == TransactionType.deposit) {
            monkProfile.currentBalance += txRecord.amount;
          } else if (txRecord.type == TransactionType.withdrawal) {
            monkProfile.currentBalance -= txRecord.amount;
          }
          await _isarService.saveMonkProfile(monkProfile);
        }
        currentMonkTxCount++;
        state = state.copyWith(processedMonkTransactions: currentMonkTxCount);
      }

      // 3. Process Driver Expenses
      for (final expenseRecord in driverExpenses) {
        // Ensure expense is linked to the correct driver
        expenseRecord.driverPrimaryId = submittingDriverId;
        // Mark as processed by treasurer (if needed, or handle reconciliation logic)
        await _isarService.saveDriverExpenseRecord(expenseRecord);
        currentDriverExCount++;
        state = state.copyWith(processedDriverExpenses: currentDriverExCount);
      }

      // Refresh relevant notifiers
      await _ref.read(monkAccountNotifierProvider.notifier).loadMonks();
      // Potentially refresh driver account if their balance/expenses are directly affected by this import
      // await _ref.read(driverAccountNotifierProvider.notifier).loadDrivers();

      state = state.copyWith(
        isLoading: false,
        successMessage: 'ประมวลผลข้อมูลจากคนขับรถสำเร็จ!',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'เกิดข้อผิดพลาด: ${e.toString()}',
      );
      debugPrint('Error processing driver submission: $e');
    }
  }
}

final treasurerDataProcessingNotifierProvider =
    StateNotifierProvider<TreasurerDataProcessingNotifier, DataProcessingState>(
      (ref) {
        final isarService = ref.watch(isarServiceProvider);
        return TreasurerDataProcessingNotifier(isarService, ref);
      },
    );
