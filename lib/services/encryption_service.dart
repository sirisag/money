import 'package:flutter/foundation.dart';
import 'package:encrypt/encrypt.dart' as encrypt_lib;
import 'package:bcrypt/bcrypt.dart';

/// Service for password hashing and data encryption/decryption.
class EncryptionService {
  // --- Password Hashing (using bcrypt) ---

  /// Hashes a plain text password using bcrypt.
  /// Returns the hashed password string.
  String hashPassword(String password) {
    // BCrypt.hashpw() automatically generates a salt.
    // The salt is included in the resulting hash string.
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  /// Verifies a plain text password against a stored hashed password.
  /// Returns true if the password matches, false otherwise.
  bool verifyPassword(String password, String hashedPassword) {
    try {
      return BCrypt.checkpw(password, hashedPassword);
    } catch (e) {
      // BCrypt.checkpw can throw an exception if the hash is malformed
      debugPrint("Error verifying password: $e");
      return false;
    }
  }

  // --- Data Encryption/Decryption (using AES from encrypt package) ---

  /// Encrypts a plain text string using AES-CBC.
  /// Requires a 32-byte key (for AES-256).
  /// Returns a combined string: base64(IV) + ':' + base64(Ciphertext).
  /// Returns null if encryption fails or key is invalid.
  String? encryptData(String plainText, String keyString) {
    if (keyString.length < 32) {
      // AES-256 needs a 32-byte key
      debugPrint(
        "Encryption key must be at least 32 bytes long for AES-256. Padding or error handling needed.",
      );
      // Pad or truncate key, or throw error. For simplicity, we'll return null.
      // In a real app, ensure key management is robust.
      return null;
    }
    // Ensure the key is exactly 32 bytes for AES-256
    final key = encrypt_lib.Key.fromUtf8(keyString.substring(0, 32));

    // Generate a new random IV (16 bytes for AES) for each encryption
    final iv = encrypt_lib.IV.fromSecureRandom(16);

    final encrypter = encrypt_lib.Encrypter(
      encrypt_lib.AES(key, mode: encrypt_lib.AESMode.cbc),
    );

    try {
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      // Prepend IV to the ciphertext, separated by a delimiter.
      // Both IV and ciphertext are base64 encoded.
      return '${iv.base64}:${encrypted.base64}';
    } catch (e) {
      debugPrint("Error encrypting data: $e");
      return null;
    }
  }

  /// Decrypts a combined string (base64(IV) + ':' + base64(Ciphertext)) using AES-CBC.
  /// Requires the same 32-byte key used for encryption.
  /// Returns the decrypted plain text string, or null if decryption fails.
  String? decryptData(String combinedEncryptedData, String keyString) {
    if (keyString.length < 32) {
      // AES-256 needs a 32-byte key
      debugPrint(
        "Decryption key must be at least 32 bytes long. Key used for encryption is needed.",
      );
      return null;
    }
    final key = encrypt_lib.Key.fromUtf8(keyString.substring(0, 32));

    // Split the combined data to get IV and ciphertext
    final parts = combinedEncryptedData.split(':');
    if (parts.length != 2) {
      debugPrint("Invalid encrypted data format. Expected IV:Ciphertext.");
      return null;
    }
    final ivFromData = encrypt_lib.IV.fromBase64(parts[0]);
    final encryptedCiphertext = parts[1];

    final encrypter = encrypt_lib.Encrypter(
      encrypt_lib.AES(key, mode: encrypt_lib.AESMode.cbc),
    );

    try {
      final decrypted = encrypter.decrypt64(
        encryptedCiphertext,
        iv: ivFromData,
      );
      return decrypted;
    } catch (e) {
      debugPrint(
        "Error decrypting data: $e. Check if the key and IV are correct and if the data is not corrupted.",
      );
      return null;
    }
  }
}
