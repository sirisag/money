import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class FileSharingService {
  /// Shares a file located at [filePath] using the OS share sheet.
  /// [subject] is optional and typically used for email subjects.
  /// [text] is optional and can be used for the body of an email or message.
  Future<void> shareFile(
    String filePath, {
    String? subject,
    String? text,
  }) async {
    try {
      // Share.shareXFiles expects a list of XFile objects.
      final xFile = XFile(filePath);
      await Share.shareXFiles([xFile], subject: subject, text: text);
      debugPrint('File shared successfully: $filePath');
    } catch (e) {
      debugPrint('Error sharing file: $e');
      // You might want to show a user-facing error message here
    }
  }
}

// Provider for FileSharingService
final fileSharingServiceProvider = Provider<FileSharingService>((ref) {
  return FileSharingService();
});
