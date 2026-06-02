import 'package:flutter/material.dart';
import 'package:sos_app/validators/form_validators.dart';
import 'package:sos_app/widgets/auth_scaffold.dart';
import 'package:sos_app/widgets/auth_text_field.dart';
import 'package:sos_app/widgets/sos_logo.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _termsValidator(bool? _) {
    if (!_acceptedTerms) {
      return 'You must accept the terms and conditions';
    }
    return null;
  }

  void _submit() {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (!formValid) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sign up form is valid (UI only)'),
        behavior: SnackBarBehavior.floating,
      ),
    );
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
              'Create account',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Join SOS for quick emergency assistance',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            AuthTextField(
              controller: _nameController,
              label: 'Full name',
              hint: 'John Doe',
              prefixIcon: Icons.person_outline,
              validator: FormValidators.fullName,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            AuthTextField(
              controller: _emailController,
              label: 'Email',
              hint: 'you@example.com',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              validator: FormValidators.email,
              textInputAction: TextInputAction.next,
              autocorrect: false,
            ),
            const SizedBox(height: 16),
            AuthTextField(
              controller: _phoneController,
              label: 'Phone (optional)',
              hint: '+1 555 123 4567',
              keyboardType: TextInputType.phone,
              prefixIcon: Icons.phone_outlined,
              validator: FormValidators.phone,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            AuthTextField(
              controller: _passwordController,
              label: 'Password',
              obscureText: _obscurePassword,
              prefixIcon: Icons.lock_outline,
              validator: FormValidators.password,
              textInputAction: TextInputAction.next,
              autocorrect: false,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ),
            const SizedBox(height: 16),
            AuthTextField(
              controller: _confirmPasswordController,
              label: 'Confirm password',
              obscureText: _obscureConfirm,
              prefixIcon: Icons.lock_outline,
              validator: (v) => FormValidators.confirmPassword(
                v,
                _passwordController.text,
              ),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              autocorrect: false,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirm
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  setState(() => _obscureConfirm = !_obscureConfirm);
                },
              ),
            ),
            const SizedBox(height: 8),
            FormField<bool>(
              initialValue: _acceptedTerms,
              validator: _termsValidator,
              builder: (state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _acceptedTerms,
                          onChanged: (v) {
                            setState(() => _acceptedTerms = v ?? false);
                            state.didChange(_acceptedTerms);
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              'I agree to the Terms of Service and Privacy Policy',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (state.hasError)
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 4),
                        child: Text(
                          state.errorText!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Create Account'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}