import 'package:flutter/material.dart';
import 'package:soulease_bms/services/user_service.dart'; // Updated to use UserService
import 'logoutconfirm.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _pushNotificationEnabled = false; // State for the toggle switch
  String userName = "User"; // Default name in case retrieval fails

  @override
  void initState() {
    super.initState();
    _loadUserName(); // Load the user name from backend
  }

  // Updated to fetch name from backend using UserService
  Future<void> _loadUserName() async {
    UserService userService = UserService();
    Map<String, dynamic>? userData = await userService.fetchUserData();
    print("Fetched User Data: $userData"); // Debugging line

    if (userData != null && userData['name'] != null && mounted) {
      setState(() {
        userName = userData['name'];
      });
    } else {
      print("Error: Name not found in fetched user data.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF795548), Color(0xFFFCEBCB)],
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 4,
                bottom: 30,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.logout, color: Colors.white),
                          onPressed: () {
                            showLogoutDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.0),
                    child: CircleAvatar(
                      radius: screenWidth * 0.1,
                      backgroundColor: Colors.white,
                      child: Text(
                        userName.isNotEmpty
                            ? userName[0].toUpperCase()
                            : 'U', // First letter of name
                        style: TextStyle(
                          fontSize: screenWidth * 0.12,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    userName, // Displaying fetched name
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Write your bio...',
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.brown,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.brown,
                            width: 2.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      ),
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: (screenWidth - 360) / 2,
                      ),
                      child: _buildOuterComponent([
                        _buildMenuItem(
                          icon: Icons.person,
                          title: 'Account',
                          onTap: () {
                            Navigator.pushNamed(context, '/account');
                          },
                        ),
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Icons.notifications,
                          title: 'Notification',
                          onTap: () {
                            Navigator.pushNamed(context, '/notification');
                          },
                        ),
                      ]),
                    ),
                    SizedBox(height: 16.0),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: (screenWidth - 360) / 2,
                      ),
                      child: _buildOuterComponent([
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Icons.lock,
                          title: 'Reset Passwords',
                          onTap: () {
                            Navigator.pushNamed(context, '/passwords');
                          },
                        ),
                        _buildDivider(),
                        _buildToggleMenuItem(
                          icon: Icons.notifications,
                          title: 'Push Notification',
                          value: _pushNotificationEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              _pushNotificationEnabled = value;
                            });
                          },
                        ),
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Icons.info_outline,
                          title: 'About App',
                          onTap: () {
                            Navigator.pushNamed(context, '/aboutapp');
                          },
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOuterComponent(List<Widget> children) {
    return Container(
      width: 360,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Color(0xFF795548), width: 2.0),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color.fromARGB(255, 77, 52, 42)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 77, 52, 42),
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Color.fromARGB(255, 77, 52, 42),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    );
  }

  Widget _buildToggleMenuItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color.fromARGB(255, 77, 52, 42)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 77, 52, 42),
        ),
      ),
      trailing: Transform.scale(
        scale: 0.8,
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
          activeTrackColor: Colors.blue[200],
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey[400],
        ),
      ),
      contentPadding: EdgeInsets.only(left: 10, right: 10),
      onTap: null,
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Divider(
        color: const Color.fromARGB(255, 90, 90, 90),
        thickness: 1.0,
        height: 0,
      ),
    );
  }
}
