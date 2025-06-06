import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/data/datasources/local/isar_service.dart';
import 'package:money/data/models/transaction_record.dart';
import 'package:money/data/models/driver_expense_record.dart';
import 'package:money/data/models/app_user.dart'; // For current driver user
import 'package:money/data/datasources/local/isar_service_provider.dart';
import 'package:money/data/models/driver_profile.dart';
import 'package:money/data/models/monk_profile.dart';
import 'package:money/features/auth/notifiers/auth_notifier.dart'; // To get current driver
import 'package:money/data/datasources/file/file_data_service.dart'; // Corrected import for FileDataService and its provider
import 'package:package_info_plus/package_info_plus.dart'; // For app version
import 'dart:convert'; // For jsonEncode

@immutable
class DriverDataState {
  final bool isLoading;
  final String? errorMessage;
  final List<TransactionRecord> pendingMonkTransactions;
  final List<DriverExpenseRecord> pendingDriverExpenses;
  // Add other driver-specific data states here if needed

  const DriverDataState({
    this.isLoading = false,
    this.errorMessage,
    this.pendingMonkTransactions = const [],
    this.pendingDriverExpenses = const [],
  });

  DriverDataState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<TransactionRecord>? pendingMonkTransactions,
    List<DriverExpenseRecord>? pendingDriverExpenses,
    bool clearError = false,
  }) {
    return DriverDataState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      pendingMonkTransactions:
          pendingMonkTransactions ?? this.pendingMonkTransactions,
      pendingDriverExpenses:
          pendingDriverExpenses ?? this.pendingDriverExpenses,
    );
  }
}

class DriverDataNotifier extends StateNotifier<DriverDataState> {
  final IsarService _isarService;
  final AppUser _currentDriver; // Store the current driver
  final Ref _ref; // Add Ref
  PackageInfo? _packageInfo; // To store package info

  DriverDataNotifier(
    this._isarService,
    this._currentDriver,
    this._ref,
  ) // Modify constructor
  : super(const DriverDataState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    _packageInfo = await PackageInfo.fromPlatform();
    await loadPendingData();
  }

  // Public getter for the current driver
  AppUser get currentDriver => _currentDriver;

  Future<void> loadPendingData() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      // Load transactions recorded by this driver that are not yet "fully processed" by treasurer
      // This might need a specific flag in TransactionRecord or a different way to identify them.
      // For now, let's assume we load all transactions linked to this driver.
      // A more robust system would filter by a status like 'pending_export'.
      // Use the specific method from IsarService
      final monkTransactions = await _isarService.getTransactionsForDriver(
        _currentDriver.primaryId,
      );

      final driverExpenses = await _isarService.getExpensesForDriver(
        _currentDriver.primaryId,
      );

      state = state.copyWith(
        isLoading: false,
        pendingMonkTransactions: monkTransactions,
        pendingDriverExpenses: driverExpenses
            .where((e) => !e.exportedToTreasurer)
            .toList(), // Only those not yet exported
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'ไม่สามารถโหลดข้อมูลที่รอส่งได้: $e',
      );
      debugPrint('Error loading driver pending data: $e');
    }
  }

  Future<bool> recordMonkTransactionByDriver({
    required String monkPrimaryId,
    required TransactionType type,
    required int amount, // Changed to int
    required String description,
    required DateTime dateTime,
    bool driverCovered = false, // For withdrawals
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final newTransaction = TransactionRecord()
        ..monkPrimaryId = monkPrimaryId
        ..driverPrimaryId = _currentDriver
            .primaryId // Current driver records this
        ..type = type
        ..amount = amount
        ..description = description
        ..dateTime = dateTime
        ..source = type == TransactionType.deposit
            ? TransactionSource.driverCollection
            : TransactionSource.driverWithdrawal
        ..processedByUserId = _currentDriver
            .primaryId // Initially processed by driver
        ..processedByUserRole = _currentDriver.role
        ..driverCovered = (type == TransactionType.withdrawal)
            ? driverCovered
            : false;

      await _isarService.saveTransactionRecord(newTransaction);
      await loadPendingData(); // Refresh pending list
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      debugPrint('Error recording monk transaction by driver: $e');
      return false;
    }
  }

  Future<bool> recordDriverExpense({
    required String expenseType,
    required int amount, // Amount in Baht (integer)
    required DateTime date,
    String? details,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final newExpense = DriverExpenseRecord()
        ..driverPrimaryId = _currentDriver.primaryId
        ..expenseType = expenseType
        ..amount = amount
        ..date = date
        ..details = details
        ..exportedToTreasurer = false; // New expenses are not yet exported

      await _isarService.saveDriverExpenseRecord(newExpense);
      await loadPendingData(); // Refresh pending list
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      debugPrint('Error recording driver expense: $e');
      return false;
    }
  }

  // Returns plain JSON string, encryption will be handled by FileStorageService in UI
  String? prepareDataForExport() {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      // Use the already loaded pending data from the state
      final List<TransactionRecord> transactionsToExport = List.from(
        state.pendingMonkTransactions,
      );
      final List<DriverExpenseRecord> expensesToExport = List.from(
        state.pendingDriverExpenses.where((e) => !e.exportedToTreasurer),
      );

      if (transactionsToExport.isEmpty && expensesToExport.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: "ไม่มีข้อมูลสำหรับส่งออก",
        );
        return null;
      }

      if (_packageInfo == null) {
        throw Exception("PackageInfo not initialized");
      }
      String appVersion = _packageInfo!.version;

      // Serialize data
      // Note: FileDataService is not directly available here.
      // We need to either pass it or do serialization here.
      // For simplicity, let's do basic serialization here.
      // In a larger app, FileDataService might be accessed via ref.read if this notifier becomes a Riverpod provider.
      // However, this is a StateNotifier, so direct access to other providers is via constructor or method params.

      final fileDataService = _ref.read(
        fileDataServiceProvider,
      ); // Assuming _ref is available if this becomes a Riverpod provider
      // Or, pass FileDataService instance if not.
      // For now, let's assume we can access it via _ref (needs adjustment if not)
      // If not, the screen will call FileDataService.

      final Map<String, dynamic> dataPayload = {
        "driverPrimaryId":
            _currentDriver.primaryId, // Include driver's ID in the payload
        "monkTransactions": fileDataService.serializeTransactionRecords(
          transactionsToExport,
        ),
        "driverExpenses": fileDataService.serializeDriverExpenseRecords(
          expensesToExport,
        ),
      };

      final plainJsonContent = fileDataService.createExportFileContent(
        appVersion: appVersion,
        fileFormatVersion: "1.0_driver_submission",
        createdByRole: _currentDriver.role,
        createdById: _currentDriver.primaryId,
        dataPayload: dataPayload,
      );
      state = state.copyWith(isLoading: false);
      return plainJsonContent;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      debugPrint('Error preparing data for export: $e');
      return null;
    }
  }

  /// Marks expenses as exported and reloads pending data.
  /// Call this after the file has been successfully saved/shared by the UI.
  Future<void> finalizeExpenseExport(
    List<DriverExpenseRecord> exportedExpenses,
  ) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      for (final expense in exportedExpenses) {
        expense.exportedToTreasurer = true;
        await _isarService.saveDriverExpenseRecord(expense);
      }
      await loadPendingData(); // Refresh the list of pending items
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Error finalizing expense export: $e",
      );
      debugPrint('Error finalizing expense export: $e');
    }
  }

  Future<bool> processTreasurerUpdateFile(
    AppDataFile treasurerUpdateFile,
  ) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      // Validate if the file is intended for this driver
      // The treasurer's update file might contain a 'driverRecipientId' or similar.
      // For now, we assume the driver is importing the correct file.

      // Extract data from treasurerUpdateFile.data
      // The structure depends on what the treasurer exports in their update file.
      // Example structure:
      // {
      //   "additional_travel_advance_issued": 500,
      //   "driver_travel_advance_balance_updated_by_treasurer": 1500,
      //   "updated_monk_list_if_any": "[{...monk1...}, {...monk2...}]" // JSON string of MonkProfile list
      //   "monk_fund_transaction_outcomes": "[{...outcome1...}]" // JSON string of outcomes
      // }

      final data = treasurerUpdateFile.data;
      bool balanceUpdated = false;

      if (data['driver_travel_advance_balance_updated_by_treasurer'] != null) {
        final newBalance =
            (data['driver_travel_advance_balance_updated_by_treasurer'] as num)
                .toInt();
        final driverProfile = await _isarService.getDriverProfileByPrimaryId(
          _currentDriver.primaryId,
        );
        if (driverProfile != null) {
          driverProfile.travelAdvanceBalance = newBalance;
          driverProfile.lastTravelAdvanceUpdateAt = DateTime.now();
          await _isarService.saveDriverProfile(driverProfile);
          balanceUpdated = true;
        }
      }

      if (data['additional_travel_advance_issued'] != null) {
        final additionalAdvance =
            (data['additional_travel_advance_issued'] as num).toInt();
        if (additionalAdvance > 0 && !balanceUpdated) {
          // Avoid double update if full balance was sent
          final driverProfile = await _isarService.getDriverProfileByPrimaryId(
            _currentDriver.primaryId,
          );
          if (driverProfile != null) {
            driverProfile.travelAdvanceBalance += additionalAdvance;
            driverProfile.lastTravelAdvanceUpdateAt = DateTime.now();
            await _isarService.saveDriverProfile(driverProfile);
          }
        }
      }

      if (data['updated_monk_list_if_any'] != null) {
        final List<dynamic> monkListJson = jsonDecode(
          data['updated_monk_list_if_any'] as String,
        );
        final List<MonkProfile> updatedMonks = monkListJson
            .map((json) => MonkProfile.fromJson(json as Map<String, dynamic>))
            .toList();
        // Here, you'd typically update your local monk list.
        // This might involve clearing existing local monk data and saving the new list,
        // or a more sophisticated merge. For simplicity, let's assume replacing.
        // This part depends on how drivers store/manage monk lists.
        debugPrint(
          "Received updated monk list with ${updatedMonks.length} monks. (Implementation for saving needed)",
        );
      }

      await loadPendingData(); // Refresh data, including new balance
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Error processing treasurer update: $e",
      );
      debugPrint("Error processing treasurer update file: $e");
      return false;
    }
  }
}

final driverDataNotifierProvider =
    StateNotifierProvider<DriverDataNotifier, DriverDataState>((ref) {
      final isarService = ref.watch(isarServiceProvider);
      final currentDriver = ref.watch(authNotifierProvider).currentUser;
      if (currentDriver == null || currentDriver.role != UserRole.driver) {
        // This should not happen if routing is correct, but as a safeguard:
        throw Exception("DriverDataNotifier requires a logged-in driver.");
      }
      return DriverDataNotifier(isarService, currentDriver, ref); // Pass ref
    });
