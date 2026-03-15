# 👩🏻‍🍳 MyRecipeez 🍽
___
Nama    : Dilla Maharani

NIM     : 2409116023

Kelas   : Sistem Informasi A'24

## ── ⟡ ˙Deskripsi Aplikasi
---
MyRecipeez adalah aplikasi catatan resep masakan sederhana berbasis Flutter.
User dapat menambahkan resep, melihat detail resep, mengedit resep, dan menghapus resep.
Selain itu, user juga dapat memberi gambar resep menggunakan URL (link).

## ── ⟡ ˙Teknologi yang Digunakan
---
- **Flutter** → Framework untuk membangun aplikasi mobile
- **Supabase** → Database backend untuk menyimpan data resep
- **flutter_dotenv** → Menyimpan Supabase URL dan API Key secara aman

## ── ⟡ ˙Fitur Aplikasi
---
- **Create** → Menambahkan resep baru ke database Supabase
- **Read** → Menampilkan daftar resep dari database Supabase
- **Update** → Mengedit data resep
- **Delete** → Menghapus resep dari database
- **Multi Page Navigation** → Navigasi antar halaman
- **Validasi Input** → Field wajib harus diisi
- **Snackbar Feedback** → Menampilkan notifikasi ketika data berhasil ditambah, diubah, atau dihapus

## ── ⟡ ˙Database
---
Aplikasi ini menggunakan **Supabase** sebagai backend database.

Tabel yang digunakan adalah **resep** dengan struktur:

| Field | Tipe Data | Keterangan |
|------|------|------|
| id | int8 | Primary key |
| nama | text | Nama masakan |
| bahan | text | Bahan resep |
| langkah | text | Langkah memasak |
| gambar | text | URL gambar masakan |

## ── ⟡ ˙Environment Variable
---
Aplikasi menggunakan file `.env` untuk menyimpan konfigurasi Supabase agar API Key tidak ditulis langsung di kode.

Contoh isi file `.env`:

SUPABASE_URL=supabase_url

SUPABASE_ANON_KEY=anon_key

File `.env` tidak diupload ke repository karena sudah dimasukkan ke `.gitignore`.

## ── ⟡ ˙Widget yang Digunakan
### **Core Structure**
---
**1. MaterialApp**  

   🖿: main.dart
   
   Digunakan sebagai root aplikasi.

   ```dart
return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'MyRecipeez',
  theme: ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: coffee,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: darkChoco,
    ),
  ),
  home: const HomePage(),
);
```
    
**2. Scaffold**  

   🖿: home_page.dart, detail_resep.dart, form_resep.dart

   Digunakan sebagai struktur dasar halaman.

   ```dart
return Scaffold(
  appBar: AppBar(
    title: const Text('⋆｡‧˚ʚ  👩🏻‍🍳  MyRecipeez  👨🏻‍🍳  ɞ˚‧｡⋆'),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: const Icon(Icons.add),
  ),
  body: ListView.builder(
    itemCount: daftarResep.length,
    itemBuilder: (context, index) {
      return const SizedBox();
    },
  ),
);
```

**3. AppBar**  

   Digunakan sebagai header di setiap halaman.
   
   🖿: home_page.dart, detail_resep.dart, form_resep.dart

   ```dart
appBar: AppBar(
  title: const Text('⋆｡‧˚ʚ  👩🏻‍🍳  MyRecipeez  👨🏻‍🍳  ɞ˚‧｡⋆'),
),
```

**4. FloatingActionButton**  

   Digunakan untuk tombol tambah resep.

   🖿: home_page.dart

   ```dart
FloatingActionButton(
  shape: const CircleBorder(),
  onPressed: () async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormResep()),
    );
    getResep(); // ambil ulang data dari Supabase
  },
  child: const Icon(Icons.add),
)
```

### **List & Display**
---
**5. ListView.builder**  

   Digunakan untuk menampilkan daftar resep secara dinamis.
   
   🖿: home_page.dart

   ```dart
ListView.builder(
  itemCount: daftarResep.length,
  itemBuilder: (context, index) {
    final r = daftarResep[index];

    return Card(
      child: ListTile(
        title: Text(r.nama),
      ),
    );
  },
);
```

**6. Card**  

   Digunakan untuk membungkus setiap item resep agar terlihat rapi dan memiliki bayangan.
   
   🖿: home_page.dart

   ```dart
Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
  elevation: 5,
  child: ListTile(
    title: Text("𐂐 ${r.nama}"),
  ),
)
```

**7. ListTile**

   Digunakan untuk menampilkan nama resep dan tombol hapus dalam satu baris.
   
   🖿: home_page.dart

   ```dart
ListTile(
  title: Text("𐂐 ${r.nama}"),
  subtitle: const Text('Tap untuk lihat detail'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailResep(
          resep: r,
          index: index,
          onUpdate: updateResep,
        ),
      ),
    );
  },
);
```

**8. Image.network**

   Digunakan untuk menampilkan gambar resep dari URL.

   🖿: home_page.dart, detail_resep.dart

   ```dart
Image.network(
  r.gambar,
  width: double.infinity,
  height: 125,
  fit: BoxFit.cover,
),
```

**9. Container & ClipRRect**  

   Digunakan untuk styling gambar (border dan rounded corner).

   🖿: home_page.dart, detail_resep.dart

   ```dart
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    border: Border.all(color: darkChoco, width: 10),
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.network(resep.gambar),
  ),
);
```


**10. Text**

   Digunakan untuk menampilkan teks seperti nama resep, bahan, dan langkah.

   🖿: home_page.dart, detail_resep.dart, form_resep.dart

   ```dart
Text(
  "𐂐 ${r.nama}",
  style: const TextStyle(
    fontWeight: FontWeight.bold,
  ),
),
```

**11. IconButton**  

   Digunakan untuk tombol edit dan hapus.

   🖿: home_page.dart, detail_resep.dart

   ```dart
IconButton(
  icon: const Icon(Icons.delete, color: coffee),
  onPressed: () {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Resep'),
      ),
    );
  },
),
```

### **Form Input**
---

**12. TextField**  

   Digunakan untuk input data resep (nama, bahan, langkah, URL gambar).

   🖿: form_resep.dart

   ```dart
TextField(
  controller: nameController,
  decoration: InputDecoration(
    labelText: '…',
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(color: darkChoco),
    ),
  ),
),
```

**13. ElevatedButton**  

   Digunakan untuk tombol Simpan pada form.

   🖿: form_resep.dart

   ```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: darkChoco,
  ),
  onPressed: simpanResep,
  child: const Text('Simpan'),
),
```

### **Layout**
---
**14. Column, Padding, SizedBox**  

   Digunakan untuk mengatur tata letak dan jarak antar elemen.

   🖿: home_page.dart, detail_resep.dart, form_resep.dart

   ```dart
Padding(
  padding: const EdgeInsets.all(25),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('🥘─── Bahan:'),
      const SizedBox(height: 5),
      Text(resep.bahan),
    ],
  ),
);
```

**15. Center**

  Digunakan untuk menempatkan widget di tengah layar, seperti indikator loading.

  🖿: home_page.dart

  ```dart
Center(
  child: CircularProgressIndicator(),
)
```

### **Navigation**
---


**16. Navigator & MaterialPageRoute**  

   Digunakan untuk berpindah halaman (Multi Page Navigation).

   🖿: home_page.dart, detail_resep.dart, form_resep.dart

   ```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailResep(
      resep: r,
      index: index,
      onUpdate: updateResep,
    ),
  ),
);
```

### **Feedback / Interaction**
---
**17. AlertDialog**  

   Digunakan sebagai konfirmasi sebelum menghapus resep.

   🖿: home_page.dart

   ```dart
showDialog(
  context: context,
  builder: (context) {
    return AlertDialog(
      title: const Text('Hapus Resep'),
      content: const Text('Yakin mau hapus resep ini?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            hapusResep(index);
            Navigator.pop(context);
          },
          child: const Text('Hapus'),
        ),
      ],
    );
  },
);
```

**18. SnackBar**

  Digunakan untuk menampilkan notifikasi ketika data resep berhasil ditambahkan, diperbarui, atau dihapus.

  🖿: home_page.dart, form_resep.dart

  ```dart
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('Resep berhasil ditambahkan'),
  ),
);
```

**19. CircularProgressIndicator**

  Digunakan untuk menampilkan indikator loading saat data resep sedang diambil dari database Supabase.

  🖿: home_page.dart

  ```dart
Center(
  child: CircularProgressIndicator(),
)
```

## ── ⟡ ˙Tampilan Aplikasi

**1. Halaman Utama**  

Halaman ini menampilkan daftar resep dalam bentuk card dengan gambar di bagian atas dan nama resep di bawahnya. Terdapat tombol tambah (+) di pojok kanan bawah untuk menambahkan resep baru. Setiap resep memiliki tombol hapus dan dapat ditekan untuk melihat detailnya.

<img width="250" height="550" alt="image" src="https://github.com/user-attachments/assets/e479ce7f-842b-4394-b9fb-cfeb7875a89e" />


**2. Halaman Detail Resep**  

Halaman ini menampilkan gambar resep yang lebih besar, serta informasi bahan dan langkah memasaknya. Terdapat tombol edit di bagian kanan atas untuk mengubah data resep.

<img width="250" height="550" alt="image" src="https://github.com/user-attachments/assets/f9084c88-f17e-4e5b-b790-845d640a2c16" />


**3. Halaman Form Tambah / Edit Resep**

Halaman ini berisi 4 input field:

- Nama Masakan

- Bahan

- Langkah

- URL Gambar (Opsional)

Terdapat tombol “Simpan” yang digunakan untuk menyimpan data resep.

<img width="250" height="550" alt="image" src="https://github.com/dillamhrn/Mini-Project-2-PAB/blob/fc3e6b95c36b7f4f43c0fce1cee94066e64e8eb2/image.png" /> <img width="250" height="550" alt="image" src="https://github.com/dillamhrn/Mini-Project-2-PAB/blob/39c57cd8fc1a5ae3f9f68107ca3c35cfdf33f17c/editresep.png" />
