import 'package:flutter/material.dart';
import 'package:sos_app/validators/form_validators.dart';
import 'package:sos_app/widgets/auth_scaffold.dart';
import 'package:sos_app/widgets/auth_text_field.dart';
import 'package:sos_app/widgets/sos_logo.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _emailSent = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Reset link would be sent to ${_emailController.text.trim()} (UI only)',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBackButton: true,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            const Center(child: SosLogo(size: 56)),
            const SizedBox(height: 24),
            Text(
              'Forgot password?',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _emailSent
                  ? 'Check your inbox for a password reset link.'
                  : 'Enter your email and we will send you a reset link.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            if (_emailSent) ...[
              Icon(
                Icons.mark_email_read_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                _emailController.text.trim(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Back to Sign In'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  setState(() => _emailSent = false);
                },
                child: const Text('Use a different email'),
              ),
            ] else ...[
              AuthTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'you@example.com',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
                validator: FormValidators.email,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
                autocorrect: false,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Send Reset Link'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Back to Sign In'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}