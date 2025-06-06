import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/features/auth/notifiers/auth_notifier.dart';
import 'package:money/features/monk/notifiers/monk_data_notifier.dart'; // To display monk name

class MonkSettingsScreen extends ConsumerStatefulWidget {
  const MonkSettingsScreen({super.key});

  @override
  ConsumerState<MonkSettingsScreen> createState() => _MonkSettingsScreenState();
}

class _MonkSettingsScreenState extends ConsumerState<MonkSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final success = await ref
        .read(authNotifierProvider.notifier)
        .changePassword(
          _currentPasswordController.text,
          _newPasswordController.text,
        );

    setState(() => _isLoading = false);

    if (mounted) {
      if (success) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('เปลี่ยนรหัสผ่าน/PIN สำเร็จ!')),
        );
        _formKey.currentState?.reset();
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmNewPasswordController.clear();
      } else {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text(
              'เปลี่ยนรหัสผ่าน/PIN ไม่สำเร็จ กรุณาตรวจสอบรหัสผ่าน/PIN ปัจจุบัน',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final monkDataState = ref.watch(monkDataNotifierProvider);
    final currentUser = authState.currentUser;
    final monkProfile = monkDataState.monkProfile;

    final displayName =
        monkProfile?.nameOrTitle ?? currentUser?.displayName ?? 'N/A';

    return Scaffold(
      appBar: AppBar(title: const Text('ตั้งค่าบัญชีพระ')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('ข้อมูลบัญชี', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildInfoRow('ชื่อ/ฉายา:', displayName),
                    _buildInfoRow(
                      'Primary ID:',
                      currentUser?.primaryId ?? 'N/A',
                    ),
                    _buildInfoRow(
                      'Secondary ID:',
                      currentUser?.secondaryId ?? 'N/A',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'เปลี่ยนรหัสผ่าน/PIN',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _currentPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'รหัสผ่าน/PIN ปัจจุบัน',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'กรุณากรอกรหัสผ่าน/PIN ปัจจุบัน'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _newPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'รหัสผ่าน/PIN ใหม่',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'กรุณากรอกรหัสผ่าน/PIN ใหม่';
                          // Monk PIN might have different length requirements, e.g., 4-6 digits
                          if (value.length < 4)
                            return 'รหัสผ่าน/PIN ใหม่ต้องมีอย่างน้อย 4 ตัวอักษร/หลัก';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmNewPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'ยืนยันรหัสผ่าน/PIN ใหม่',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'กรุณายืนยันรหัสผ่าน/PIN ใหม่';
                          if (value != _newPasswordController.text)
                            return 'รหัสผ่าน/PIN ใหม่ไม่ตรงกัน';
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton.icon(
                              icon: const Icon(Icons.lock_reset_outlined),
                              label: const Text('เปลี่ยนรหัสผ่าน/PIN'),
                              onPressed: _changePassword,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
