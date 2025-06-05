import 'package:bcrypt/bcrypt.dart';

class EncryptionService {
  /// Hashes a plain text password using bcrypt.
  String hashPassword(String password) {
    // The salt is automatically generated and included in the hash by bcrypt.
    // The second argument is the logRounds, which determines the complexity.
    // Default is 12, which is generally a good balance.
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  /// Verifies a plain text password against a stored hashed password.
  bool verifyPassword(String plainPassword, String hashedPassword) {
    try {
      return BCrypt.checkpw(plainPassword, hashedPassword);
    } catch (e) {
      // Handle potential errors during verification, e.g., invalid hash format
      print('Error verifying password: $e');
      return false;
    }
  }
}
