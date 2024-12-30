import 'package:flutter/material.dart';
import 'package:frontend_projekcay/service/wisata_service.dart'; // Mengimpor WisataService

class WisataPage extends StatefulWidget {
  final int wisataId;

  const WisataPage({super.key, required this.wisataId});

  @override
  State<WisataPage> createState() => _WisataPageState();
}

class _WisataPageState extends State<WisataPage> {
  Map<String, dynamic>? _wisataDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWisataDetail(); // Mengambil detail wisata ketika halaman dimuat
  }

  // Fungsi untuk mengambil detail wisata dari backend
  Future<void> _fetchWisataDetail() async {
    try {
      var wisataDetail = await WisataService.getWisataDetail(widget.wisataId); // Menggunakan WisataService untuk mengambil detail wisata
      setState(() {
        _wisataDetail = wisataDetail;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching wisata detail: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Wisata"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : _wisataDetail == null
                ? const Center(child: Text('Detail wisata tidak ditemukan.'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _wisataDetail!['name'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Image.network(
                        _wisataDetail!['photo_url'],
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Lokasi: ${_wisataDetail!['location']}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _wisataDetail!['description'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
      ),
    );
  }
}
