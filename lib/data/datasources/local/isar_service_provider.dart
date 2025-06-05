import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'isar_service.dart';

/// Provider for the IsarService.
/// This makes the IsarService instance available throughout the app.
final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService(); // Creates and returns an instance of IsarService
});
