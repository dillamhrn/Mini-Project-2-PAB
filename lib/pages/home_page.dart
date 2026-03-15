import 'package:flutter/material.dart';
import '../models/resep.dart';
import '../theme/color_palette.dart';
import 'form_resep.dart';
import 'detail_resep.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;
  List<Resep> daftarResep = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getResep();
  }

  Future<void> getResep() async {
    setState(() {
      isLoading = true;
    });
    final data = await supabase.from('resep').select();
    setState(() {
      daftarResep = (data as List)
          .map((item) => Resep.fromMap(item))
          .toList();
      isLoading = false;
    });
  }

  Future<void> hapusResep(int id) async {
    await supabase.from('resep').delete().eq('id', id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resep berhasil dihapus 🗑️')),
    );
    getResep();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⋆｡‧˚ʚ  👩🏻‍🍳  MyRecipeez  👨🏻‍🍳  ɞ˚‧｡⋆'),
      ),
      
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormResep()),
          );
          getResep();
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: daftarResep.length,
                itemBuilder: (context, index) {
                  final r = daftarResep[index];

                  return Card(
                    margin: const EdgeInsets.all(9),
                    color: Theme.of(context).cardColor,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                          child: Image.network(
                            r.gambar,
                            width: double.infinity,
                            height: 125,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 125,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image),
                              );
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "𐂐 ${r.nama}",
                            style: const TextStyle(
                              color: coffee,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: const Text(
                            'Tap untuk lihat detail',
                            style: TextStyle(color: mediumBrown),
                          ),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailResep(resep: r),
                              ),
                            );
                            getResep();
                          },
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: coffee),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: const Text('Hapus Resep'),
                                    content: const Text(
                                      'Yakin mau hapus resep ini?🤔',
                                    ),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: breadCream,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Batal',
                                          style: TextStyle(color: darkChoco),
                                        ),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: darkChoco,
                                        ),
                                        onPressed: () {
                                          hapusResep(r.id!);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Hapus',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}