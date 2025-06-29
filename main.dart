import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

Widget inputField({
  required String label,
  required IconData icon,
  bool isPassword = false,
}) {
  return Center(
    child: Container(
      width: 320,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      ),
    ),
  );
}

class LoginScreen extends StatelessWidget {
  const LoginScreen();

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Hello Again!',
      subtitle: 'Please sign in to continue',
      formFields: [
        inputField(label: 'Username', icon: Icons.person),
        inputField(label: 'Password', icon: Icons.lock, isPassword: true),
      ],
      actionButtonText: 'Sign In',
      altText: "Don't have a profile?",
      altActionLabel: 'Register',
      onAltAction: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SignUpScreen()),
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen();

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Join Us',
      subtitle: 'Create your account below',
      formFields: [
        inputField(label: 'Username', icon: Icons.person),
        inputField(label: 'Email Address', icon: Icons.email),
        inputField(label: 'Password', icon: Icons.lock, isPassword: true),
        inputField(label: 'Confirm Password', icon: Icons.lock_outline, isPassword: true),
      ],
      actionButtonText: 'Create Account',
      extraWidget: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.g_mobiledata, color: Colors.deepPurple),
        label: const Text('Continue with Google'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.deepPurple,
          side: const BorderSide(color: Colors.deepPurple),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          minimumSize: const Size(320, 48), // match input width and height
        ),
      ),
      altText: 'Already registered?',
      altActionLabel: 'Sign In',
      onAltAction: () => Navigator.pop(context),
    );
  }
}

class AuthLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> formFields;
  final String actionButtonText;
  final String altText;
  final String altActionLabel;
  final VoidCallback onAltAction;
  final Widget? extraWidget;

  const AuthLayout({
    required this.title,
    required this.subtitle,
    required this.formFields,
    required this.actionButtonText,
    required this.altText,
    required this.altActionLabel,
    required this.onAltAction,
    this.extraWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 28),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD1C4E9), Color(0xFF9575CD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 28),
                  ...formFields,
                  const SizedBox(height: 24),
                  Center(
                    child: SizedBox(
                      width: 320,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$actionButtonText button pressed'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(actionButtonText),
                      ),
                    ),
                  ),
                  if (extraWidget != null) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    extraWidget!,
                  ],
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        altText,
                        style: const TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: onAltAction,
                        child: Text(
                          altActionLabel,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
