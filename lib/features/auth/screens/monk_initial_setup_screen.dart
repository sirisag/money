import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/auth_notifier.dart';
import '../../../data/models/app_user.dart';
import '../../../core/navigation/app_router.dart';

class MonkInitialSetupScreen extends ConsumerStatefulWidget {
  const MonkInitialSetupScreen({super.key});

  @override
  ConsumerState<MonkInitialSetupScreen> createState() =>
      _MonkInitialSetupScreenState();
}

class _MonkInitialSetupScreenState
    extends ConsumerState<MonkInitialSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _primaryIdController = TextEditingController();
  final _secondaryIdController = TextEditingController();
  // For Monk, we might use a PIN instead of a full password for simplicity,
  // or a password if preferred. Let's assume password for now for consistency
  // with AuthNotifier.performInitialSetup, but UI can be adapted for PIN.
  final _passwordController = TextEditingController(); // Or PIN controller
  final _confirmPasswordController = TextEditingController(); // Or Confirm PIN

  bool _isLoading = false;

  @override
  void dispose() {
    _primaryIdController.dispose();
    _secondaryIdController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _performSetup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final String primaryId = _primaryIdController.text;
      final String secondaryId = _secondaryIdController.text;

      // Basic check for distinct IDs on the client side
      if (primaryId == secondaryId) {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Primary ID และ Secondary ID ต้องไม่ซ้ำกัน'),
            ),
          );
        }
        return;
      }

      // For Monk, displayName might not be directly set here,
      // or could be a default value or fetched later.
      // AuthNotifier.performInitialSetup expects a password.
      // If using PIN, AuthNotifier would need adjustment or a different method.
      final success = await ref
          .read(authNotifierProvider.notifier)
          .performInitialSetup(
            primaryId: primaryId,
            secondaryId: secondaryId,
            password: _passwordController.text, // Using password field for now
            role: UserRole.monk,
            displayName: "พระ ID: $primaryId", // Example default display name
          );

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('ตั้งค่าบัญชีพระสำเร็จ! กรุณาเข้าสู่ระบบ'),
            ),
          );
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'ตั้งค่าไม่สำเร็จ: ID อาจซ้ำกัน หรือเกิดข้อผิดพลาด',
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ตั้งค่าบัญชีพระ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _primaryIdController,
                decoration: const InputDecoration(
                  labelText: 'Primary ID (6 หลัก)',
                  hintText: 'เช่น 100001',
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอก Primary ID';
                  }
                  if (value.length != 6) {
                    return 'Primary ID ต้องมี 6 หลัก';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Primary ID ต้องเป็นตัวเลขเท่านั้น';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _secondaryIdController,
                decoration: const InputDecoration(
                  labelText: 'Secondary ID (6 หลัก)',
                  hintText: 'เช่น 200001',
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอก Secondary ID';
                  }
                  if (value.length != 6) {
                    return 'Secondary ID ต้องมี 6 หลัก';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Secondary ID ต้องเป็นตัวเลขเท่านั้น';
                  }
                  return null;
                },
              ),

              // For Monk, DisplayName is usually their monastic name/title,
              // which might be set by the Treasurer or a different process.
              // For initial setup by the monk themselves, this might be skipped
              // or a default value used.
              // We are using a default in _performSetup for now.
              TextFormField(
                controller: _passwordController,
                // Consider changing label to "รหัส PIN (4-6 หลัก)" if using PIN
                decoration: const InputDecoration(labelText: 'รหัสผ่าน/PIN'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกรหัสผ่านหรือ PIN';
                  }
                  // Adjust length validation if using PIN (e.g., 4-6 digits)
                  if (value.length < 4) {
                    return 'รหัสผ่าน/PIN ต้องมีอย่างน้อย 4 ตัวอักษร/หลัก';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'ยืนยันรหัสผ่าน/PIN',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณายืนยันรหัสผ่านหรือ PIN';
                  }
                  if (value != _passwordController.text) {
                    return 'รหัสผ่าน/PIN ไม่ตรงกัน';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _performSetup,
                      child: const Text('ตั้งค่าบัญชีพระ'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
