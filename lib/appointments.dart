import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentsPage extends StatefulWidget {
  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  List<String> appointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      appointments = prefs.getStringList('appointments') ?? [];

      // Add a default sample appointment if the list is empty
      if (appointments.isEmpty) {
        appointments.add("Appointment on 12th March, 3:00 PM");
        prefs.setStringList('appointments', appointments);
      }
    });
  }

  Future<void> _removeAppointment(int index) async {
    setState(() {
      appointments.removeAt(index);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('appointments', appointments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Appointments",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFCE7CC), Color.fromARGB(255, 240, 231, 221)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            return Card(
              color: Color.fromARGB(255, 254, 242, 206), // Brown background for appointment container
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                leading: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.calendar_today, color: Colors.brown, size: 28),
                    Positioned(
                      bottom: 2,
                      child: Text(
                        "📅", // Calendar emoji inside the icon
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                title: Text(
                  appointments[index],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.brown),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.close, color: Colors.brown),
                  onPressed: () => _removeAppointment(index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
