import 'package:flutter/material.dart';
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
  // (?) is could be null because it can be null if theres no errors and remain so if there are no errors // assign string to provide feedback to the user
  String? _errorFeedback;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // make input fields full width across
        children: [
          Text(
            'Log In',
            textAlign: TextAlign.center,
            style: AppTheme.headingLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Lets pick up where you left of',
            textAlign: TextAlign.center,
            style: AppTheme.titleLarge,
          ),
          const SizedBox(height: 40),

          // Email
          TextFormField(
            //controller is something thatll store the value of whatever the user types into this field. we create the controller and associate it with the (TextFormField)
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
            //controller is something thatll store the value of whatever the user types into this field. we create the controller and associate it with the (TextFormField)
            controller: _passwordController,
            obscureText:
                !_showPassword, // black circles in the inputfield [hidden]
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

          // Error feedback
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
              onPressed: () async {
                // when we call this method it will find each validate functions and if 1 of validation (_formKey.currentState!.validate()) becomes false and if all is passed it becomes true
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _errorFeedback = null;
                  });

                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();

                  print("Attempting sign in..."); // Debug print

                  final user = await AuthService.signIn(email, password);

                  //this try catch is just for error confirmation
                  try {
                    final user = await AuthService.signIn(email, password);
                    print("Sign in result: ${user?.email}"); // Debug print

                    if (user == null) {
                      setState(() {
                        _errorFeedback = 'Incorrect login credentials';
                      });
                    }
                  } catch (e) {
                    print("Sign in error: $e"); // Debug print
                    setState(() {
                      _errorFeedback = 'An error occurred during sign in';
                    });
                  }
                }
              },
              style: AppTheme.primaryButtonStyle,
              child: const Text(
                'Log In',
                style: AppTheme.buttonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
