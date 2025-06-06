import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:money/services/encryption_service.dart'; // Import EncryptionService
import 'package:money/services/encryption_service_provider.dart'; // Import the provider

class FileStorageService {
  final EncryptionService _encryptionService;

  FileStorageService(this._encryptionService);

  /// Picks a single file with the specified allowed extensions (e.g., ['json', 'txt']).
  /// Returns the File object if a file is picked, otherwise null.
  Future<File?> pickFile(List<String>? allowedExtensions) async {
    try {
      // Request storage permission
      if (Platform.isAndroid || Platform.isIOS) {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
          if (!status.isGranted) {
            debugPrint('Storage permission denied');
            return null;
          }
        }
      }

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
      );

      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
    return null;
  }

  /// Saves a plain string content to a file in the app's documents directory,
  /// optionally encrypting it.
  /// Returns the path to the saved file, or null if saving failed.
  Future<String?> saveFileToDocuments(
    String fileName,
    String plainContent, {
    bool encrypt = false,
    String? encryptionKey,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      String contentToWrite = plainContent;
      if (encrypt && encryptionKey != null) {
        contentToWrite =
            _encryptionService.encryptData(plainContent, encryptionKey) ??
            plainContent;
      }
      await file.writeAsString(contentToWrite);
      debugPrint('File saved to: $filePath');
      return filePath;
    } catch (e) {
      debugPrint('Error saving file to documents: $e');
      return null;
    }
  }

  /// Saves a plain string content to a file in a publicly accessible directory (e.g., Downloads),
  /// This is more complex on Android 10+ due to scoped storage.
  /// For simplicity, this example might save to app documents and rely on FileSharingService.
  /// A more robust solution for public directories might involve platform channels or specific plugins.
  Future<String?> saveFileToPublicDirectory(
    String fileName,
    String plainContent, {
    bool encrypt = false,
    String? encryptionKey,
  }) async {
    // On Android, getExternalStorageDirectory() is often used, but scoped storage changes things.
    // For broader compatibility and simplicity with sharing, saving to app's temp or documents
    // and then using a share intent is often easier.
    // This example will use getApplicationDocumentsDirectory and you can use FileSharingService to share it.
    // If you need to save directly to Downloads and have it immediately visible without sharing,
    // you might need packages like `downloads_path_provider` or handle platform-specific APIs.

    // For now, let's use the same as saveFileToDocuments and rely on sharing.
    // You can enhance this later if direct public saving is a hard requirement.
    return saveFileToDocuments(
      fileName,
      plainContent,
      encrypt: encrypt,
      encryptionKey: encryptionKey,
    );
  }

  /// Reads content from a given File, optionally decrypting it.
  /// Returns the file content as a string, or null if reading failed.
  Future<String?> readFileContent(
    File file, {
    bool decrypt = false,
    String? decryptionKey,
  }) async {
    try {
      if (await file.exists()) {
        String fileContent = await file.readAsString();
        if (decrypt && decryptionKey != null) {
          return _encryptionService.decryptData(fileContent, decryptionKey);
        }
        return fileContent;
      } else {
        debugPrint('File does not exist: ${file.path}');
        return null;
      }
    } catch (e) {
      debugPrint('Error reading file: $e');
      return null;
    }
  }
}

// Provider for FileStorageService
final fileStorageServiceProvider = Provider<FileStorageService>((ref) {
  final encryptionService = ref.watch(encryptionServiceProvider);
  return FileStorageService(encryptionService);
});
