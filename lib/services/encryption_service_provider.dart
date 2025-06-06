import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/services/encryption_service.dart';

// Define a provider for the EncryptionService
final encryptionServiceProvider = Provider<EncryptionService>((ref) {
  // Create and return an instance of EncryptionService
  return EncryptionService();
});
