class Resep {
  final int? id;
  final String nama;
  final String bahan;
  final String langkah;
  final String gambar;

  Resep({
    this.id,
    required this.nama,
    required this.bahan,
    required this.langkah,
    required this.gambar,
  });

  factory Resep.fromMap(Map<String, dynamic> map) {
    return Resep(
      id: map['id'],
      nama: map['nama'],
      bahan: map['bahan'],
      langkah: map['langkah'],
      gambar: map['gambar'],
    );
  }
}