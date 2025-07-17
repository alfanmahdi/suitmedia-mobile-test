import 'package:flutter/material.dart';
import 'package:suitmedia_test/models/user_model.dart';

class HomePage extends StatefulWidget {
  final String name;

  const HomePage({super.key, required this.name});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedUserName = 'Selected User Name';

  void _navigateAndSelectUser(BuildContext context) async {
    final result = await Navigator.pushNamed(context, 'user');

    if (result != null && result is User) {
      setState(() {
        _selectedUserName = '${result.firstName} ${result.lastName}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Second Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome', style: TextStyle(fontSize: 14)),
            Text(
              widget.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Center(
                child: Text(
                  _selectedUserName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _navigateAndSelectUser(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Color.fromARGB(255, 43, 99, 123),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                  'Choose a User',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
