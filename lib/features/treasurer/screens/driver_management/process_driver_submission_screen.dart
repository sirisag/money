import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/data/models/driver_expense_record.dart';
import 'package:money/data/models/transaction_record.dart';
import 'package:money/data/datasources/file/file_data_service.dart'; // Corrected import path for AppDataFile
import 'package:money/services/file_storage_service.dart';
import 'package:money/features/auth/notifiers/auth_notifier.dart'; // To get current treasurer
import 'package:money/features/treasurer/notifiers/treasurer_data_processing_notifier.dart';

class ProcessDriverSubmissionScreen extends ConsumerStatefulWidget {
  const ProcessDriverSubmissionScreen({super.key});

  @override
  ConsumerState<ProcessDriverSubmissionScreen> createState() =>
      _ProcessDriverSubmissionScreenState();
}

class _ProcessDriverSubmissionScreenState
    extends ConsumerState<ProcessDriverSubmissionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  File? _selectedFile;
  AppDataFile? _parsedDataFile;
  String? _fileSummary;
  bool _isLoading = false;
  String? _errorMessage;

  // Placeholder for deserialized data
  List<TransactionRecord> _monkTransactions = [];
  List<DriverExpenseRecord> _driverExpenses = [];
  String? _submittingDriverId;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickAndReadFile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _selectedFile = null;
      _parsedDataFile = null;
      _fileSummary = null;
      _errorMessage = null;
      _monkTransactions = [];
      _driverExpenses = [];
      _submittingDriverId = null;
    });

    final fileStorageService = ref.read(fileStorageServiceProvider);
    final fileDataService = ref.read(fileDataServiceProvider);

    final pickedFile = await fileStorageService.pickFile([
      'mmdat',
    ]); // Expect .mmdat extension

    if (pickedFile == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'ไม่ได้เลือกไฟล์';
      });
      return;
    }

    // 1. Read and decrypt file content using FileStorageService
    final plainJsonFileContent = await fileStorageService.readFileContent(
      pickedFile,
      decrypt: true,
      decryptionKey: _passwordController.text,
    );

    if (plainJsonFileContent == null) {
      setState(() {
        _isLoading = false;
        _errorMessage =
            'ไม่สามารถอ่านหรือถอดรหัสไฟล์ได้ อาจเป็นเพราะรหัสผ่านไม่ถูกต้อง หรือไฟล์เสียหาย';
      });
      return;
    }
    // 2. Parse the plain JSON content using FileDataService
    final parsedData = fileDataService.parseImportFileContent(
      plainJsonFileContent: plainJsonFileContent,
    );

    if (parsedData == null) {
      setState(() {
        _isLoading = false;
        _errorMessage =
            'ไม่สามารถถอดรหัสหรือแยกแยะข้อมูลไฟล์ได้ อาจเป็นเพราะรหัสผ่านไม่ถูกต้อง หรือไฟล์เสียหาย';
      });
      return;
    }

    // --- Deserialize specific data from parsedData.data ---
    // This assumes the driver's export format.
    try {
      _submittingDriverId = parsedData.data['driverPrimaryId'] as String?;

      if (parsedData.data['monkTransactions'] != null) {
        final List<dynamic> monkTxJsonList = jsonDecode(
          parsedData.data['monkTransactions'] as String,
        );
        _monkTransactions = monkTxJsonList
            .map(
              (json) =>
                  TransactionRecord.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }
      if (parsedData.data['driverExpenses'] != null) {
        final List<dynamic> driverExJsonList = jsonDecode(
          parsedData.data['driverExpenses'] as String,
        );
        _driverExpenses = driverExJsonList
            .map(
              (json) =>
                  DriverExpenseRecord.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }

      setState(() {
        _selectedFile = pickedFile;
        _parsedDataFile = parsedData;
        _fileSummary =
            """
        ไฟล์: ${pickedFile.path.split('/').last}
        สร้างโดย: ${parsedData.createdById} (บทบาท: ${parsedData.createdByRole})
        วันที่สร้างไฟล์: ${parsedData.createdAt.toLocal()}
        --- ข้อมูลที่จะนำเข้า ---
        ID คนขับรถผู้ส่ง: ${_submittingDriverId ?? 'ไม่พบ'}
        จำนวนรายการปัจจัยพระ: ${_monkTransactions.length} รายการ
        จำนวนรายการค่าใช้จ่ายคนขับรถ: ${_driverExpenses.length} รายการ
        """;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'เกิดข้อผิดพลาดในการแปลงข้อมูลจากไฟล์: $e';
      });
    }
  }

  Future<void> _processImportedData() async {
    if (_parsedDataFile == null || _submittingDriverId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('ไม่มีข้อมูลให้ประมวลผล')));
      return;
    }

    final treasurerUser = ref.read(authNotifierProvider).currentUser;
    if (treasurerUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ไม่พบข้อมูลไวยาวัจกรณ์ปัจจุบัน')),
      );
      return;
    }

    // No need to set _isLoading here as the notifier will handle its own loading state.
    // However, we might want to listen to the notifier's state to update UI.

    await ref
        .read(treasurerDataProcessingNotifierProvider.notifier)
        .processDriverSubmission(
          submittingDriverId: _submittingDriverId!,
          monkTransactions: _monkTransactions,
          driverExpenses: _driverExpenses,
          treasurerUser: treasurerUser,
        );

    // After processing, check the state from the notifier
    final processingState = ref.read(treasurerDataProcessingNotifierProvider);
    if (mounted) {
      if (processingState.successMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(processingState.successMessage!)),
        );
        // Clear the form/summary after successful processing
        setState(() {
          _selectedFile = null;
          _parsedDataFile = null;
          _fileSummary = null;
          _monkTransactions = [];
          _driverExpenses = [];
        });
      } else if (processingState.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(processingState.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('รับข้อมูลจากคนขับรถ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'รหัสผ่านสำหรับถอดรหัสไฟล์',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'กรุณากรอกรหัสผ่าน'
                    : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.file_open_outlined),
                label: const Text('เลือกและอ่านไฟล์ข้อมูล (.mmdat)'),
                onPressed: _isLoading ? null : _pickAndReadFile,
              ),
              // Listen to the processing notifier's loading state
              Consumer(
                builder: (context, watch, child) {
                  final processingState = ref.watch(
                    treasurerDataProcessingNotifierProvider,
                  );
                  if (processingState.isLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return const SizedBox.shrink(); // Return empty if not loading
                },
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              if (_fileSummary != null) ...[
                const SizedBox(height: 20),
                Text(
                  'ข้อมูลสรุปจากไฟล์:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(_fileSummary!),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.data_saver_on_outlined),
                  label: const Text('ยืนยันและประมวลผลข้อมูล'),
                  onPressed:
                      ref
                          .watch(treasurerDataProcessingNotifierProvider)
                          .isLoading
                      ? null
                      : _processImportedData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
