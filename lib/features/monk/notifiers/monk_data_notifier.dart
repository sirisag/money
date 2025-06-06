import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/data/datasources/local/isar_service.dart';
import 'package:money/data/models/monk_profile.dart';
import 'package:money/data/models/transaction_record.dart';
import 'package:money/data/models/app_user.dart'; // For current monk user
import 'package:money/data/datasources/local/isar_service_provider.dart';
import 'package:money/features/auth/notifiers/auth_notifier.dart'; // To get current monk
import 'package:money/data/datasources/file/file_data_service.dart'; // For AppDataFile

@immutable
class MonkDataState {
  final bool isLoading;
  final String? errorMessage;
  final MonkProfile? monkProfile; // Current monk's profile data
  final List<TransactionRecord> transactions;
  final DateTime? lastImportDate;

  const MonkDataState({
    this.isLoading = false,
    this.errorMessage,
    this.monkProfile,
    this.transactions = const [],
    this.lastImportDate,
  });

  MonkDataState copyWith({
    bool? isLoading,
    String? errorMessage,
    MonkProfile? monkProfile,
    List<TransactionRecord>? transactions,
    DateTime? lastImportDate,
    bool clearError = false,
    bool clearProfile = false,
  }) {
    return MonkDataState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      monkProfile: clearProfile ? null : monkProfile ?? this.monkProfile,
      transactions: transactions ?? this.transactions,
      lastImportDate: lastImportDate ?? this.lastImportDate,
    );
  }
}

class MonkDataNotifier extends StateNotifier<MonkDataState> {
  final IsarService _isarService;
  final AppUser _currentMonkUser;

  MonkDataNotifier(this._isarService, this._currentMonkUser)
    : super(const MonkDataState()) {
    loadMonkData();
  }

  Future<void> loadMonkData() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final profile = await _isarService.getMonkProfileByPrimaryId(
        _currentMonkUser.primaryId,
      );
      final txs = await _isarService.getTransactionsForMonk(
        _currentMonkUser.primaryId,
      );
      // TODO: Load lastImportDate from a persistent storage if needed
      state = state.copyWith(
        isLoading: false,
        monkProfile: profile,
        transactions: txs,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'ไม่สามารถโหลดข้อมูลพระได้: $e',
      );
    }
  }

  Future<bool> processImportedData(AppDataFile importedDataFile) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      // Expecting data specifically for this monk
      if (importedDataFile.data['monkProfiles'] != null) {
        final List<dynamic> monksJsonList = jsonDecode(
          importedDataFile.data['monkProfiles'] as String,
        );
        final incomingMonkProfile = MonkProfile.fromJson(
          monksJsonList.first as Map<String, dynamic>,
        ); // Assuming only one monk's data

        if (incomingMonkProfile.monkPrimaryId == _currentMonkUser.primaryId) {
          await _isarService.saveMonkProfile(
            incomingMonkProfile,
          ); // This will update if exists
        }
      }
      if (importedDataFile.data['transactionRecords'] != null) {
        final List<dynamic> txJsonList = jsonDecode(
          importedDataFile.data['transactionRecords'] as String,
        );
        final List<TransactionRecord> incomingTransactions = txJsonList
            .map(
              (json) =>
                  TransactionRecord.fromJson(json as Map<String, dynamic>),
            )
            .toList();
        // For simplicity, replace all transactions for this monk. A merge strategy might be needed in complex cases.
        await _isarService.transactions
            .filter()
            .monkPrimaryIdEqualTo(_currentMonkUser.primaryId)
            .deleteAll();
        await _isarService.transactions.putAll(incomingTransactions);
      }
      await loadMonkData(); // Reload all data
      state = state.copyWith(isLoading: false, lastImportDate: DateTime.now());
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "เกิดข้อผิดพลาดในการนำเข้าข้อมูล: $e",
      );
      return false;
    }
  }
}

final monkDataNotifierProvider =
    StateNotifierProvider<MonkDataNotifier, MonkDataState>((ref) {
      final isarService = ref.watch(isarServiceProvider);
      final currentMonk = ref.watch(authNotifierProvider).currentUser;
      if (currentMonk == null || currentMonk.role != UserRole.monk) {
        throw Exception("MonkDataNotifier requires a logged-in monk.");
      }
      return MonkDataNotifier(isarService, currentMonk);
    });
