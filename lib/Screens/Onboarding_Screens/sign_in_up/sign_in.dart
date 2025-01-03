import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp2_app/screens/parent_screens/parent_wrapper.dart'; // Add this import
import 'package:fyp2_app/services/auth_service.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;
  String? _errorFeedback;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Log In',
            textAlign: TextAlign.center,
            style: AppTheme.headingLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Lets pick up where you left off',
            textAlign: TextAlign.center,
            style: AppTheme.titleLarge,
          ),
          const SizedBox(height: 40),

          // Email
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: AppTheme.getInputDecoration(
              hint: 'Email',
              icon: Icons.email_outlined,
            ),
            style: AppTheme.bodyLarge,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Password with visibility toggle
          TextFormField(
            controller: _passwordController,
            obscureText: !_showPassword,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: AppTheme.modifyStyle(
                AppTheme.bodyLarge,
                color: AppTheme.textDark.withOpacity(0.5),
              ),
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: AppTheme.secondaryBrown,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility_off : Icons.visibility,
                  color: AppTheme.secondaryBrown,
                ),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              ),
              filled: true,
              fillColor: Colors.white,
              border: AppTheme.defaultBorder,
              enabledBorder: AppTheme.defaultBorder,
              focusedBorder: AppTheme.focusedBorder,
            ),
            style: AppTheme.bodyLarge,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          if (_errorFeedback != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                _errorFeedback!,
                style: AppTheme.modifyStyle(
                  AppTheme.bodyMedium,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          // Submit button
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: _loading ? null : _handleSignIn,
              style: AppTheme.primaryButtonStyle,
              child: _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Log In',
                      style: AppTheme.buttonTextStyle,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _errorFeedback = null;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final user = await AuthService.signIn(email, password);

      if (user != null && mounted) {
        // Navigate to parent dashboard and clear the stack
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ParentWrapper()),
          (Route<dynamic> route) => false,
        );
      } else {
        setState(() {
          _errorFeedback = 'Incorrect login credentials';
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'user-not-found':
            _errorFeedback = 'No user found with this email';
            break;
          case 'wrong-password':
            _errorFeedback = 'Incorrect password';
            break;
          case 'invalid-email':
            _errorFeedback = 'Invalid email address';
            break;
          case 'user-disabled':
            _errorFeedback = 'This account has been disabled';
            break;
          default:
            _errorFeedback = 'An error occurred during sign in';
        }
      });
    } catch (e) {
      setState(() {
        _errorFeedback = 'An unexpected error occurred';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
