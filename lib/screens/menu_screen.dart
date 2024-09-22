import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance_app/services/auth_services.dart';
import 'login_screen.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendance_app/utils/constants.dart';

class MenuScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  Future<List<dynamic>> loadMembers() async {
    // Load the JSON file
    final String response =
        await rootBundle.loadString('lib/assets/fake_users.json');
    final data = await json.decode(response);
    return data['members'];
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = _authService.getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ATTENDANCE',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.background,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person, // Replace with your desired icon
                    size: 40,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8), // Space between icon and text
                  Text(
                    currentUser?.displayName ?? "User",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 4),
                  Text(
                    currentUser?.email ?? "",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: AppColors.background,
              ),
            ),
            ListTile(
              title: Text('Attendance',
                  style: TextStyle(color: AppColors.textColor)),
              onTap: () {
                // Navigate to Attendance Screen
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Locations',
                  style: TextStyle(color: AppColors.textColor)),
              onTap: () {
                // Navigate to Locations Screen
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: AppColors.errorColor,
              ),
              title: Text('Sign Out',
                  style: TextStyle(color: AppColors.textColor)),
              onTap: () async {
                await _authService.signOut();
                Get.offAll(LoginScreen());
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: loadMembers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final members = snapshot.data!;
            return ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                return ListTile(
                  title: Text(member['name']),
                  subtitle: Text(member['email']),
                  onTap: () {
                    // Handle member tap (e.g., navigate to details screen)
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
