# Todo-List-App
Deskripsi : adalah aplikasi manajemen tugas berbasis Flutter.  
Dengan aplikasi ini, pengguna bisa membuat, melihat, dan mengelola daftar tugas (to-do list) berdasarkan tanggal tertentu.  

Struktur Project
lib/
├── main.dart # Entry point aplikasi
├── models/
│ └── todo.dart # Model Todo (id, title, description, time, isDone)
├── providers/
│ └── todo_provider.dart # State management dengan ChangeNotifier
├── screens/
│ ├── home_screen.dart # Halaman utama (list todo per tanggal)
│ └── task_detail_screen.dart# (opsional) detail tugas
└── widgets/
└── todo_item.dart # Widget tampilan 1 item todo


MaterialApp
└── HomeScreen (Scaffold)
├── AppBar
├── Body (Column)
│ ├── Date Selector (ListView horizontal)
│ ├── "My Tasks" + navigation buttons
│ └── Expanded
│ └── ListView / Text("No tasks for this day")
└── FloatingActionButton (Add Task)


State Management
Aplikasi ini menggunakan **Provider (ChangeNotifier)** untuk state management.

### Alasan Pemilihan Provider
1. **Sederhana & Efisien** → Mudah digunakan untuk aplikasi skala kecil hingga menengah.  
2. **Reactive** → Perubahan data di `TodoProvider` otomatis mengupdate UI.  
3. **Best Practice Flutter** → Banyak digunakan di komunitas Flutter, dokumentasi resmi pun menyarankan.  
4. **Pemeliharaan Mudah** → Kode lebih terstruktur karena pemisahan antara UI (`screens/`, `widgets/`) dan logika (`providers/`, `models/`).

# Demo #



<img width="438" height="926" alt="Screenshot 2025-09-06 104019" src="https://github.com/user-attachments/assets/b81eb463-cba8-4077-b04e-b2e943b1a5cf" />
<img width="436" height="925" alt="Screenshot 2025-09-06 103958" src="https://github.com/user-attachments/assets/1d5e2190-07a0-4e02-9741-edc8feef5265" />
<img width="435" height="924" alt="Screenshot 2025-09-06 103939" src="https://github.com/user-attachments/assets/444b6880-ef25-467c-abd8-cadd2b638a6b" />
