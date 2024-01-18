// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food/provider/dark_theme_provider.dart';
import 'package:food/screens/favouritescreen.dart';
import 'package:food/screens/login.dart';
import 'package:food/services/authentication/authentication_services.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final AuthenticationServices auth = AuthenticationServices();

  TextEditingController _addressTextController =
      TextEditingController(text: "");
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                "Hello ${FirebaseAuth.instance.currentUser!.email}",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
            Divider(
              height: 5,
              thickness: 4,
            ),
            ListTile(
              title: Text(
                'Address',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Address', style: TextStyle(fontSize: 24)),
              leading: Icon(IconlyLight.profile),
              trailing: Icon(IconlyLight.arrowRight2),
              onTap: () async {
                await _showAddressDialog();
              },
            ),
            ListTile(
              title: Text(
                'Orders',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              leading: Icon(IconlyLight.wallet),
              trailing: Icon(IconlyLight.arrowRight2),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Wishlist',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              leading: Icon(IconlyLight.heart),
              trailing: Icon(IconlyLight.arrowRight2),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavouriteScreen()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Viewed',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.remove_red_eye),
              trailing: Icon(IconlyLight.arrowRight2),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Forgot Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.lock),
              trailing: Icon(IconlyLight.arrowRight2),
              onTap: () {},
            ),
            SwitchListTile(
              title: const Text(
                "Theme",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              secondary: Icon(themeState.getDarkTheme
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined),
              onChanged: (bool value) {
                setState(() {
                  themeState.setDarkTheme = value;
                });
              },
              value: themeState.getDarkTheme,
            ),
            ListTile(
              // ignore: prefer_const_constructors
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.logout),
              trailing: Icon(IconlyLight.arrowRight2),
              onTap: () {
                _showLogoutDialog();
              },
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update"),
            content: TextField(
              onChanged: (value) {},
              controller: _addressTextController,
              maxLines: 5,
              decoration: InputDecoration(hintText: "Enter your address"),
            ),
            actions: [TextButton(onPressed: () {}, child: Text("Update"))],
          );
        });
  }

  Future<void> _showLogoutDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: const [
                Text("Log Out"),
              ],
            ),
            content: const Text("Do you relly want to Logout?"),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Cancel",
                  )),
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: Text("Log Out", style: TextStyle(color: Colors.red))),
            ],
          );
        });
  }
}
