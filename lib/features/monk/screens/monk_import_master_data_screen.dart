import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/services/file_data_service.dart';
import 'package:money/services/file_storage_service.dart';
import 'package:money/features/monk/notifiers/monk_data_notifier.dart';

class MonkImportMasterDataScreen extends ConsumerStatefulWidget {
  const MonkImportMasterDataScreen({super.key});

  @override
  ConsumerState<MonkImportMasterDataScreen> createState() =>
      _MonkImportMasterDataScreenState();
}

class _MonkImportMasterDataScreenState
    extends ConsumerState<MonkImportMasterDataScreen> {
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

    // Expecting a specific data file from treasurer for monk
    final pickedFile = await fileStorageService.pickFile(['mmdat']);

    if (pickedFile == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'ไม่ได้เลือกไฟล์';
      });
      return;
    }

    final fileContent = await fileStorageService.readFileContent(pickedFile);
    if (fileContent == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'ไม่สามารถอ่านเนื้อหาไฟล์ได้';
      });
      return;
    }

    final parsedData = await fileDataService.parseAndDecryptImportFileContent(
      encryptedFileContent: fileContent,
      decryptionKey: _passwordController.text,
    );

    if (parsedData == null) {
      setState(() {
        _isLoading = false;
        _errorMessage =
            'ไม่สามารถถอดรหัสหรือแยกแยะข้อมูลไฟล์ได้ อาจเป็นเพราะรหัสผ่านไม่ถูกต้อง หรือไฟล์เสียหาย';
      });
      return;
    }

    // Basic validation: check if the file is from a treasurer and for a monk
    if (parsedData.createdByRole != 'treasurer' ||
        parsedData.fileVersion != "1.0_monk_specific") {
      setState(() {
        _isLoading = false;
        _errorMessage =
            'ไฟล์นี้ไม่ใช่ไฟล์ข้อมูลสำหรับพระจากไวยาวัจกรณ์ที่ถูกต้อง';
      });
      return;
    }

    setState(() {
      _selectedFile = pickedFile;
      _parsedDataFile = parsedData;
      _fileSummary =
          """
      ไฟล์: ${pickedFile.path.split('/').last}
      สร้างโดย: ${parsedData.createdById} (ไวยาวัจกรณ์)
      วันที่สร้างไฟล์: ${parsedData.createdAt.toLocal()}
      (แตะ "ยืนยันการนำเข้า" เพื่ออัปเดตข้อมูลของคุณ)
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
        .read(monkDataNotifierProvider.notifier)
        .processImportedData(_parsedDataFile!);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'นำเข้าข้อมูลสำเร็จ!'
                : 'การนำเข้าข้อมูลล้มเหลว: ${ref.read(monkDataNotifierProvider).errorMessage ?? ""}',
          ),
        ),
      );
      if (success) Navigator.of(context).pop();
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
                label: const Text('เลือกและอ่านไฟล์ข้อมูล (.mmdat)'),
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
                  icon: const Icon(Icons.cloud_download_outlined),
                  label: const Text('ยืนยันและนำเข้าข้อมูล'),
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
