import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/data/datasources/local/isar_service.dart';
import 'package:money/data/models/central_fund_transaction.dart';
import 'package:money/data/datasources/local/isar_service_provider.dart';

@immutable
class CentralFundState {
  final bool isLoading;
  final String? errorMessage;
  final List<CentralFundTransaction> transactions;
  final int currentBalance; // Changed to int

  const CentralFundState({
    this.isLoading = false,
    this.errorMessage,
    this.transactions = const [],
    this.currentBalance = 0,
  });

  CentralFundState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<CentralFundTransaction>? transactions,
    int? currentBalance, // Changed to int
    bool clearError = false,
  }) {
    return CentralFundState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      transactions: transactions ?? this.transactions,
      currentBalance: currentBalance ?? this.currentBalance,
    );
  }
}

class CentralFundNotifier extends StateNotifier<CentralFundState> {
  final IsarService _isarService;

  CentralFundNotifier(this._isarService) : super(const CentralFundState()) {
    loadCentralFundData();
  }

  Future<void> loadCentralFundData() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final transactions = await _isarService.getAllCentralFundTransactions();
      // Recalculate balance based on all transactions
      int calculatedBalance = 0;
      // Sort transactions by date to ensure correct balance calculation if storing running balance
      // For sum, order doesn't strictly matter but good for consistency
      final sortedTransactions = List<CentralFundTransaction>.from(transactions)
        ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

      for (final tx in sortedTransactions) {
        // Assuming positive amount for income types, negative for expense types in the model itself.
        // Or, adjust logic here based on tx.type
        calculatedBalance += tx.amount; // If amount already reflects +/-
      }

      // Note: For a more robust balance calculation, it's often better to sum up
      // all transactions every time or store a running balance carefully.
      // The current approach recalculates from all transactions.
      // Alternatively, the last transaction could store the running balance.

      // For simplicity, let's assume the balance is calculated by summing transactions.
      // A more accurate way would be to query Isar for sum or iterate.
      // Here, we'll just use the last transaction's running balance if available,
      // or calculate from scratch.
      state = state.copyWith(
        isLoading: false,
        transactions: transactions,
        currentBalance: calculatedBalance,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'ไม่สามารถโหลดข้อมูลกองกลางได้: $e',
      );
      debugPrint('Error loading central fund data: $e');
    }
  }

  Future<bool> recordTransaction({
    required CentralFundTransactionType type, // Corrected enum name
    required int amount, // Changed to int
    required String description,
    String? relatedToDriverId, // For driver advances/returns
    String? relatedToMonkId, // For specific monk related central fund ops
    required DateTime dateTime,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final newTransaction = CentralFundTransaction()
        ..type = type
        ..description = description
        ..relatedToDriverId = relatedToDriverId
        ..relatedToMonkId =
            relatedToMonkId // Moved here
        ..dateTime = dateTime;

      // Adjust amount sign based on type if model stores all amounts as positive
      if (type == CentralFundTransactionType.donation ||
          type == CentralFundTransactionType.receiveDriverAdvanceReturn) {
        newTransaction.amount = amount;
      } else {
        newTransaction.amount = -amount; // Expenses are negative
      }

      await _isarService.saveCentralFundTransaction(newTransaction);
      await loadCentralFundData(); // Reload data to update list and balance
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      debugPrint('Error recording central fund transaction: $e');
      return false;
    }
  }
}

final centralFundNotifierProvider =
    StateNotifierProvider<CentralFundNotifier, CentralFundState>((ref) {
      final isarService = ref.watch(isarServiceProvider);
      return CentralFundNotifier(isarService);
    });
