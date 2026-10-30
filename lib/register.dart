import 'package:flutter/material.dart';
import 'package:loginregister/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _civilStatusController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();

  String? _fullnameError;
  String? _usernameError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _genderError;
  String? _civilStatusError;
  String? _birthdateError;

  void _register () {
    final String password = _passwordController.text;
    final String confirm = _confirmPasswordController.text;

    setState(() {
      _fullnameError = _fullnameController.text.trim().isEmpty
          ? 'Full name is required' : null;
      _usernameError = _usernameController.text.trim().isEmpty
          ? 'Username is required' : null;
      _passwordError = password.isEmpty
          ? 'Password is required' : null;
      _confirmPasswordError = confirm.isEmpty
          ? 'Please confirm your password'
          : confirm != password
              ? 'Passwords do not match' : null;
      _genderError = _genderController.text.isEmpty
          ? 'Please select a gender' : null;
      _civilStatusError = _civilStatusController.text.isEmpty
          ? 'Please select a civil status' : null;
      _birthdateError = _birthdateController.text.isEmpty
          ? 'Please select your birthdate' : null;
    });

    if (_fullnameError != null ||
        _usernameError != null ||
        _passwordError != null ||
        _confirmPasswordError != null ||
        _genderError != null ||
        _civilStatusError != null ||
        _birthdateError != null) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registered successfully'),
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

    InputDecoration _inputDecoration (String label, IconData icon, {String? errorText}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      errorText: errorText,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oñez_Task 6'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _fullnameController,
              onChanged: (_) {
                if (_fullnameError != null) setState(() => _fullnameError = null);
              },
              decoration: _inputDecoration('FullName', Icons.person, errorText: _fullnameError),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _usernameController,
              onChanged: (_) {
                if (_usernameError != null) setState(() => _usernameError = null);
              },
              decoration: _inputDecoration('Username', Icons.account_circle, errorText: _usernameError),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              onChanged: (_) {
                if (_passwordError != null) setState(() => _passwordError = null);
              },
              decoration: _inputDecoration('Password', Icons.lock, errorText: _passwordError),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _confirmPasswordController,
              onChanged: (_) {
                if (_confirmPasswordError != null) setState(() => _confirmPasswordError = null);
              },
              decoration: _inputDecoration('Confirm Password', Icons.lock_outline, errorText: _confirmPasswordError),
            ),
            const SizedBox(height: 15),
            DropdownMenu<String>(
              controller: _genderController,
              expandedInsets: EdgeInsets.zero,
              requestFocusOnTap: false,
              menuHeight: 200,
              label: const Text('Gender'),
              leadingIcon: const Icon(Icons.male_rounded),
              errorText: _genderError,
              onSelected: (_) => setState(() => _genderError = null),
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: 'Male', label: 'Male'),
                DropdownMenuEntry(value: 'Female', label: 'Female'),
                DropdownMenuEntry(
                    value: 'Prefer not to say', label: 'Prefer not to say'),
              ],
            ),
            const SizedBox(height: 15),
            DropdownMenu<String>(
              controller: _civilStatusController,
              expandedInsets: EdgeInsets.zero,
              requestFocusOnTap: false,
              menuHeight: 200,
              label: const Text('Civil Status'),
              leadingIcon: const Icon(Icons.people),
              errorText: _civilStatusError,
              onSelected: (_) => setState(() => _civilStatusError = null),
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: 'Single', label: 'Single'),
                DropdownMenuEntry(value: 'Married', label: 'Married'),
                DropdownMenuEntry(value: 'Widowed', label: 'Widowed'),
                DropdownMenuEntry(value: 'Separated', label: 'Separated'),
                DropdownMenuEntry(value: 'Divorced', label: 'Divorced'),
              ],
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _birthdateController,
              readOnly: true,
              canRequestFocus: false,
              decoration: _inputDecoration('Birthdate', Icons.calendar_today, errorText: _birthdateError),
              onTap: () async{
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null){
                  setState(() {
                    _birthdateController.text =
                    "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                    _birthdateError = null;
                  });
                }
              },
            ),
            const SizedBox(height: 25),
            ElevatedButton(onPressed: _register,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Register',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        ),
        ),
      ),
    );
  }
}