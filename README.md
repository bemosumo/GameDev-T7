# Tutorial 7 Game Development

**Nama:** Muhammad Fawwaz Edsa Fatin S

**NPM:** 2306275582

---

## Implementasi Mekanik 3D, Desain Level Dasar, dan Latihan Mandiri

Pada tutorial ini, saya telah mempelajari dan mengimplementasikan dasar-dasar pengembangan game tiga dimensi (3D) di Godot Engine. Saya mengimplementasikan *game mechanics* dasar seperti pergerakan karakter *First-Person*, interaksi objek dengan *raycast*, pembuatan level 3D menggunakan *Constructive Solid Geometry* (CSG), serta mengerjakan latihan mandiri berupa mekanik *sprinting*, sistem koleksi *item*, dan modifikasi *goal condition*.

Berikut adalah fitur dan mekanik yang telah saya kembangkan beserta penjelasan implementasinya:

### 1. Pergerakan Karakter 3D & Kontrol Kamera (Wajib)
Saya membuat karakter yang dapat bergerak bebas di ruang 3D (maju, mundur, kiri, kanan, lompat) dan dapat melihat sekeliling menggunakan kontrol *mouse*.
* **Proses Pengerjaan:** Saya menggunakan node `CharacterBody3D` sebagai basis pemain, yang dilengkapi dengan `CollisionShape3D` dan `MeshInstance3D`. Untuk pergerakan, input didaftarkan melalui *Project Settings -> Input Map*. Saya menggunakan fungsi `lerp` di dalam script agar percepatan karakter mulus, dan `move_and_slide()` untuk mengaplikasikan *velocity*. Rotasi kamera dikontrol dengan menangkap kursor (*Mouse Mode Captured*) dan merotasi node `Head` (sumbu Y) serta `Camera3D` (sumbu X) berdasarkan parameter dari `InputEventMouseMotion`.

### 2. Interaksi Objek Menggunakan Raycast (Wajib)
Pemain kini dapat berinteraksi dengan lingkungan sekitarnya, seperti menyalakan dan mematikan objek lampu (*Switch*).
* **Proses Pengerjaan:** Saya memanfaatkan node `RayCast3D` yang diposisikan menghadap lurus ke depan sebagai *child* dari kamera pemain. Di sisi objek target, saya mendefinisikan *class* dasar `Interactable`. Ketika *raycast* mendeteksi kolisi dengan objek yang memiliki turunan *class* `Interactable`, dan pemain menekan tombol aksi ('E'), fungsi `interact()` akan tereksekusi untuk mengubah properti `light_energy` pada `OmniLight3D`.

### 3. Pembuatan Level & Rintangan Menggunakan CSG (Wajib)
Saya merancang level 3D sederhana tanpa memodelkan aset dari luar, melainkan langsung menyusunnya di dalam Godot menggunakan alat CSG.
* **Proses Pengerjaan:** Menggunakan node `CSGBox3D`, `CSGCylinder3D`, dan `CSGCombiner3D`. Saya merancang ruangan tertutup dengan mengaktifkan properti *Flip Faces* dan *Use Collision*. Saya juga memanfaatkan operasi *boolean* seperti *Union* untuk menggabungkan objek serta melubangi lantai (membentuk jurang). Pewarnaan dilakukan dengan membuat `StandardMaterial3D` baru dan mengubah properti warna pada menu *Albedo*.

### 4. Area Triggers: Win Screen & Jurang (Wajib)
Terdapat zona spesifik di dalam level yang dapat memicu perpindahan *scene* atau memuat ulang level saat pemain menyentuhnya.
* **Proses Pengerjaan:** Saya menggunakan node `Area3D` yang dilengkapi `CollisionShape3D` dan menghubungkan signal `body_entered` ke *script*. Pada *script* tersebut, terdapat fungsi `get_tree().change_scene_to_file()` yang dinamis karena dipasangkan dengan variabel yang di-*export* (`@export var sceneName`).

### 5. Fitur Sprinting (Latihan Mandiri)
Saya menambahkan *game mechanic* tambahan yang memungkinkan pemain untuk berlari lebih cepat saat menekan tombol tertentu (Shift).
* **Proses Pengerjaan:** Saya mendaftarkan *action* baru bernama `sprint` di *Input Map*. Pada fungsi `_physics_process` di *script* `Player.gd`, saya menambahkan logika kondisional: jika `Input.is_action_pressed("sprint")` bernilai *true*, variabel kecepatan `speed` akan dikalikan dengan konstanta (misal 1.8), sehingga nilai `movement_vector` yang diaplikasikan menjadi lebih besar.

### 6. Sistem Koleksi Koin, HUD Score, dan Syarat Kemenangan (Latihan Mandiri & Polishing)
Saya memperbarui layar *Win Screen* agar hanya bisa diakses setelah pemain memenuhi syarat (*objective*) mengumpulkan sejumlah koin. Koin yang terkumpul ditampilkan langsung di layar pemain (HUD).
* **Proses Pengerjaan:**
    * **Objek Koin:** Dibuat menggunakan `Area3D` dan `CylinderMesh`. Saya menambahkan fungsi `rotate_y(delta)` agar koin memiliki animasi berputar. Ketika mendeteksi pemain masuk ke areanya, koin memanggil fungsi penambah skor lalu menghilang (`queue_free()`).
    * **HUD:** Menggunakan kombinasi node `CanvasLayer` dan `Label` pada *scene* pemain. Teks pada `Label` diperbarui secara dinamis dari *script* pemain setiap kali nilai koin bertambah.
    * **Logika Menang & Jurang:** *Script* `AreaTrigger` dikustomisasi dengan variabel *boolean* `is_win_zone` dan integer `coins_needed`. Jika pemain masuk jurang, level seketika di-reset beserta koinnya. Jika pemain mencapai garis akhir, *script* akan memeriksa kecukupan koin sebelum memanggil `WinScreen.tscn`. Apabila belum cukup, *game* akan menahannya dan menolak memindahkan *scene*.

---

## Referensi
* Godot Docs: [CharacterBody3D](https://docs.godotengine.org/en/stable/classes/class_characterbody3d.html)
* Godot Docs: [Ray-casting](https://docs.godotengine.org/en/stable/tutorials/physics/ray-casting.html)
* Godot Docs: [CSG (Constructive Solid Geometry)](https://docs.godotengine.org/en/stable/tutorials/3d/csg_tools.html)
