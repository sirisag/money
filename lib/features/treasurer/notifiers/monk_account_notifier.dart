import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/data/datasources/local/isar_service.dart';
import 'package:money/data/models/app_user.dart';
import 'package:money/data/models/monk_profile.dart';
import 'package:money/services/encryption_service.dart'; // For hashing a default password if needed
import 'package:money/data/datasources/local/isar_service_provider.dart';
import 'package:money/data/models/transaction_record.dart'; // For TransactionType and TransactionSource
import 'package:money/services/encryption_service_provider.dart';
import 'package:money/features/treasurer/screens/monk_management/monk_add_edit_screen.dart'; // For MonkFormMode

// State for Monk Account Operations
@immutable
class MonkAccountState {
  final bool isLoading;
  final String? errorMessage;
  final List<MonkProfile> monks; // To hold the list of monks

  const MonkAccountState({
    this.isLoading = false,
    this.errorMessage,
    this.monks = const [],
  });

  MonkAccountState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<MonkProfile>? monks,
    bool clearError = false,
  }) {
    return MonkAccountState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      monks: monks ?? this.monks,
    );
  }
}

class MonkAccountNotifier extends StateNotifier<MonkAccountState> {
  final IsarService _isarService;
  final EncryptionService _encryptionService; // For default password hashing

  MonkAccountNotifier(this._isarService, this._encryptionService)
    : super(const MonkAccountState()) {
    loadMonks(); // Load monks when notifier is initialized
  }

  Future<void> loadMonks() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final monksList = await _isarService.getAllMonkProfiles();
      state = state.copyWith(isLoading: false, monks: monksList);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'ไม่สามารถโหลดข้อมูลพระได้: $e',
      );
      debugPrint('Error loading monks: $e');
    }
  }

  Future<String> _generateUniqueMonkId(int length) async {
    const chars = '0123456789';
    final random = Random();
    String id;
    AppUser? existingAppUser;
    MonkProfile? existingMonkProfile;

    do {
      id = String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => chars.codeUnitAt(random.nextInt(chars.length)),
        ),
      );
      // Check against AppUser primary/secondary and MonkProfile primary/secondary
      existingAppUser =
          await _isarService.getAppUserByPrimaryId(id) ??
          await _isarService.getAppUserBySecondaryId(id);
      existingMonkProfile = await _isarService.getMonkProfileByPrimaryId(id);
      // We might also need a getMonkProfileBySecondaryId if monkSecondaryId is also indexed and checked for uniqueness
    } while (existingAppUser != null || existingMonkProfile != null);
    return id;
  }

  Future<bool> saveMonk({
    required MonkFormMode mode,
    int? existingMonkIsarId, // Isar ID of MonkProfile for editing
    String? existingMonkAppUserPrimaryId, // AppUser primary ID for editing
    required String name,
    String? contactInfo,
    required MonkAccountStatus status,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      String monkPrimaryId;
      String monkSecondaryId;
      AppUser? appUser;

      if (mode == MonkFormMode.add) {
        // Generate unique IDs for new monk
        monkPrimaryId = await _generateUniqueMonkId(6);
        do {
          monkSecondaryId = await _generateUniqueMonkId(6);
        } while (monkSecondaryId == monkPrimaryId);

        // Create AppUser for the monk (for system consistency, even if they don't log in)
        // A default password or a more secure mechanism should be considered.
        // For simplicity, let's use a default hashed password.
        final defaultPassword =
            "monk_${monkPrimaryId}_default"; // Example default
        final hashedPassword = _encryptionService.hashPassword(defaultPassword);

        appUser = AppUser()
          ..primaryId = monkPrimaryId
          ..secondaryId = monkSecondaryId
          ..hashedPassword =
              hashedPassword // Store hashed default password
          ..role = UserRole.monk
          ..displayName = name; // Monk's name as display name

        await _isarService.saveAppUser(appUser);
      } else {
        // Editing existing monk
        if (existingMonkIsarId == null ||
            existingMonkAppUserPrimaryId == null) {
          throw Exception(
            "Isar ID และ AppUser Primary ID ของพระต้องระบุสำหรับการแก้ไข",
          );
        }
        final existingMonkProfile = await _isarService.monks.get(
          existingMonkIsarId,
        );
        if (existingMonkProfile == null) {
          throw Exception("ไม่พบข้อมูลพระที่ต้องการแก้ไข");
        }
        monkPrimaryId = existingMonkProfile.monkPrimaryId;
        monkSecondaryId =
            existingMonkProfile.monkSecondaryId ??
            ''; // Handle if secondaryId was null

        // Update AppUser's displayName if it changed
        appUser = await _isarService.getAppUserByPrimaryId(
          existingMonkAppUserPrimaryId,
        );
        if (appUser != null) {
          if (appUser.displayName != name) {
            appUser.displayName = name;
            await _isarService.saveAppUser(appUser);
          }
        } else {
          // This case should ideally not happen if data is consistent
          debugPrint(
            "Warning: AppUser not found for monkPrimaryId $existingMonkAppUserPrimaryId during edit.",
          );
        }
      }

      // Create or Update MonkProfile
      MonkProfile monkProfile;
      if (mode == MonkFormMode.add) {
        monkProfile = MonkProfile()
          ..monkPrimaryId = monkPrimaryId
          ..monkSecondaryId = monkSecondaryId
          ..nameOrTitle = name
          ..contactInfo = contactInfo
          ..status = status
          ..currentBalance =
              0 // Initial balance
          ..appUser.value = appUser; // Link to AppUser
      } else {
        // Fetch existing MonkProfile to update
        monkProfile = (await _isarService.monks.get(existingMonkIsarId!))!
          ..nameOrTitle = name
          ..contactInfo = contactInfo
          ..status = status;
        // appUser link should already exist
      }

      await _isarService.saveMonkProfile(monkProfile);
      await loadMonks(); // Refresh the list
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      debugPrint('Error saving monk: $e');
      return false;
    }
  }

  Future<bool> recordDirectMonkTransaction({
    required String monkPrimaryId,
    required TransactionType type,
    required int amount, // Changed to int
    required String description,
    required DateTime dateTime,
    required AppUser treasurerUser,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final monkProfile = await _isarService.getMonkProfileByPrimaryId(
        monkPrimaryId,
      );
      if (monkProfile == null) {
        throw Exception('ไม่พบข้อมูลพระ ID: $monkPrimaryId');
      }

      final newTransaction = TransactionRecord()
        ..monkPrimaryId = monkPrimaryId
        ..type = type
        ..amount = amount
        ..description = description
        ..dateTime = dateTime
        ..source = TransactionSource
            .directTreasurer // Transaction by treasurer
        ..processedByUserId = treasurerUser.primaryId
        ..processedByUserRole = treasurerUser.role;

      await _isarService.saveTransactionRecord(newTransaction);

      // Update MonkProfile's balance
      if (type == TransactionType.deposit) {
        monkProfile.currentBalance += amount;
      } else {
        // Withdrawal
        monkProfile.currentBalance -= amount;
      }
      await _isarService.saveMonkProfile(monkProfile);

      // Reload monks to reflect the balance change in lists/UI
      await loadMonks();

      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      debugPrint('Error recording direct monk transaction: $e');
      return false;
    }
  }

  // Method to delete a monk (optional, implement if needed)
  Future<bool> deleteMonk(int monkIsarId, String monkAppUserPrimaryId) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      // First, delete the AppUser associated with the monk
      final appUser = await _isarService.getAppUserByPrimaryId(
        monkAppUserPrimaryId,
      );
      if (appUser != null) {
        await _isarService.users.delete(appUser.id);
      } else {
        debugPrint(
          "Warning: AppUser not found for monk $monkAppUserPrimaryId during deletion.",
        );
      }

      // Then, delete the MonkProfile
      final success = await _isarService.deleteMonkProfile(monkIsarId);
      if (success) {
        await loadMonks(); // Refresh the list
      }
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      debugPrint('Error deleting monk: $e');
      return false;
    }
  }
}

// Provider for MonkAccountNotifier
final monkAccountNotifierProvider =
    StateNotifierProvider<MonkAccountNotifier, MonkAccountState>((ref) {
      final isarService = ref.watch(isarServiceProvider);
      final encryptionService = ref.watch(encryptionServiceProvider);
      return MonkAccountNotifier(isarService, encryptionService);
    });

// Provider to fetch transaction history for a specific monk
final monkTransactionHistoryProvider =
    FutureProvider.family<List<TransactionRecord>, String>((
      ref,
      monkPrimaryId,
    ) async {
      final isarService = ref.watch(isarServiceProvider);
      return isarService.getTransactionsForMonk(monkPrimaryId);
    });
