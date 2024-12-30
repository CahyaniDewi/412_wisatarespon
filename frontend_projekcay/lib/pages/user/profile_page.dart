import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isNotificationOn = true; // Menggunakan state untuk notifikasi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun Saya'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIrt4GDobUKmQDKO8V5eaaJsVGvir5ZT5dFQ&s'), 
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Text(
                    'NI MADE CAHYANI DEWI', 
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Universitas Teknologi Yogyakarta', 
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            ListTile(
              title: Text('Notifikasi'),
              trailing: Switch(
                value: isNotificationOn,
                onChanged: (bool value) {
                  setState(() {
                    isNotificationOn = value; 
                  });
                },
              ),

            ),
            ListTile(
              title: Text('Kelola Akun'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Navigator.pushNamed(context, '/manage_account');
              },
            ),

            ListTile(
              title: Text('Privacy Policy'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Tambahkan logika untuk membuka Privacy Policy
              },
            ),
            ListTile(
              title: Text('Terms of Service'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Tambahkan logika untuk membuka Terms of Service
              },
            ),
          ],
        ),
      ),
    );
  }
}
