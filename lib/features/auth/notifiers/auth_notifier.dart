import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../data/datasources/local/isar_service.dart';
import '../../../data/models/app_user.dart';
import '../../../services/encryption_service.dart';
import '../../../data/datasources/local/isar_service_provider.dart'; // Import IsarService Provider
import '../../../services/encryption_service_provider.dart'; // Import EncryptionService Provider

// Enum to represent the current authentication status
enum AuthStatus { unknown, unauthenticated, authenticated, firstTimeSetup }

// Data class to hold the authentication state
@immutable
class AuthState {
  final AuthStatus status;
  final AppUser? currentUser;
  final UserRole? currentRole;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.currentUser,
    this.currentRole,
  });

  AuthState copyWith({
    AuthStatus? status,
    AppUser? currentUser,
    UserRole? currentRole,
    bool clearCurrentUser = false, // Flag to explicitly set currentUser to null
    bool clearCurrentRole = false, // Flag to explicitly set currentRole to null
  }) {
    return AuthState(
      status: status ?? this.status,
      currentUser: clearCurrentUser ? null : currentUser ?? this.currentUser,
      currentRole: clearCurrentRole ? null : currentRole ?? this.currentRole,
    );
  }
}

// The Notifier for authentication state
class AuthNotifier extends Notifier<AuthState> {
  late IsarService _isarService;
  late EncryptionService _encryptionService;

  @override
  AuthState build() {
    // Initialize dependencies using ref.read to get instances from providers.
    // This is the correct way to access other providers within a Notifier.
    _isarService = ref.read(isarServiceProvider);
    _encryptionService = ref.read(encryptionServiceProvider);

    // Initial state
    Future.microtask(() => checkAuthStatus());
    return const AuthState();
  }

  Future<void> checkAuthStatus() async {
    final users = await _isarService.users.where().findAll();
    if (users.isEmpty) {
      state = state.copyWith(status: AuthStatus.firstTimeSetup);
    } else {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  Future<bool> performInitialSetup({
    required String primaryId,
    required String secondaryId,
    required String password,
    required UserRole role,
    String? displayName,
  }) async {
    try {
      final existingUserByPrimary = await _isarService.getAppUserByPrimaryId(
        primaryId,
      );
      if (existingUserByPrimary != null) {
        debugPrint("Error: Primary ID $primaryId already exists.");
        return false;
      }

      // Check if secondaryId already exists (as primary or secondary)
      // This assumes secondaryId must also be unique across all primary and secondary IDs.
      // Adjust logic if secondaryId only needs to be unique among secondaryIds or can be same as another user's primary.
      final existingUserBySecondaryAsPrimary = await _isarService
          .getAppUserByPrimaryId(secondaryId);
      if (existingUserBySecondaryAsPrimary != null &&
          existingUserBySecondaryAsPrimary.primaryId != primaryId) {
        debugPrint(
          "Error: Secondary ID $secondaryId conflicts with an existing Primary ID.",
        );
        return false;
      }
      final existingUserBySecondary = await _isarService
          .getAppUserBySecondaryId(secondaryId);
      if (existingUserBySecondary != null &&
          existingUserBySecondary.primaryId != primaryId) {
        debugPrint(
          "Error: Secondary ID $secondaryId already exists as a Secondary ID for another user.",
        );
        return false;
      }

      final hashedPassword = _encryptionService.hashPassword(password);
      final newUser = AppUser()
        ..primaryId = primaryId
        ..secondaryId = secondaryId
        ..hashedPassword = hashedPassword
        ..role = role
        ..displayName = displayName;

      await _isarService.saveAppUser(newUser);
      state = state.copyWith(
        // Change to unauthenticated to force login after setup,
        status: AuthStatus.unauthenticated,
        clearCurrentUser: true, // Clear current user if going to login
        clearCurrentRole: true, // Clear current role if going to login
      );
      return true;
    } catch (e) {
      debugPrint("Error during initial setup: $e");
      return false;
    }
  }

  Future<bool> login(String primaryId, String password) async {
    final user = await _isarService.getAppUserByPrimaryId(primaryId);
    if (user != null &&
        user.hashedPassword != null &&
        _encryptionService.verifyPassword(password, user.hashedPassword!)) {
      state = state.copyWith(
        status: AuthStatus.authenticated,
        currentUser: user,
        currentRole: user.role,
      );
      return true;
    }
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      clearCurrentUser: true,
      clearCurrentRole: true,
    );
    return false;
  }

  Future<void> logout() async {
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      clearCurrentUser: true,
      clearCurrentRole: true,
    );
  }

  Future<bool> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    if (state.currentUser == null) {
      debugPrint("No current user to change password for.");
      return false;
    }

    final user = state.currentUser!;
    if (user.hashedPassword == null) {
      debugPrint("User does not have a hashed password set.");
      // This might indicate an issue with user setup or data integrity
      return false;
    }

    // Verify current password
    if (!_encryptionService.verifyPassword(
      currentPassword,
      user.hashedPassword!,
    )) {
      debugPrint("Current password verification failed.");
      return false; // Current password does not match
    }

    // Hash the new password
    final newHashedPassword = _encryptionService.hashPassword(newPassword);
    user.hashedPassword = newHashedPassword;

    try {
      await _isarService.saveAppUser(user);
      return true;
    } catch (e) {
      debugPrint("Error saving new password: $e");
      return false;
    }
  }
}

// The Provider for AuthNotifier
final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
