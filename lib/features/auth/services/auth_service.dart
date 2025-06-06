import 'package:flutter/foundation.dart'; // For ChangeNotifier (if used for state)
import 'package:isar/isar.dart';
import 'package:encrypt/encrypt.dart' as encrypt_lib; // Alias to avoid conflict

import '../../../data/datasources/local/isar_service.dart';
import '../../../data/models/app_user.dart';
import '../../../services/encryption_service.dart'; // We'll create this later

// Enum to represent the current authentication status
enum AuthStatus { unknown, unauthenticated, authenticated, firstTimeSetup }

class AuthService with ChangeNotifier {
  final IsarService _isarService;
  final EncryptionService _encryptionService; // For password hashing

  AuthService(this._isarService, this._encryptionService);

  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;

  UserRole? _currentRole;
  UserRole? get currentRole => _currentRole;

  AuthStatus _authStatus = AuthStatus.unknown;
  AuthStatus get authStatus => _authStatus;

  Future<void> checkAuthStatus() async {
    // In a real app, you might check SharedPreferences or SecureStorage
    // to see if a user was previously logged in or if setup was completed.
    // For now, let's assume we check if any AppUser exists.
    final users = await _isarService.users.where().findAll();
    if (users.isEmpty) {
      _authStatus = AuthStatus.firstTimeSetup;
    } else {
      // For simplicity, assume if users exist, one of them might be logged in.
      // A more robust check would involve secure storage for session tokens or last logged-in user.
      // For now, if users exist, we'll require login.
      _authStatus = AuthStatus.unauthenticated;
      // If you had a way to know the last logged-in user and role:
      // _currentUser = lastLoggedInUser;
      // _currentRole = lastLoggedInUser.role;org.gradle.jvmargs=-Xmx2048m -XX:MaxPermSize=512m # ตัวอย่าง เพิ่มเป็น 2GB

      // _authStatus = AuthStatus.authenticated;
    }
    notifyListeners();
  }

  Future<bool> performInitialSetup({
    required String primaryId,
    required String secondaryId,
    required String password, // Plain text password
    required UserRole role,
    String? displayName, // For treasurer and driver
  }) async {
    try {
      // Check if primaryId or secondaryId already exists
      final existingUserByPrimary = await _isarService.getAppUserByPrimaryId(
        primaryId,
      );
      if (existingUserByPrimary != null) {
        // Handle error: Primary ID already exists
        debugPrint("Error: Primary ID $primaryId already exists.");
        return false;
      }
      // We might also want to check secondaryId for uniqueness if it's a strict requirement

      final hashedPassword = _encryptionService.hashPassword(password);

      final newUser = AppUser()
        ..primaryId = primaryId
        ..secondaryId = secondaryId
        ..hashedPassword = hashedPassword
        ..role = role
        ..displayName = displayName;

      await _isarService.saveAppUser(newUser);

      // If role is monk or driver, create their specific profiles too (simplified for now)
      // This logic would be more complex, involving data from treasurer for IDs

      _currentUser = newUser;
      _currentRole = newUser.role;
      _authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Error during initial setup: $e");
      return false;
    }
  }

  Future<bool> login(String primaryId, String password) async {
    final user = await _isarService.getAppUserByPrimaryId(primaryId);
    if (user != null && user.hashedPassword != null) {
      if (_encryptionService.verifyPassword(password, user.hashedPassword!)) {
        _currentUser = user;
        _currentRole = user.role;
        _authStatus = AuthStatus.authenticated;
        notifyListeners();
        return true;
      }
    }
    _authStatus = AuthStatus.unauthenticated;
    notifyListeners();
    return false;
  }

  Future<void> logout() async {
    _currentUser = null;
    _currentRole = null;
    _authStatus = AuthStatus.unauthenticated;
    // Clear any persisted session/login state if you have one
    notifyListeners();
  }
}
