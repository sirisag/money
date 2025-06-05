import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'encryption_service.dart';

/// Provider for the EncryptionService.
/// This makes the EncryptionService instance available throughout the app.
final encryptionServiceProvider = Provider<EncryptionService>((ref) {
  return EncryptionService(); // Creates and returns an instance of EncryptionService
});
