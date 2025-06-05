import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/auth_notifier.dart'; // Import your AuthNotifier
import '../../../data/models/app_user.dart'; // Import UserRole
import '../../../core/navigation/app_router.dart'; // Import AppRouter

class TreasurerInitialSetupScreen extends ConsumerStatefulWidget {
  const TreasurerInitialSetupScreen({super.key});

  @override
  ConsumerState<TreasurerInitialSetupScreen> createState() =>
      _TreasurerInitialSetupScreenState();
}

class _TreasurerInitialSetupScreenState
    extends ConsumerState<TreasurerInitialSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _primaryIdController = TextEditingController();
  final _secondaryIdController =
      TextEditingController(); // Optional for treasurer
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _primaryIdController.dispose();
    _secondaryIdController.dispose();
    _displayNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _performSetup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final success = await ref
          .read(authNotifierProvider.notifier)
          .performInitialSetup(
            primaryId: _primaryIdController.text,
            secondaryId: _secondaryIdController.text.isNotEmpty
                ? _secondaryIdController.text
                : _primaryIdController
                      .text, // Use primary if secondary is empty
            password: _passwordController.text,
            role: UserRole.treasurer,
            displayName: _displayNameController.text,
          );

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        // Check if the widget is still in the tree
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('ตั้งค่าไวยาวัจกรณ์สำเร็จ! กรุณาเข้าสู่ระบบ'),
            ),
          );
          // TODO: Navigate to Login Screen or directly to Treasurer Dashboard if auto-login
          Navigator.of(context).popUntil(
            (route) => route.isFirst,
          ); // Go back to the first screen (chooser)
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
    // Listen to auth state changes to potentially auto-navigate if setup is done elsewhere
    // ref.listen<AuthState>(authNotifierProvider, (previous, next) {
    //   if (next.status == AuthStatus.authenticated && next.currentRole == UserRole.treasurer) {
    //     // Navigate to dashboard or login
    //   }
    // });

    return Scaffold(
      appBar: AppBar(title: const Text('ตั้งค่าไวยาวัจกรณ์')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _primaryIdController,
                decoration: const InputDecoration(
                  labelText: 'Primary ID (4 หลัก)',
                ),
                keyboardType: TextInputType.number,
                maxLength: 4,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 4) {
                    return 'กรุณากรอก Primary ID 4 หลัก';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _secondaryIdController,
                decoration: const InputDecoration(
                  labelText: 'Secondary ID (4 หลัก, ถ้ามี)',
                ),
                keyboardType: TextInputType.number,
                maxLength: 4,
                // Secondary ID is optional for treasurer, so no strict validation
              ),
              TextFormField(
                controller: _displayNameController,
                decoration: const InputDecoration(
                  labelText: 'ชื่อที่ใช้แสดงผล',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกชื่อที่ใช้แสดงผล';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'รหัสผ่าน'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: 'ยืนยันรหัสผ่าน'),
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'รหัสผ่านไม่ตรงกัน';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _performSetup,
                      child: const Text('ตั้งค่าบัญชีไวยาวัจกรณ์'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
