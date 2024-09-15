import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color_manager.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = 'setting Screen';
  Color darkmode =  ColorManager.colorblueblack;
  Color lightmode = ColorManager.colorOffwhite;


  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Log Out'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  FirebaseAuth.instance.signOut();
                },
                child: Text('Log Out',style: TextStyle(color: Theme.of(context).colorScheme.secondary),) ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title:Text(
          "Settings",
          style: GoogleFonts.sevillana(
            fontWeight: FontWeight.bold,
            fontSize: 50,
            color: ColorManager.primaryColor,
          ),
        ),

      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.source),
            title: Text('Source'),
            onTap: () {
              // Navigate to Account settings
            },
          ),
          ListTile(
            leading: Icon(Icons.sunny),
            title: Text(' Light Mode'),
            onTap: () {//light mode
              darkmode = Theme.of(context).colorScheme.background;
            },
          ),
          ListTile(
              leading: Icon(Icons.motion_photos_on_outlined),
              title: Text("Dark Mode"),
              onTap: (){
                lightmode = Theme.of(context).colorScheme.secondary;
              }
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Help and Support'),
            onTap: () {
              // Navigate to Help and Support settings
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log out'),
            onTap: () {
              _logout(context);

               // Call the logout function when tapped
            },
          ),
        ],
      ),
    );
  }
}

