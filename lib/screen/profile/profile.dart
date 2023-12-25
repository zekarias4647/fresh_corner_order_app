import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String firstName = "John";
  String lastName = "Doe";
  String userEmail = "john.doe@example.com";
  String phoneNumber = "123-456-7890";
  String licensePlate = "ABC-123";
  int userPoints = 100; // Example points

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/profile_image.jpg"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "$firstName $lastName",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    userEmail,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.pop(context);
                _editProfile();
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Colors.lightGreen],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("asset/image/719m4JpyUfL-removebg-preview.png"),
              ),
              SizedBox(height: 20),
              Text(
                "$firstName $lastName",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                userEmail,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 10),
              _buildProfileInfoRow(Icons.phone, phoneNumber),
              _buildProfileInfoRow(Icons.car_rental, licensePlate),
              _buildProfileInfoRow(Icons.star, "Points: $userPoints"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _editProfile(),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _editProfile() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                _buildEditField(Icons.person, "First Name", firstName, (value) => setState(() => firstName = value)),
                _buildEditField(Icons.person, "Last Name", lastName, (value) => setState(() => lastName = value)),
                _buildEditField(Icons.phone, "Phone Number", phoneNumber, (value) => setState(() => phoneNumber = value)),
                _buildEditField(Icons.car_rental, "License Plate", licensePlate, (value) => setState(() => licensePlate = value)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Save changes to the server or local storage
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Save Changes"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEditField(IconData icon, String label, String value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 24),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: value),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
