import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'logoutsuccess.dart'; // Import LogoutSuccess page

// Secure Storage Instance
final FlutterSecureStorage secureStorage = FlutterSecureStorage();

class LogoutConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.logout, size: 60, color: Colors.brown),
            SizedBox(height: 16),
            Text(
              "Oh no! You're leaving...\nAre you sure?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    minimumSize: Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Nah, Just Kidding",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(height: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.brown, width: 2),
                    minimumSize: Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    await logoutUser(context);
                  },
                  child: Text(
                    "Yes, Log Me Out",
                    style: TextStyle(color: Colors.brown, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Function to handle logout
Future<void> logoutUser(BuildContext context) async {
  try {
    // Retrieve userId before clearing storage
    String? userId = await secureStorage.read(key: "userId");

    // Clear all storage except userId
    await secureStorage.deleteAll();
    if (userId != null) {
      await secureStorage.write(key: "userId", value: userId);
    }

    // Navigate to LogoutSuccess screen
    Navigator.pop(context); // Close dialog
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LogoutSuccess()),
    );
  } catch (e) {
    print("Error during logout: $e");
  }
}

// Function to show the dialog when logout icon is tapped
void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return LogoutConfirm();
    },
  );
}
