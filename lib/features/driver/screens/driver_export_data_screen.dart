import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/features/driver/notifiers/driver_data_notifier.dart';
import 'package:money/services/file_storage_service.dart';
import 'package:money/services/file_sharing_service.dart';
import 'package:money/data/models/driver_expense_record.dart'; // For type casting

class DriverExportDataScreen extends ConsumerStatefulWidget {
  const DriverExportDataScreen({super.key});

  @override
  ConsumerState<DriverExportDataScreen> createState() =>
      _DriverExportDataScreenState();
}

class _DriverExportDataScreenState
    extends ConsumerState<DriverExportDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _exportAndShareData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final driverDataNotifier = ref.read(driverDataNotifierProvider.notifier);
    final driverDataState = ref.read(
      driverDataNotifierProvider,
    ); // To get pending expenses

    // prepareDataForExport now returns plain JSON string
    final plainJsonContent = driverDataNotifier.prepareDataForExport();

    if (plainJsonContent == null) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            ref.read(driverDataNotifierProvider).errorMessage ??
                'ไม่สามารถเตรียมข้อมูลสำหรับส่งออกได้',
          ),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    final fileStorageService = ref.read(fileStorageServiceProvider);
    final fileSharingService = ref.read(fileSharingServiceProvider);
    final driverId = ref
        .read(driverDataNotifierProvider.notifier)
        .currentDriver // Use the public getter
        .primaryId;

    final String fileName =
        "driver_submission_${driverId}_${DateTime.now().toIso8601String().replaceAll(':', '-')}.mmdat";

    final filePath = await fileStorageService.saveFileToDocuments(
      fileName,
      plainJsonContent, // Pass plain content
      encrypt: true, // Tell FileStorageService to encrypt
      encryptionKey: _passwordController.text, // Provide the key for encryption
    );

    if (filePath != null) {
      await fileSharingService.shareFile(
        filePath,
        subject: "ข้อมูลจากคนขับรถ $driverId",
      );

      // Mark expenses as exported
      final List<DriverExpenseRecord> exportedExpenses = List.from(
        driverDataState.pendingDriverExpenses.where(
          (e) => !e.exportedToTreasurer,
        ),
      );
      if (exportedExpenses.isNotEmpty) {
        await driverDataNotifier.finalizeExpenseExport(exportedExpenses);
      }

      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('ไฟล์ข้อมูลถูกสร้างและแชร์แล้ว: $fileName')),
      );
      if (mounted) Navigator.of(context).pop();
    } else {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('ไม่สามารถบันทึกไฟล์ข้อมูลได้')),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final driverDataState = ref.watch(driverDataNotifierProvider);
    final pendingMonkTxCount = driverDataState.pendingMonkTransactions.length;
    final pendingExpensesCount = driverDataState.pendingDriverExpenses
        .where((e) => !e.exportedToTreasurer)
        .length;

    return Scaffold(
      appBar: AppBar(title: const Text('ส่งออกข้อมูลให้ไวยาวัจกรณ์')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text(
                'ข้อมูลที่จะส่งออก:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'รายการปัจจัยพระที่รอส่ง: $pendingMonkTxCount รายการ',
                      ),
                      Text(
                        'รายการค่าใช้จ่ายที่รอส่ง: $pendingExpensesCount รายการ',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'กรุณาตั้งรหัสผ่านสำหรับเข้ารหัสไฟล์นี้ และแจ้งรหัสผ่านนี้ให้ไวยาวัจกรณ์ทราบเพื่อใช้ในการเปิดไฟล์',
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
                  if (value == null || value.isEmpty)
                    return 'กรุณากรอกรหัสผ่าน';
                  if (value.length < 8)
                    return 'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      icon: const Icon(Icons.upload_file_outlined),
                      label: const Text('สร้างและแชร์ไฟล์ข้อมูล'),
                      onPressed:
                          (pendingMonkTxCount == 0 && pendingExpensesCount == 0)
                          ? null
                          : _exportAndShareData,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
