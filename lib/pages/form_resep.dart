import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_recipeez/theme/color_palette.dart';
import '../models/resep.dart';

class FormResep extends StatefulWidget {
  final Resep? resep;
  const FormResep({super.key, this.resep});

  @override
  State<FormResep> createState() => _FormResepState();
}

class _FormResepState extends State<FormResep> {
  final supabase = Supabase.instance.client;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController stepsController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.resep != null) {
      nameController.text = widget.resep!.nama;
      ingredientsController.text = widget.resep!.bahan;
      stepsController.text = widget.resep!.langkah;
      imageController.text = widget.resep!.gambar;
    }
  }

  Future<void> simpanResep() async {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama masakan harus diisi')),
      );
      return;
    }

    if (ingredientsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bahan harus diisi')),
      );
      return;
    }

    if (stepsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Langkah harus diisi')),
      );
      return;
    }

    if (widget.resep == null) {
      await supabase.from('resep').insert({
        'nama': nameController.text,
        'bahan': ingredientsController.text,
        'langkah': stepsController.text,
        'gambar': imageController.text.isEmpty
            ? 'https://via.placeholder.com/150'
            : imageController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resep berhasil ditambahkan 🍳')),
      );

    } else {
      await supabase.from('resep').update({
        'nama': nameController.text,
        'bahan': ingredientsController.text,
        'langkah': stepsController.text,
        'gambar': imageController.text.isEmpty
            ? 'https://via.placeholder.com/150'
            : imageController.text,
      }).eq('id', widget.resep!.id!);
      
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resep berhasil diperbarui ✏️')),
    );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.resep == null ? 'Tambah Resep' : 'Edit Resep'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nama Masakan:', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              const SizedBox(height: 7),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: '…',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: darkChoco),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: darkChoco,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text('Bahan:', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              const SizedBox(height: 7),
              TextField(
                controller: ingredientsController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: '…',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: darkChoco),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: darkChoco,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text('Langkah:', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              const SizedBox(height: 7),
              TextField(
                controller: stepsController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: '…',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: darkChoco),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: darkChoco,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'URL Gambar (Opsional):',
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
              const SizedBox(height: 7),
              TextField(
                controller: imageController,
                decoration: InputDecoration(
                  labelText: '…',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: darkChoco),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: darkChoco,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkChoco,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: simpanResep,
                child: const Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}