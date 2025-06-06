import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/data/datasources/local/isar_service.dart';
import 'package:money/data/models/app_user.dart';
import 'package:money/data/models/driver_profile.dart';
import 'package:money/services/encryption_service.dart';
import 'package:money/data/datasources/local/isar_service_provider.dart';
import 'package:money/data/models/driver_expense_record.dart';
import 'package:money/data/models/central_fund_transaction.dart';
import 'package:money/services/encryption_service_provider.dart';
// Assuming a similar form mode enum might be used for drivers
// import 'package:money/features/treasurer/screens/driver_management/driver_add_edit_screen.dart';

// State for Driver Account Operations
@immutable
class DriverAccountState {
  final bool isLoading;
  final String? errorMessage;
  final List<DriverProfile> drivers;

  const DriverAccountState({
    this.isLoading = false,
    this.errorMessage,
    this.drivers = const [],
  });

  DriverAccountState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<DriverProfile>? drivers,
    bool clearError = false,
  }) {
    return DriverAccountState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      drivers: drivers ?? this.drivers,
    );
  }
}

class DriverAccountNotifier extends StateNotifier<DriverAccountState> {
  final IsarService _isarService;
  final EncryptionService _encryptionService;

  DriverAccountNotifier(this._isarService, this._encryptionService)
    : super(const DriverAccountState()) {
    loadDrivers();
  }

  Future<void> loadDrivers() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final driverList = await _isarService.getAllDriverProfiles();
      state = state.copyWith(isLoading: false, drivers: driverList);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'ไม่สามารถโหลดข้อมูลคนขับรถได้: $e',
      );
      debugPrint('Error loading drivers: $e');
    }
  }

  Future<String> _generateUniqueDriverId(int length) async {
    const chars = '0123456789';
    final random = Random();
    String id;
    AppUser? existingAppUser;
    DriverProfile? existingDriverProfile;

    do {
      id = String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => chars.codeUnitAt(random.nextInt(chars.length)),
        ),
      );
      existingAppUser =
          await _isarService.getAppUserByPrimaryId(id) ??
          await _isarService.getAppUserBySecondaryId(id);
      existingDriverProfile = await _isarService.getDriverProfileByPrimaryId(
        id,
      );
      // We might also need a getDriverProfileBySecondaryId if driverSecondaryId is also indexed
    } while (existingAppUser != null || existingDriverProfile != null);
    return id;
  }

  Future<bool> saveDriver({
    required bool
    isEditMode, // Using bool for simplicity, can use enum like MonkFormMode
    int? existingDriverIsarId,
    String? existingDriverAppUserPrimaryId,
    required String name,
    String? contactInfo,
    // Driver-specific fields like license number can be added here
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      String driverPrimaryId;
      String driverSecondaryId;
      AppUser? appUser;

      if (!isEditMode) {
        // Add mode
        driverPrimaryId = await _generateUniqueDriverId(
          5,
        ); // Driver IDs are 5 digits
        do {
          driverSecondaryId = await _generateUniqueDriverId(5);
        } while (driverSecondaryId == driverPrimaryId);

        final defaultPassword =
            "driver_${driverPrimaryId}_default"; // Example default
        final hashedPassword = _encryptionService.hashPassword(defaultPassword);

        appUser = AppUser()
          ..primaryId = driverPrimaryId
          ..secondaryId = driverSecondaryId
          ..hashedPassword = hashedPassword
          ..role = UserRole.driver
          ..displayName = name;

        await _isarService.saveAppUser(appUser);
      } else {
        // Edit mode
        if (existingDriverIsarId == null ||
            existingDriverAppUserPrimaryId == null) {
          throw Exception(
            "Isar ID และ AppUser Primary ID ของคนขับรถต้องระบุสำหรับการแก้ไข",
          );
        }
        final existingDriverProfile = await _isarService.drivers.get(
          existingDriverIsarId,
        );
        if (existingDriverProfile == null) {
          throw Exception("ไม่พบข้อมูลคนขับรถที่ต้องการแก้ไข");
        }
        driverPrimaryId = existingDriverProfile.driverPrimaryId;
        // driverSecondaryId = existingDriverProfile.driverSecondaryId ?? ''; // If drivers have secondary IDs in their profile

        appUser = await _isarService.getAppUserByPrimaryId(
          existingDriverAppUserPrimaryId,
        );
        if (appUser != null) {
          if (appUser.displayName != name) {
            appUser.displayName = name;
            await _isarService.saveAppUser(appUser);
          }
        } else {
          debugPrint(
            "Warning: AppUser not found for driverPrimaryId $existingDriverAppUserPrimaryId during edit.",
          );
        }
      }

      DriverProfile driverProfile;
      if (!isEditMode) {
        driverProfile = DriverProfile()
          ..driverPrimaryId = driverPrimaryId
          // ..driverSecondaryId = driverSecondaryId // If applicable
          ..name = name
          ..contactInfo = contactInfo
          ..travelAdvanceBalance =
              0 // Initial travel advance
          ..appUser.value = appUser;
      } else {
        driverProfile = (await _isarService.drivers.get(existingDriverIsarId!))!
          ..name = name
          ..contactInfo = contactInfo;
      }

      await _isarService.saveDriverProfile(driverProfile);
      await loadDrivers();
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      debugPrint('Error saving driver: $e');
      return false;
    }
  }

  Future<bool> updateDriverAdvance({
    required int driverIsarId, // Isar ID of the DriverProfile
    required int amountChange, // Changed to int
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final driverProfile = await _isarService.drivers.get(driverIsarId);
      if (driverProfile == null) {
        throw Exception("ไม่พบข้อมูลคนขับรถ ID: $driverIsarId");
      }

      driverProfile.travelAdvanceBalance +=
          amountChange; // Use travelAdvanceBalance
      driverProfile.lastTravelAdvanceUpdateAt =
          DateTime.now(); // Update timestamp
      await _isarService.saveDriverProfile(driverProfile);

      // Reload drivers to reflect the change in the list if displayed elsewhere
      await loadDrivers();
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      debugPrint('Error updating driver advance: $e');
      return false;
    }
  }

  Future<bool> deleteDriver(
    int driverIsarId,
    String driverAppUserPrimaryId,
  ) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final appUser = await _isarService.getAppUserByPrimaryId(
        driverAppUserPrimaryId,
      );
      if (appUser != null) {
        await _isarService.users.delete(appUser.id);
      } else {
        debugPrint(
          "Warning: AppUser not found for driver $driverAppUserPrimaryId during deletion.",
        );
      }

      final success = await _isarService.deleteDriverProfile(driverIsarId);
      if (success) {
        await loadDrivers();
      }
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      debugPrint('Error deleting driver: $e');
      return false;
    }
  }
}

// Provider for DriverAccountNotifier
final driverAccountNotifierProvider =
    StateNotifierProvider<DriverAccountNotifier, DriverAccountState>((ref) {
      final isarService = ref.watch(isarServiceProvider);
      final encryptionService = ref.watch(encryptionServiceProvider);
      return DriverAccountNotifier(isarService, encryptionService);
    });

// Provider to fetch expense history for a specific driver
final driverExpenseHistoryProvider =
    FutureProvider.family<List<DriverExpenseRecord>, String>((
      ref,
      driverPrimaryId,
    ) async {
      final isarService = ref.watch(isarServiceProvider);
      return isarService.getExpensesForDriver(driverPrimaryId);
    });

// Provider to fetch central fund transactions related to a specific driver
final driverCentralFundTransactionsProvider =
    FutureProvider.family<List<CentralFundTransaction>, String>((
      ref,
      driverPrimaryId,
    ) async {
      final isarService = ref.watch(isarServiceProvider);
      return isarService.getCentralFundTransactionsForDriver(driverPrimaryId);
    });
