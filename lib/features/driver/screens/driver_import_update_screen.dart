import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/data/datasources/file/file_data_service.dart'; // Corrected import path
import 'package:money/services/file_storage_service.dart';
import 'package:money/features/driver/notifiers/driver_data_notifier.dart';

class DriverImportUpdateScreen extends ConsumerStatefulWidget {
  const DriverImportUpdateScreen({super.key});

  @override
  ConsumerState<DriverImportUpdateScreen> createState() =>
      _DriverImportUpdateScreenState();
}

class _DriverImportUpdateScreenState
    extends ConsumerState<DriverImportUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  File? _selectedFile;
  AppDataFile? _parsedDataFile;
  String? _fileSummary;
  bool _isLoading = false;
  String? _errorMessage;

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
    });

    final fileStorageService = ref.read(fileStorageServiceProvider);
    final fileDataService = ref.read(fileDataServiceProvider);

    // Expecting a general backup file or a specific update file from treasurer
    final pickedFile = await fileStorageService.pickFile(['mmbak', 'mmdat']);

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
      decrypt: true, // Tell FileStorageService to decrypt
      decryptionKey: _passwordController.text, // Provide the key for decryption
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

    setState(() {
      _selectedFile = pickedFile;
      _parsedDataFile = parsedData;
      _fileSummary =
          """
      ไฟล์: ${pickedFile.path.split('/').last}
      สร้างโดย: ${parsedData.createdById} (บทบาท: ${parsedData.createdByRole})
      วันที่สร้างไฟล์: ${parsedData.createdAt.toLocal()}
      เวอร์ชันไฟล์: ${parsedData.fileVersion}
      (แตะ "ยืนยันการนำเข้า" เพื่อประมวลผลข้อมูล)
      """;
      _isLoading = false;
    });
  }

  Future<void> _processImportedData() async {
    if (_parsedDataFile == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('ไม่มีข้อมูลให้ประมวลผล')));
      return;
    }
    setState(() => _isLoading = true);

    final success = await ref
        .read(driverDataNotifierProvider.notifier)
        .processTreasurerUpdateFile(_parsedDataFile!);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'นำเข้าข้อมูลอัปเดตสำเร็จ!'
                : 'การนำเข้าข้อมูลล้มเหลว: ${ref.read(driverDataNotifierProvider).errorMessage ?? ""}',
          ),
        ),
      );
      if (success) {
        Navigator.of(context).pop();
      }
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('นำเข้าข้อมูลจากไวยาวัจกรณ์')),
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
                label: const Text('เลือกและอ่านไฟล์ข้อมูล (.mmbak, .mmdat)'),
                onPressed: _isLoading ? null : _pickAndReadFile,
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
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
                  icon: const Icon(Icons.system_update_alt_outlined),
                  label: const Text('ยืนยันและนำเข้าข้อมูลอัปเดต'),
                  onPressed: _isLoading ? null : _processImportedData,
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
