import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = [
    Column(
      children: [
        SizedBox(height: 50), // Space under status bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search plants & Flowers",
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(height: 20), // Space after search bar
        Expanded(
          child: Center(
            child: Text("Home Page", style: TextStyle(fontSize: 20)),
          ),
        ),
      ],
    ),
    Center(child: Text("Community Page", style: TextStyle(fontSize: 20))),
    Center(child: Text("Explore Page", style: TextStyle(fontSize: 20))),
    Center(child: Text("Profile Page", style: TextStyle(fontSize: 20))),
  ];

  // Function to update selected index when an item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Function to build navigation items dynamically
  Widget _buildNavItem(String assetPath, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index), // Calls _onItemTapped when tapped
      child: Image.asset(
        assetPath,
        width: 30,
        height: 30,
        color: _selectedIndex == index ? Colors.green : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Displays the selected page
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem('assets/Logos/Vector 300 (Stroke).png', 0), // Home
              _buildNavItem('assets/Logos/profile-2user.png', 1), // Community
              const SizedBox(width: 50), // Space for FloatingActionButton
              _buildNavItem('assets/Logos/tree.png', 2), // Explore
              _buildNavItem('assets/Logos/profile-circle.png', 3), // Profile
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF003300),
        elevation: 0,
        child: const Icon(
          Icons.camera_alt,
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
