import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<ShadFormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ShadForm(
            key: formKey,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 350),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome',
                    style: ShadTheme.of(context).textTheme.h2.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  ShadInputFormField(
                    id: 'email',
                    label: const Text('Email'),
                    placeholder: const Text('Enter your email'),
                    validator: (v) {
                      if (v.isEmpty) {
                        return 'Email is required.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ShadInputFormField(
                    id: 'password',
                    label: const Text('Password'),
                    placeholder: const Text('Enter your password'),
                    obscureText: true,
                    validator: (v) {
                      if (v.isEmpty) {
                        return 'Password is required.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ShadButton(
                          child: const Text('Login'),
                          onPressed: _submit,
                        ),
                  const SizedBox(height: 16),
                  ShadButton(
                    child: const Text('Forgot Password?'),
                    onPressed: () {
                      // TODO: Implement forgot password functionality
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      ShadButton.link(
                        child: const Text('Sign Up'),
                        onPressed: () {
                          // TODO: Navigate to sign up page
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (formKey.currentState!.saveAndValidate()) {
      setState(() {
        _isLoading = true;
      });
      // TODO: Implement login logic
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        print('Form values: ${formKey.currentState!.value}');
      });
    } else {
      print('validation failed');
    }
  }
}
