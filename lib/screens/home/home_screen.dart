import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          "Home Screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 25.0), // Adjust spacing
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavBarItem('assets/Logos/Vector 300 (Stroke).png', 0),
              SizedBox(width: 10), // Move 2nd icon slightly left
              _buildNavBarItem('assets/Logos/profile-2user.png', 1),
              const SizedBox(width: 50), // Space for FloatingActionButton
              _buildNavBarItem('assets/Logos/tree.png', 2),
              SizedBox(width: 10), // Move 3rd icon slightly right
              _buildNavBarItem('assets/Logos/profile-circle.png', 3),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // No functionality for now
        backgroundColor: const Color(0xFF003300), // Green background
        elevation: 0, // Flat look
        child: const Icon(
          Icons.camera_alt, // Scanner icon
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavBarItem(String assetPath, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Image.asset(
        assetPath,
        width: 30,
        height: 30,
        color: _selectedIndex == index ? Colors.green : Colors.grey,
      ),
    );
  }
}
