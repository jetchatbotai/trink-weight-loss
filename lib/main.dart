import 'package:flutter/material.dart';

void main() {
  runApp(const TrinkFitApp());
}

class TrinkFitApp extends StatelessWidget {
  const TrinkFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trink Fit',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.text,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: AppColors.card,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      home: const MainShell(),
    );
  }
}

class AppColors {
  static const Color primary = Color(0xFF2F80ED);
  static const Color secondary = Color(0xFF56CCF2);
  static const Color background = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFF5F9FF);
  static const Color text = Color(0xFF1F2937);
  static const Color subtext = Color(0xFF6B7280);
  static const Color premium = Color(0xFFF2C94C);
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomePage(),
      const ExerciseLibraryPage(),
      const NutritionPage(),
      const MindPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[currentIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Planım',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Egzersiz',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined),
            selectedIcon: Icon(Icons.restaurant_menu),
            label: 'Beslenme',
          ),
          NavigationDestination(
            icon: Icon(Icons.spa_outlined),
            selectedIcon: Icon(Icons.spa),
            label: 'Zihin',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.monitor_weight_outlined,
                color: AppColors.primary,
                size: 30,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trink Fit',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Kilo verme ve fitness planların',
                    style: TextStyle(
                      color: AppColors.subtext,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _sectionTitle('Bugünün Planı'),
        const SizedBox(height: 12),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Yağ Yakıcı Başlangıç',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '20 dakika • Kardiyo + güç • 140 kcal',
                style: TextStyle(color: AppColors.subtext),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WorkoutPlayerPage(
                          title: 'Jumping Jacks',
                        ),
                      ),
                    );
                  },
                  child: const Text('Antrenmanı Başlat'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _sectionTitle('Haftalık İlerleme'),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            DayChip(label: 'Pzt', done: true),
            DayChip(label: 'Sal', done: true),
            DayChip(label: 'Çar', done: false),
            DayChip(label: 'Per', done: false),
            DayChip(label: 'Cum', done: false),
          ],
        ),
        const SizedBox(height: 20),
        _sectionTitle('Öne Çıkan Planlar'),
        const SizedBox(height: 12),
        PlanListTile(
          title: 'Yağ Yakıcı',
          subtitle: '12 hafta • Kardiyo odaklı',
        ),
        const SizedBox(height: 12),
        PlanListTile(
          title: 'Kas Yapıcı',
          subtitle: '10 hafta • Güç odaklı',
        ),
        const SizedBox(height: 12),
        PlanListTile(
          title: 'HIIT Hızlı',
          subtitle: '6 hafta • Yoğun tempo',
        ),
        const SizedBox(height: 12),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Premium',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tüm planlar, gelişmiş analiz, reklamsız deneyim',
                style: TextStyle(color: AppColors.subtext),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PremiumPage()),
                    );
                  },
                  child: const Text('Premium’u Gör'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ExerciseLibraryPage extends StatelessWidget {
  const ExerciseLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = [
      {'name': 'Jumping Jacks', 'cat': 'Cardio'},
      {'name': 'Bodyweight Squat', 'cat': 'Legs'},
      {'name': 'Push Up', 'cat': 'Chest'},
      {'name': 'Forward Lunge', 'cat': 'Legs'},
      {'name': 'Plank', 'cat': 'Core'},
      {'name': 'Mountain Climbers', 'cat': 'Fat Burn'},
      {'name': 'Glute Bridge', 'cat': 'Glutes'},
      {'name': 'Bicycle Crunch', 'cat': 'Abs'},
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Egzersizler',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Her hareket için ayrı detay ekranı',
          style: TextStyle(color: AppColors.subtext),
        ),
        const SizedBox(height: 16),
        ...exercises.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExerciseDetailPage(
                      title: item['name']!,
                      category: item['cat']!,
                    ),
                  ),
                );
              },
              child: _card(
                child: Row(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.play_circle_fill,
                        color: AppColors.primary,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.text,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['cat']!,
                            style: const TextStyle(color: AppColors.subtext),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ExerciseDetailPage extends StatelessWidget {
  final String title;
  final String category;

  const ExerciseDetailPage({
    super.key,
    required this.title,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 260,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.ondemand_video,
                    size: 54,
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Buraya o egzersize özel video / GIF gelecek',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.subtext,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$category • Beginner • 30 sn • 8 kcal',
            style: const TextStyle(color: AppColors.subtext),
          ),
          const SizedBox(height: 16),
          _card(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Çalışan Bölgeler',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                SizedBox(height: 10),
                Text('• Omuz'),
                Text('• Bacak'),
                Text('• Core'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nasıl Yapılır',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                SizedBox(height: 10),
                Text('1. Başlangıç pozisyonunu al'),
                Text('2. Hareketi kontrollü uygula'),
                Text('3. Tempoyu koru'),
                Text('4. Nefesini düzenli kullan'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WorkoutPlayerPage(title: title),
                  ),
                );
              },
              child: const Text('Başlat'),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutPlayerPage extends StatelessWidget {
  final String title;

  const WorkoutPlayerPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_circle_outline,
                        size: 70,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Tam ekran egzersiz oynatıcı alanı',
                        style: TextStyle(
                          color: AppColors.subtext,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '00:28',
              style: TextStyle(
                fontSize: 46,
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Sıradaki: Mountain Climbers',
              style: TextStyle(color: AppColors.subtext),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Duraklat'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Text('Geç'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Beslenme',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Dengeli beslenme içerikleri',
          style: TextStyle(color: AppColors.subtext),
        ),
        const SizedBox(height: 16),
        SimpleTile(title: 'Yağ yakma menüsü'),
        const SizedBox(height: 12),
        SimpleTile(title: 'Protein odaklı tarifler'),
        const SizedBox(height: 12),
        SimpleTile(title: 'Su takibi'),
        const SizedBox(height: 12),
        SimpleTile(title: 'Kalori hedefi'),
      ],
    );
  }
}

class MindPage extends StatelessWidget {
  const MindPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Zihin',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Rahatlama ve nefes çalışmaları',
          style: TextStyle(color: AppColors.subtext),
        ),
        const SizedBox(height: 16),
        SimpleTile(title: '5 dk meditasyon'),
        const SizedBox(height: 12),
        SimpleTile(title: 'Nefes egzersizi'),
        const SizedBox(height: 12),
        SimpleTile(title: 'Uyku rahatlatma'),
        const SizedBox(height: 12),
        SimpleTile(title: 'Motivasyon kartları'),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Profil',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Kişisel bilgiler ve ilerleme',
          style: TextStyle(color: AppColors.subtext),
        ),
        const SizedBox(height: 16),
        _card(
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Temel Bilgiler',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              SizedBox(height: 12),
              Text('Boy: 178 cm'),
              SizedBox(height: 8),
              Text('Kilo: 82 kg'),
              SizedBox(height: 8),
              Text('Hedef: 75 kg'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _card(
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'İlerleme',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              SizedBox(height: 12),
              Text('Burada grafik alanı olacak'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PremiumPage()),
              );
            },
            child: const Text('Premium’a Geç'),
          ),
        ),
      ],
    );
  }
}

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trink Fit Premium')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _card(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Premium Avantajlar',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                SizedBox(height: 12),
                Text('• Gelişmiş planlar'),
                Text('• Reklamsız kullanım'),
                Text('• Daha fazla egzersiz'),
                Text('• Gelişmiş analiz'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PriceCard(title: '1 Ay', price: '179 TL'),
          const SizedBox(height: 12),
          PriceCard(title: '3 Ay', price: '399 TL'),
          const SizedBox(height: 12),
          PriceCard(title: '12 Ay', price: '569 TL', best: true),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {},
              child: const Text('Premium’u Satın Al'),
            ),
          ),
        ],
      ),
    );
  }
}

class DayChip extends StatelessWidget {
  final String label;
  final bool done;

  const DayChip({
    super.key,
    required this.label,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: done ? AppColors.primary : AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: done ? Colors.white : AppColors.text,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class PlanListTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const PlanListTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return _card(
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.local_fire_department,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: AppColors.subtext),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SimpleTile extends StatelessWidget {
  final String title;

  const SimpleTile({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return _card(
      child: Row(
        children: [
          const Icon(Icons.chevron_right, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PriceCard extends StatelessWidget {
  final String title;
  final String price;
  final bool best;

  const PriceCard({
    super.key,
    required this.title,
    required this.price,
    this.best = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: best ? AppColors.premium : AppColors.primary.withOpacity(0.15),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  price,
                  style: const TextStyle(color: AppColors.subtext),
                ),
              ],
            ),
          ),
          if (best)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.premium,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'En iyi fiyat',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget _sectionTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: AppColors.text,
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(24),
    ),
    child: child,
  );
}
