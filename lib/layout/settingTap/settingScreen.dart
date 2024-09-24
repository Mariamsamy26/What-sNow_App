import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/themestate/themeLogic.dart';
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
            leading:const Icon(Icons.source),
            title:const Text('Source'),
            onTap: () {
              // Navigate to Account settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.sunny),
            title: const Text(' Light Mode'),
            onTap: () {
              context.read<ThemeLogic>().themeSwitchToLight();
            },
          ),
          ListTile(
              leading: const Icon(Icons.nightlight),
              title: const Text("Dark Mode"),
              onTap: (){
                context.read<ThemeLogic>().themeSwitchToDark();
              }
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help and Support'),
            onTap: () {
              // Navigate to Help and Support settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
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

