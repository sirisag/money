import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/data/models/app_user.dart';
import 'package:money/data/models/monk_profile.dart';
import 'package:money/data/models/driver_profile.dart';
import 'package:money/data/models/transaction_record.dart';
import 'package:money/data/models/central_fund_transaction.dart';
import 'package:money/data/models/driver_expense_record.dart';
// EncryptionService is no longer directly used here, it's handled by FileStorageService

/// Represents the structure of the data file.
/// This helps in versioning and identifying the type of data.
class AppDataFile {
  final String appVersion; // Version of the app that created the file
  final String fileVersion; // Version of the file format
  final DateTime createdAt;
  final String createdByRole; // e.g., "treasurer", "driver"
  final String createdById; // ID of the user who created the file
  final Map<String, dynamic> data; // The actual data payload

  AppDataFile({
    required this.appVersion,
    required this.fileVersion,
    required this.createdAt,
    required this.createdByRole,
    required this.createdById,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
    'appVersion': appVersion,
    'fileVersion': fileVersion,
    'createdAt': createdAt.toIso8601String(),
    'createdByRole': createdByRole,
    'createdById': createdById,
    'data': data,
  };

  factory AppDataFile.fromJson(Map<String, dynamic> json) {
    return AppDataFile(
      appVersion: json['appVersion'] as String,
      fileVersion: json['fileVersion'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdByRole: json['createdByRole'] as String,
      createdById: json['createdById'] as String,
      data: json['data'] as Map<String, dynamic>,
    );
  }
}

class FileDataService {
  // No longer needs EncryptionService directly
  FileDataService();
  // --- Serialization (Object to JSON String) ---

  /// Serializes a list of MonkProfiles to a JSON string.
  String serializeMonkProfiles(List<MonkProfile> monks) {
    final List<Map<String, dynamic>> jsonList = monks
        .map((monk) => monk.toJson())
        .toList();
    return jsonEncode(jsonList);
  }

  /// Serializes a list of DriverProfiles to a JSON string.
  String serializeDriverProfiles(List<DriverProfile> drivers) {
    final List<Map<String, dynamic>> jsonList = drivers
        .map((driver) => driver.toJson())
        .toList();
    return jsonEncode(jsonList);
  }

  /// Serializes a list of TransactionRecords to a JSON string.
  String serializeTransactionRecords(List<TransactionRecord> transactions) {
    final List<Map<String, dynamic>> jsonList = transactions
        .map((tx) => tx.toJson())
        .toList();
    return jsonEncode(jsonList);
  }

  /// Serializes a list of CentralFundTransactions to a JSON string.
  String serializeCentralFundTransactions(
    List<CentralFundTransaction> transactions,
  ) {
    final List<Map<String, dynamic>> jsonList = transactions
        .map((tx) => tx.toJson())
        .toList();
    return jsonEncode(jsonList);
  }

  /// Serializes a list of DriverExpenseRecords to a JSON string.
  String serializeDriverExpenseRecords(
    List<DriverExpenseRecord> expenseRecords,
  ) {
    final List<Map<String, dynamic>> jsonList = expenseRecords
        .map((ex) => ex.toJson())
        .toList();
    return jsonEncode(jsonList);
  }

  /// Creates a structured and optionally encrypted JSON string for export.
  /// [dataPayload] should be a Map<String, dynamic> where keys are data types
  /// (e.g., "monkProfiles", "transactions") and values are the serialized JSON strings.
  String? createExportFileContent({
    // Renamed, no longer handles encryption directly
    required String appVersion,
    required String fileFormatVersion,
    required UserRole createdByRole,
    required String createdById,
    required Map<String, dynamic> dataPayload,
  }) {
    try {
      final appDataFile = AppDataFile(
        appVersion: appVersion,
        fileVersion: fileFormatVersion,
        createdAt: DateTime.now(),
        createdByRole: createdByRole.name, // Using enum name
        createdById: createdById,
        data: dataPayload,
      );
      final plainJsonString = jsonEncode(appDataFile.toJson());
      return plainJsonString;
    } catch (e) {
      debugPrint("Error creating export file content: $e");
      return null;
    }
  }

  // --- Deserialization (JSON String to Object) ---

  /// Deserializes a plain JSON string into an AppDataFile object.
  AppDataFile? parseImportFileContent({
    // Renamed, no longer handles decryption
    required String plainJsonFileContent,
  }) {
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(plainJsonFileContent);
      return AppDataFile.fromJson(jsonMap);
    } catch (e) {
      debugPrint("Error parsing import file content: $e");
      return null;
    }
  }

  // Add specific deserialization methods for each data type if needed,
  // e.g., List<MonkProfile> deserializeMonkProfiles(String jsonString)
  // These would typically be used after getting the relevant part from AppDataFile.data
}

// Provider for FileDataService
final fileDataServiceProvider = Provider<FileDataService>((ref) {
  return FileDataService(); // No longer needs encryptionService
});
