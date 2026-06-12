import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
                    val!.isEmpty ? 'Enter your Email' : null,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password '),
                validator: (val) =>
                    val!.length < 6 ? 'Passwoed is short' : null,
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
                          bool success = await authProvider.login(
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
                      child: const Text('Entery'),
                    ),
              TextButton(
                onPressed: () {
                  authProvider.clearError();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                child: const Text('Have you already account? Sign Up '),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
