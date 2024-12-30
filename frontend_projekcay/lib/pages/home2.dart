// import 'package:flutter/material.dart';
// import 'package:frontend_projekcay/service/wisata_service.dart'; // Import wisata service
// import 'package:frontend_projekcay/service/auth.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Map<String, dynamic>> wisataList = [];
//   bool isLoading = true;
//   int _selectedIndex = 0;

//   // Daftar kategori adventure
//   List<Map<String, dynamic>> kategoriAdventure = [
//     {'name': 'Pantai', 'icon': Icons.beach_access},
//     {'name': 'Pura', 'icon': Icons.temple_hindu},
//     {'name': 'Taman', 'icon': Icons.nature_people},
//     {'name': 'Cultural', 'icon': Icons.language},
//     {'name': 'Petualangan', 'icon': Icons.explore},
//   ];

//   // Daftar rekomendasi wisata dummy
//   List<Map<String, dynamic>> rekomendasiWisataDummy = [
//     {
//       'name': 'Pantai Kuta',
//       'photoUrl': 'https://images.ctfassets.net/pj3idduy0ni9/2BsaLfhco58uafWL3eDtDf/5aa74e43e3a26a0da9fa8cf78ca4f0a7/wisata-pantai-kuta-bali.jpg',
//       'link': 'https://www.google.com/maps/place/Pantai+Kuta/'
//     },
//     {
//       'name': 'Pura Besakih',
//       'photoUrl': 'https://media.istockphoto.com/id/1353968804/id/foto/pura-besakih-temple-in-bali-indonesia.jpg?s=612x612&w=0&k=20&c=Qv9yYgB5BsJd5yZ2cIfyt_Mtzf7FXPNJaGTgOpwRZUg=',
//       'link': 'https://www.google.com/maps/place/Pura+Besakih/'
//     },
//     {
//       'name': 'Danau Batur',
//       'photoUrl': 'https://ik.imagekit.io/tvlk/blog/2021/08/Destinasi-Wisata-di-Kintamani-Pura-Ulun-Danu-Batur-Shutterstock.jpg',
//       'link': 'https://www.google.com/maps/place/Danau+Batur/'
//     },
//     {
//       'name': 'Taman Ujung',
//       'photoUrl': 'https://media-cdn.tripadvisor.com/media/photo-s/16/0d/b4/65/taman-ujung-karangasem.jpg',
//       'link': 'https://www.google.com/maps/place/Taman+Ujung/'
//     },
//   ];


//   // Mengambil data wisata dengan memanggil fungsi dari wisata_service.dart
//   Future<void> fetchWisata() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final data = await WisataService.fetchWisata(); // Memanggil fungsi fetchWisata
//       setState(() {
//         wisataList = data; // Set data wisata
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       print("Error fetching data: $e");
//     }
//   }

//   // Fungsi untuk memperbarui wisata
//   Future<void> _updateWisata(int id) async {
//     final TextEditingController nameController = TextEditingController();
//     final TextEditingController descriptionController = TextEditingController();
//     final TextEditingController photoUrlController = TextEditingController();
//     final TextEditingController locationController = TextEditingController();

//     final wisata = wisataList.firstWhere((w) => w['id'] == id);

//     nameController.text = wisata['name'];
//     descriptionController.text = wisata['description'];
//     photoUrlController.text = wisata['photo_url'];
//     locationController.text = wisata['location'];

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Update Wisata'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
//               TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
//               TextField(controller: photoUrlController, decoration: InputDecoration(labelText: 'Photo URL')),
//               TextField(controller: locationController, decoration: InputDecoration(labelText: 'Location')),
//             ],
//           ),
//           actions: [
//             TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
//             TextButton(
//               onPressed: () async {
//                 await WisataService.updateWisata(
//                   id,
//                   nameController.text,
//                   descriptionController.text,
//                   photoUrlController.text,
//                   locationController.text,
//                 );
//                 fetchWisata();
//                 Navigator.pop(context);
//               },
//               child: Text('Update'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Fungsi untuk menghapus wisata
//   Future<void> _deleteWisata(int id) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Hapus Wisata'),
//           content: Text('Apakah Anda yakin ingin menghapus wisata ini?'),
//           actions: [
//             TextButton(onPressed: () => Navigator.pop(context), child: Text('Batal')),
//             TextButton(
//               onPressed: () async {
//                 await WisataService.deleteWisata(id);
//                 fetchWisata();
//                 Navigator.pop(context);
//               },
//               child: Text('Hapus'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Fungsi untuk menangani navigasi pada BottomNavigationBar
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     if (index == 1) {
//       Navigator.pushNamed(context, '/profile'); // Halaman Profil
//     } else if (index == 2) {
//       logout();
//       Navigator.pushReplacementNamed(context, '/login'); // Logout
//     }
//   }

//   // Fungsi untuk menambahkan wisata baru
//   Future<void> _createWisata() async {
//     final TextEditingController nameController = TextEditingController();
//     final TextEditingController descriptionController = TextEditingController();
//     final TextEditingController photoUrlController = TextEditingController();
//     final TextEditingController locationController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Tambah Wisata'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
//               TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
//               TextField(controller: photoUrlController, decoration: InputDecoration(labelText: 'Photo URL')),
//               TextField(controller: locationController, decoration: InputDecoration(labelText: 'Location')),
//             ],
//           ),
//           actions: [
//             TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
//             TextButton(
//               onPressed: () async {
//                 await WisataService.addWisata(
//                   nameController.text,
//                   descriptionController.text,
//                   photoUrlController.text,
//                   locationController.text,
//                 );
//                 fetchWisata();
//                 Navigator.pop(context);
//               },
//               child: Text('Tambah'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchWisata();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home - Wisata'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // Banner Section
//                   Container(
//                     width: double.infinity,
//                     height: 150,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: NetworkImage('https://images.ctfassets.net/pj3idduy0ni9/2BsaLfhco58uafWL3eDtDf/5aa74e43e3a26a0da9fa8cf78ca4f0a7/wisata-pantai-kuta-bali.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Selamat Datang! Jelajahi Wisata Terbaik',
//                         style: TextStyle(
//                           fontSize: 24,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),

//                   // GridView Kategori
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     height: 200,
//                     child: GridView.builder(
//                       scrollDirection: Axis.horizontal,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 1,
//                         childAspectRatio: 3 / 2,
//                       ),
//                       itemCount: kategoriAdventure.length, 
//                       itemBuilder: (context, index) {
//                         return Card(
//                           margin: EdgeInsets.symmetric(horizontal: 10),
//                           elevation: 4,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(kategoriAdventure[index]['icon'], size: 40, color: Colors.blue),
//                               Text(kategoriAdventure[index]['name']),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 20),

//                   // Daftar Wisata
//                   wisataList.isEmpty
//                       ? Center(child: Text('Belum ada data wisata', style: TextStyle(fontSize: 16, color: Colors.grey)))
//                       : ListView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: wisataList.length,
//                           itemBuilder: (context, index) {
//                             final wisata = wisataList[index];
//                             return Card(
//                               margin: EdgeInsets.all(8),
//                               elevation: 4,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: ListTile(
//                                 title: Text(wisata['name'], style: TextStyle(fontWeight: FontWeight.bold)),
//                                 subtitle: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(wisata['description'], maxLines: 2, overflow: TextOverflow.ellipsis),
//                                     SizedBox(height: 4),
//                                     Text('Location: ${wisata['location']}', style: TextStyle(fontSize: 12, color: Colors.grey)),
//                                   ],
//                                 ),
//                                 leading: ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.network(wisata['photo_url'], width: 50, height: 50, fit: BoxFit.cover),
//                                 ),
//                                 trailing: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     IconButton(
//                                       icon: Icon(Icons.edit, color: Colors.blue),
//                                       onPressed: () => _updateWisata(wisata['id']),
//                                     ),
//                                     IconButton(
//                                       icon: Icon(Icons.delete, color: Colors.red),
//                                       onPressed: () => _deleteWisata(wisata['id']),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),

//                   SizedBox(height: 20),
//                   // Rekomendasi Wisata Dummy
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Rekomendasi Tempat Wisata ',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     itemCount: rekomendasiWisataDummy.length,
//                     itemBuilder: (context, index) {
//                       final wisata = rekomendasiWisataDummy[index];
//                       return Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//                               child: Image.network(wisata['photoUrl'],
//                                   width: double.infinity, height: 100, fit: BoxFit.cover),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(wisata['name'],
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                   textAlign: TextAlign.center),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),



            
//       floatingActionButton: FloatingActionButton(
//         onPressed: _createWisata, 
//         child: Icon(Icons.add),
//         backgroundColor: Colors.blue,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
//           BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'), // Tombol Logout
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         onTap: _onItemTapped,  // Melakukan navigasi sesuai dengan tab yang dipilih
//       ),
//     );
//   }
// }
