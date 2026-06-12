import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: ' Email',
                ),
                validator: (val) =>
                    val!.isEmpty ? '  Enter Email' : null,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: ' Password'),
                validator: (val) =>
                    val!.length < 6 ? 'Six parts minmum' : null,
              ),
              const SizedBox(height: 20),
              if (authProvider.errorMessage.isNotEmpty)
                Text(
                  authProvider.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 10),
              authProvider.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool success = await authProvider.register(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );

                          if (success && mounted) {
                            FocusScope.of(context).unfocus();
                            Future.delayed(
                              const Duration(milliseconds: 100),
                              () {
                                if (mounted) Navigator.pop(context);
                              },
                            );
                          }
                        }
                      },
                      child: const Text('تسجيل الحساب'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
