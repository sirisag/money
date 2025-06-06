import 'dart:convert'; // Required for jsonEncode

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/data/models/app_user.dart';
import 'package:money/data/models/monk_profile.dart';
import 'package:money/features/auth/notifiers/auth_notifier.dart';
import 'package:money/features/treasurer/notifiers/monk_account_notifier.dart';
import 'package:money/features/treasurer/notifiers/driver_account_notifier.dart';
import 'package:money/features/treasurer/notifiers/central_fund_notifier.dart';
// Import services
import 'package:money/services/file_storage_service.dart';
import 'package:money/data/datasources/file/file_data_service.dart'; // Corrected path
import 'package:money/services/file_sharing_service.dart';
import 'package:money/data/datasources/local/isar_service_provider.dart'; // For direct Isar access if needed
import 'package:package_info_plus/package_info_plus.dart'; // For getting app version

class BackupExportDataScreen extends ConsumerStatefulWidget {
  const BackupExportDataScreen({super.key});

  @override
  ConsumerState<BackupExportDataScreen> createState() =>
      _BackupExportDataScreenState();
}

class _BackupExportDataScreenState
    extends ConsumerState<BackupExportDataScreen> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  MonkProfile? _selectedMonkForExport;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _performFullBackup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // final navigator = Navigator.of(context); // Not used currently

    final fileDataService = ref.read(fileDataServiceProvider);
    final fileStorageService = ref.read(fileStorageServiceProvider);
    final fileSharingService = ref.read(fileSharingServiceProvider);
    final currentUser = ref.read(authNotifierProvider).currentUser;

    if (currentUser == null) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('ไม่พบข้อมูลผู้ใช้ปัจจุบัน')),
      );
      setState(() => _isLoading = false);
      return;
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;

    // --- Gather all necessary data ---
    final isarService = ref.read(isarServiceProvider);
    // Use methods from IsarService to get all data
    final allAppUsers = await isarService
        .getAllAppUsers(); // Assuming this method exists
    final allMonkProfiles = await isarService.getAllMonkProfiles();
    final allDriverProfiles = await isarService.getAllDriverProfiles();
    final allTransactionRecords = await isarService.getAllTransactionRecords();
    final allCentralFundTransactions = await isarService
        .getAllCentralFundTransactions();
    final allDriverExpenseRecords = await isarService
        .getAllDriverExpenseRecords();

    // Serialize data
    final Map<String, dynamic> dataPayload = {
      "appUsers": jsonEncode(allAppUsers.map((e) => e.toJson()).toList()),
      "monkProfiles": fileDataService.serializeMonkProfiles(allMonkProfiles),
      "driverProfiles": fileDataService.serializeDriverProfiles(
        allDriverProfiles,
      ),
      "transactionRecords": fileDataService.serializeTransactionRecords(
        allTransactionRecords,
      ),
      "centralFundTransactions": fileDataService
          .serializeCentralFundTransactions(allCentralFundTransactions),
      "driverExpenseRecords": fileDataService.serializeDriverExpenseRecords(
        allDriverExpenseRecords,
      ),
    };

    final String fileName =
        "money_app_full_backup_${DateTime.now().toIso8601String().replaceAll(':', '-')}.mmbak";

    // 1. Create plain JSON content
    final plainJsonContent = fileDataService.createExportFileContent(
      appVersion: appVersion,
      fileFormatVersion: "1.0",
      createdByRole: currentUser.role,
      createdById: currentUser.primaryId,
      dataPayload: dataPayload,
    );

    if (plainJsonContent != null) {
      // 2. Save and encrypt using FileStorageService
      final filePath = await fileStorageService.saveFileToDocuments(
        fileName,
        plainJsonContent,
        encrypt: true,
        encryptionKey: _passwordController.text,
      );
      if (filePath != null) {
        await fileSharingService.shareFile(
          filePath,
          subject: "Full Backup - Money App",
        );
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('ไฟล์สำรองข้อมูลถูกสร้างและแชร์แล้ว: $fileName'),
          ),
        );
      } else {
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('ไม่สามารถบันทึกไฟล์สำรองข้อมูลได้')),
        );
      }
    } else {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('การสร้างเนื้อหาไฟล์ล้มเหลว')),
      );
    }

    setState(() => _isLoading = false);
  }

  Future<void> _exportDataForMonk() async {
    if (!_formKey.currentState!.validate() || _selectedMonkForExport == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณาเลือกพระและกรอกรหัสผ่าน')),
      );
      return;
    }
    setState(() => _isLoading = true);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // final navigator = Navigator.of(context); // Not used currently

    final fileDataService = ref.read(fileDataServiceProvider);
    final fileStorageService = ref.read(fileStorageServiceProvider);
    final fileSharingService = ref.read(fileSharingServiceProvider);
    final currentUser = ref.read(authNotifierProvider).currentUser;
    final isarService = ref.read(isarServiceProvider);

    if (currentUser == null) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('ไม่พบข้อมูลผู้ใช้ปัจจุบัน')),
      );
      setState(() => _isLoading = false);
      return;
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;

    final monkToExport = _selectedMonkForExport!;
    final monkTransactions = await isarService.getTransactionsForMonk(
      monkToExport.monkPrimaryId,
    );

    final Map<String, dynamic> dataPayload = {
      "monkProfiles": fileDataService.serializeMonkProfiles([monkToExport]),
      "transactionRecords": fileDataService.serializeTransactionRecords(
        monkTransactions,
      ),
      // Optionally include the AppUser for this monk if it's needed for import on the monk's device
      // and if AppUser has a toJson method.
      // "appUsers": jsonEncode([monkToExport.appUser.value?.toJson()]),
    };

    final String fileName =
        "money_data_for_${monkToExport.monkPrimaryId}_${DateTime.now().toIso8601String().replaceAll(':', '-')}.mmdat";

    // 1. Create plain JSON content
    final plainJsonContent = fileDataService.createExportFileContent(
      appVersion: appVersion,
      fileFormatVersion: "1.0_monk_specific",
      createdByRole: currentUser.role,
      createdById: currentUser.primaryId,
      dataPayload: dataPayload,
    );

    if (plainJsonContent != null) {
      // 2. Save and encrypt using FileStorageService
      final filePath = await fileStorageService.saveFileToDocuments(
        fileName,
        plainJsonContent,
        encrypt: true,
        encryptionKey: _passwordController.text,
      );
      if (filePath != null) {
        await fileSharingService.shareFile(
          filePath,
          subject: "ข้อมูลสำหรับพระ ${monkToExport.nameOrTitle}",
        );
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              'ไฟล์ข้อมูลสำหรับพระ ${monkToExport.nameOrTitle} ถูกสร้างและแชร์แล้ว: $fileName',
            ),
          ),
        );
      } else {
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('ไม่สามารถบันทึกไฟล์ข้อมูลพระได้')),
        );
      }
    } else {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('การสร้างเนื้อหาไฟล์ล้มเหลว')),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final monks = ref.watch(monkAccountNotifierProvider).monks;

    return Scaffold(
      appBar: AppBar(title: const Text('สำรองและส่งออกข้อมูล')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text(
                'การดำเนินการเหล่านี้จะสร้างไฟล์ที่เข้ารหัสด้วยรหัสผ่านที่คุณระบุ กรุณาจดจำรหัสผ่านนี้ให้ดี เนื่องจากจำเป็นต้องใช้ในการนำเข้าข้อมูล',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'รหัสผ่านสำหรับเข้ารหัสไฟล์',
                  border: OutlineInputBorder(),
                  helperText: 'อย่างน้อย 8 ตัวอักษร',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกรหัสผ่าน';
                  }
                  if (value.length < 8) {
                    return 'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร';
                  }
                  // TODO: Add more password strength validation if needed
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.backup_rounded),
                label: const Text('สร้างไฟล์สำรองข้อมูลทั้งหมด (Full Backup)'),
                onPressed: _isLoading ? null : _performFullBackup,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              Text(
                'ส่งออกข้อมูลสำหรับพระแต่ละรูป',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<MonkProfile>(
                value: _selectedMonkForExport,
                hint: const Text('เลือกพระเพื่อส่งออกข้อมูล'),
                isExpanded: true,
                items: monks.map((MonkProfile monk) {
                  return DropdownMenuItem<MonkProfile>(
                    value: monk,
                    child: Text(monk.nameOrTitle ?? monk.monkPrimaryId),
                  );
                }).toList(),
                onChanged: (MonkProfile? newValue) {
                  setState(() {
                    _selectedMonkForExport = newValue;
                  });
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.person_add_outlined),
                label: const Text('ส่งออกข้อมูลสำหรับพระที่เลือก'),
                onPressed: (_isLoading || _selectedMonkForExport == null)
                    ? null
                    : _exportDataForMonk,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
