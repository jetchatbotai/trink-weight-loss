import 'dart:async';
import 'dart:math';
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
        scaffoldBackgroundColor: const Color(0xFFF4F8FD),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.text,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const MainShell(),
    );
  }
}

class AppColors {
  static const Color primary = Color(0xFF2F80ED);
  static const Color secondary = Color(0xFF56CCF2);
  static const Color background = Color(0xFFF4F8FD);
  static const Color card = Color(0xFFFFFFFF);
  static const Color softBlue = Color(0xFFEAF3FF);
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
    final pages = [
      const HomePage(),
      const ProgramsPage(),
      const NutritionPage(),
      const MindPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[currentIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          setState(() => currentIndex = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Planım',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Programlar',
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

class ExerciseItem {
  final String name;
  final String image;
  final String category;
  final int durationSec;
  final int calories;
  final String difficulty;
  final String description;

  const ExerciseItem({
    required this.name,
    required this.image,
    required this.category,
    required this.durationSec,
    required this.calories,
    required this.difficulty,
    required this.description,
  });
}

class Program {
  final String id;
  final String title;
  final String category;
  final int weeks;
  final int minutes;
  final int cardio;
  final int strength;
  final bool premium;
  final List<Color> colors;
  final List<ExerciseItem> exercises;

  const Program({
    required this.id,
    required this.title,
    required this.category,
    required this.weeks,
    required this.minutes,
    required this.cardio,
    required this.strength,
    required this.premium,
    required this.colors,
    required this.exercises,
  });
}

class DemoData {
  static const List<ExerciseItem> exercisePool = [
    ExerciseItem(
      name: 'Jumping Jacks',
      image: 'assets/exercises/jumping.jpg',
      category: 'Kardiyo',
      durationSec: 60,
      calories: 27,
      difficulty: 'İleri',
      description: 'Klasik kardiyo ısınma ve yağ yakımı egzersizi.',
    ),
    ExerciseItem(
      name: 'Push Up',
      image: 'assets/exercises/pushup.jpg',
      category: 'Güç',
      durationSec: 45,
      calories: 18,
      difficulty: 'Orta',
      description: 'Göğüs, omuz ve kol kuvveti için etkili hareket.',
    ),
    ExerciseItem(
      name: 'Bodyweight Squat',
      image: 'assets/exercises/squat.jpg',
      category: 'Alt Vücut',
      durationSec: 50,
      calories: 22,
      difficulty: 'Orta',
      description: 'Bacak ve kalça kaslarını güçlendiren temel hareket.',
    ),
    ExerciseItem(
      name: 'Plank',
      image: 'assets/exercises/plank.jpg',
      category: 'Core',
      durationSec: 40,
      calories: 14,
      difficulty: 'Başlangıç',
      description: 'Karın ve merkez bölgeyi güçlendiren sabit duruş.',
    ),
    ExerciseItem(
      name: 'Forward Lunge',
      image: 'assets/exercises/lunge.jpg',
      category: 'Alt Vücut',
      durationSec: 50,
      calories: 19,
      difficulty: 'Orta',
      description: 'Bacak ve denge gelişimi için etkili bir lunge hareketi.',
    ),
    ExerciseItem(
      name: 'Burpee',
      image: 'assets/exercises/burpee.jpg',
      category: 'HIIT',
      durationSec: 40,
      calories: 30,
      difficulty: 'İleri',
      description: 'Yoğun kalori yakımı sağlayan tam vücut egzersizi.',
    ),
    ExerciseItem(
      name: 'Glute Bridge',
      image: 'assets/exercises/glute_bridge.jpg',
      category: 'Glute',
      durationSec: 45,
      calories: 16,
      difficulty: 'Başlangıç',
      description: 'Kalça ve arka bacak kaslarını aktive eden temel hareket.',
    ),
    ExerciseItem(
      name: 'Bicycle Crunch',
      image: 'assets/exercises/bicycle_crunch.jpg',
      category: 'Karın',
      durationSec: 45,
      calories: 17,
      difficulty: 'Orta',
      description: 'Karın ve oblik bölgesi için etkili bir core hareketi.',
    ),
  ];

  static final List<Program> allPrograms = _buildPrograms();

  static List<Program> _buildPrograms() {
    final random = Random(9);

    final Map<String, List<String>> categoryTitles = {
      'Yağ Yakma': [
        '7 Gün Yağ Yak',
        '14 Gün Karın Erit',
        '30 Gün Fat Burn',
        'HIIT Başlangıç',
        'Kardiyo Blast',
      ],
      'Kas Yap': [
        'Full Body Güç',
        'Kas Yapıcı',
        'Upper Body Builder',
        'Core Power',
        'Direnç Programı',
      ],
      'Ev Antrenmanı': [
        'Evde Başla',
        'No Equipment',
        'Morning Workout',
        'Quick Burn',
        'Salon Yok Planı',
      ],
      'Kardiyo': [
        'Cardio Wave',
        'Tempo Boost',
        'Pulse Session',
        'Kısa Kardiyo',
        'Active Burn',
      ],
      'Forma Gir': [
        'Daha Formda',
        'Shape Up',
        'Slim Start',
        'Everyday Fit',
        'Fit Routine',
      ],
    };

    final gradients = <List<Color>>[
      [const Color(0xFF2F80ED), const Color(0xFF56CCF2)],
      [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      [const Color(0xFF11998E), const Color(0xFF38EF7D)],
      [const Color(0xFF36D1DC), const Color(0xFF5B86E5)],
      [const Color(0xFF4A6CF7), const Color(0xFF7FB3FF)],
    ];

    final List<Program> list = [];
    int counter = 1;

    categoryTitles.forEach((category, titles) {
      for (int round = 0; round < 4; round++) {
        for (final title in titles) {
          final start = random.nextInt(exercisePool.length);
          final selected = List<ExerciseItem>.generate(
            4,
            (index) => exercisePool[(start + index) % exercisePool.length],
          );

          list.add(
            Program(
              id: 'p_$counter',
              title: '$title ${round + 1}',
              category: category,
              weeks: 4 + random.nextInt(9),
              minutes: 12 + random.nextInt(24),
              cardio: 1 + random.nextInt(5),
              strength: 1 + random.nextInt(5),
              premium: counter > 20,
              colors: gradients[counter % gradients.length],
              exercises: selected,
            ),
          );
          counter++;
        }
      }
    });

    while (list.length < 100) {
      final selected = List<ExerciseItem>.generate(
        4,
        (index) => exercisePool[(counter + index) % exercisePool.length],
      );

      list.add(
        Program(
          id: 'p_$counter',
          title: 'Özel Program $counter',
          category: 'Forma Gir',
          weeks: 4 + random.nextInt(9),
          minutes: 12 + random.nextInt(24),
          cardio: 1 + random.nextInt(5),
          strength: 1 + random.nextInt(5),
          premium: counter > 20,
          colors: gradients[counter % gradients.length],
          exercises: selected,
        ),
      );
      counter++;
    }

    return list.take(100).toList();
  }

  static List<Program> byCategory(String category) {
    return allPrograms.where((p) => p.category == category).toList();
  }
}

class RuleAiCoach {
  static String getAdvice({
    required String goal,
    required String level,
    required int days,
    required String energy,
  }) {
    if (goal == 'Kilo vermek' && level == 'Başlangıç' && days <= 3) {
      return 'Bugün 20 dakikalık düşük etkili kardiyo ve core çalışmasıyla başla.';
    }
    if (goal == 'Kas yapmak' && energy == 'Yüksek') {
      return 'Bugün güç odaklı tam vücut antrenmanı senin için daha uygun.';
    }
    if (goal == 'Forma girmek' && days >= 4) {
      return 'Haftalık planına kardiyo + direnç karışımı program eklemeni öneriyorum.';
    }
    return 'Bugün kısa ama düzenli bir full body antrenmanı en iyi seçim olur.';
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final advice = RuleAiCoach.getAdvice(
      goal: 'Kilo vermek',
      level: 'Başlangıç',
      days: 3,
      energy: 'Orta',
    );

    final heroPrograms = DemoData.allPrograms.take(5).toList();
    final exercisePreview = DemoData.exercisePool.take(6).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      children: [
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.softBlue,
              ),
              child: const Icon(Icons.favorite, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trink Fit',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Zayıflama ve fitness koçun',
                    style: TextStyle(color: AppColors.subtext),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
            )
          ],
        ),
        const SizedBox(height: 18),
        _AiCoachCard(advice: advice),
        const SizedBox(height: 18),
        SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: heroPrograms.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final p = heroPrograms[index];
              return _HeroProgramCard(program: p);
            },
          ),
        ),
        const SizedBox(height: 24),
        const _SectionHeader(title: 'Hareketlerle başla'),
        const SizedBox(height: 12),
        SizedBox(
          height: 315,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: exercisePreview.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final item = exercisePreview[index];
              return ExercisePhotoCard(
                item: item,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ExerciseDetailPage(item: item),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        buildBanner(
          title: 'Kilo Takibi',
          subtitle: '84 kg başlangıç, 78 kg hedef. İlerlemen %45 seviyesinde.',
          imagePath: 'assets/banners/progress.jpg',
        ),
        const SizedBox(height: 20),
        const _SectionHeader(title: 'Daha formda olmak'),
        const SizedBox(height: 12),
        _HorizontalProgramRow(programs: DemoData.byCategory('Forma Gir').take(6).toList()),
        const SizedBox(height: 20),
        buildBanner(
          title: 'Beslenme Önerisi',
          subtitle: 'Bugün protein ve su dengesine dikkat etmen yağ yakımını destekler.',
          imagePath: 'assets/banners/food.jpg',
        ),
        const SizedBox(height: 20),
        const _SectionHeader(title: 'Yağ yak'),
        const SizedBox(height: 12),
        _HorizontalProgramRow(programs: DemoData.byCategory('Yağ Yakma').take(6).toList()),
        const SizedBox(height: 20),
        const _SectionHeader(title: 'Kas yap'),
        const SizedBox(height: 12),
        _HorizontalProgramRow(programs: DemoData.byCategory('Kas Yap').take(6).toList()),
        const SizedBox(height: 20),
        const _SectionHeader(title: 'Ev antrenmanı'),
        const SizedBox(height: 12),
        _HorizontalProgramRow(programs: DemoData.byCategory('Ev Antrenmanı').take(6).toList()),
      ],
    );
  }
}

class ProgramsPage extends StatelessWidget {
  const ProgramsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final programs = DemoData.allPrograms;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      children: [
        const Text(
          '100 Program',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Dağınık, geniş ve kart bazlı görünüm',
          style: TextStyle(color: AppColors.subtext),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _ChipTag('Yağ Yakma'),
            _ChipTag('Kas Yap'),
            _ChipTag('Ev'),
            _ChipTag('Kardiyo'),
            _ChipTag('Forma Gir'),
          ],
        ),
        const SizedBox(height: 18),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: programs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.84,
          ),
          itemBuilder: (context, index) {
            final p = programs[index];
            return _GridProgramCard(program: p);
          },
        ),
      ],
    );
  }
}

class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      children: const [
        Text(
          'Beslenme',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.text),
        ),
        SizedBox(height: 8),
        Text('Sağlıklı yaşam içerikleri', style: TextStyle(color: AppColors.subtext)),
        SizedBox(height: 18),
        _SimpleInfoCard(title: 'Yağ yakma menüsü', subtitle: 'Düşük kalorili günlük planlar'),
        SizedBox(height: 12),
        _SimpleInfoCard(title: 'Protein hedefi', subtitle: 'Kas korunumu için günlük öneriler'),
        SizedBox(height: 12),
        _SimpleInfoCard(title: 'Su takibi', subtitle: 'Günlük içme hedefin ve ilerlemen'),
        SizedBox(height: 12),
        _SimpleInfoCard(title: 'Kalori hesabı', subtitle: 'Hedefe göre günlük enerji planı'),
      ],
    );
  }
}

class MindPage extends StatelessWidget {
  const MindPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      children: const [
        Text(
          'Zihin',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.text),
        ),
        SizedBox(height: 8),
        Text('Nefes, rahatlama ve motivasyon', style: TextStyle(color: AppColors.subtext)),
        SizedBox(height: 18),
        _SimpleInfoCard(title: '5 dk meditasyon', subtitle: 'Antrenman öncesi odak kazan'),
        SizedBox(height: 12),
        _SimpleInfoCard(title: 'Nefes egzersizi', subtitle: 'Stresi azaltan kısa seans'),
        SizedBox(height: 12),
        _SimpleInfoCard(title: 'Uyku rahatlatma', subtitle: 'Akşam rutini önerileri'),
        SizedBox(height: 12),
        _SimpleInfoCard(title: 'Motivasyon kartları', subtitle: 'Günlük devam gücü için kısa mesajlar'),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      children: [
        const Text(
          'Profil',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.text),
        ),
        const SizedBox(height: 8),
        const Text('Hedeflerin ve premium üyelik', style: TextStyle(color: AppColors.subtext)),
        const SizedBox(height: 18),
        weightTrackerCard(),
        const SizedBox(height: 12),
        const _SimpleInfoCard(title: 'Boy', subtitle: '178 cm'),
        const SizedBox(height: 12),
        const _SimpleInfoCard(title: 'Kilo', subtitle: '82 kg'),
        const SizedBox(height: 12),
        const _SimpleInfoCard(title: 'Hedef', subtitle: '75 kg'),
        const SizedBox(height: 12),
        const _SimpleInfoCard(title: 'Dil', subtitle: 'Türkçe / English hazır'),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
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
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.premium, width: 1.2),
            ),
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
                Text('• 100 farklı program'),
                Text('• Gelişmiş kişisel öneriler'),
                Text('• Reklamsız kullanım'),
                Text('• Premium plan kartları'),
                Text('• Daha fazla egzersiz içeriği'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const _PriceCard(title: '1 Ay', price: '179 TL'),
          const SizedBox(height: 12),
          const _PriceCard(title: '3 Ay', price: '399 TL'),
          const SizedBox(height: 12),
          const _PriceCard(title: '12 Ay', price: '899 TL', best: true),
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
              child: const Text('Premium’a Geç'),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgramDetailPage extends StatelessWidget {
  final Program program;

  const ProgramDetailPage({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(program.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: program.colors),
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (program.premium)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Premium',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                const Spacer(),
                Text(
                  program.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${program.weeks} hafta • ${program.minutes} dk',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _StatsRow(program: program),
          const SizedBox(height: 18),
          const Text(
            'Programdaki Egzersizler',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          ...program.exercises.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ExerciseDetailPage(item: e),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          e.image,
                          width: 78,
                          height: 68,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppColors.text,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${e.category} • ${e.durationSec} sn',
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
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {},
              child: const Text('Programı Başlat'),
            ),
          ),
        ],
      ),
    );
  }
}

class ExercisePhotoCard extends StatelessWidget {
  final ExerciseItem item;
  final VoidCallback onTap;

  const ExercisePhotoCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        margin: const EdgeInsets.only(right: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 16,
              color: Color(0x14000000),
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.asset(
                item.image,
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${item.category} • ${item.difficulty}',
                    style: const TextStyle(
                      color: AppColors.subtext,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${item.durationSec} sn • ${item.calories} kcal',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseDetailPage extends StatefulWidget {
  final ExerciseItem item;

  const ExerciseDetailPage({super.key, required this.item});

  @override
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  late int remaining;
  Timer? timer;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    remaining = widget.item.durationSec;
  }

  void startTimer() {
    if (isRunning) return;
    isRunning = true;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remaining > 0) {
        setState(() => remaining--);
      } else {
        t.cancel();
        setState(() => isRunning = false);
      }
    });
    setState(() {});
  }

  void pauseTimer() {
    timer?.cancel();
    setState(() => isRunning = false);
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
      remaining = widget.item.durationSec;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatTime(int sec) {
    final m = sec ~/ 60;
    final s = sec % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              item.image,
              height: 240,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            item.name,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.text),
          ),
          const SizedBox(height: 10),
          Text(
            item.description,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 20),
          _infoTile('Kategori', item.category),
          _infoTile('Zorluk', item.difficulty),
          _infoTile('Süre', '${item.durationSec} saniye'),
          _infoTile('Kalori', '${item.calories} kcal'),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                const Text(
                  'Sayaç',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.text),
                ),
                const SizedBox(height: 12),
                Text(
                  formatTime(remaining),
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: startTimer,
                        child: const Text('Başlat'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: pauseTimer,
                        child: const Text('Duraklat'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: resetTimer,
                        child: const Text('Sıfırla'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.text),
            ),
          ),
          Text(value, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}

Widget buildBanner({
  required String title,
  required String subtitle,
  required String imagePath,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28),
      gradient: const LinearGradient(
        colors: [Color(0xFFEAF4FF), Color(0xFFFFFFFF)],
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
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.asset(
            imagePath,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        )
      ],
    ),
  );
}

Widget weightTrackerCard() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Kilo Takibi',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.text),
        ),
        SizedBox(height: 8),
        Text('Başlangıç: 84 kg'),
        Text('Hedef: 78 kg'),
        SizedBox(height: 12),
        LinearProgressIndicator(
          value: 0.45,
          minHeight: 12,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ],
    ),
  );
}

class _HeroProgramCard extends StatelessWidget {
  final Program program;

  const _HeroProgramCard({required this.program});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(26),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProgramDetailPage(program: program)),
        );
      },
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: LinearGradient(colors: program.colors),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (program.premium)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.22),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Premium',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            const Spacer(),
            Text(
              program.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${program.weeks} hafta • ${program.minutes} dk',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 6),
            Text(
              program.category,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

class _HorizontalProgramRow extends StatelessWidget {
  final List<Program> programs;

  const _HorizontalProgramRow({required this.programs});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: programs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final p = programs[index];
          return InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProgramDetailPage(program: p)),
              );
            },
            child: Container(
              width: 170,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(colors: p.colors),
                      ),
                      child: const Center(
                        child: Icon(Icons.fitness_center, color: Colors.white, size: 34),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    p.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${p.weeks} hafta',
                    style: const TextStyle(color: AppColors.subtext),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _GridProgramCard extends StatelessWidget {
  final Program program;

  const _GridProgramCard({required this.program});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProgramDetailPage(program: program)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(colors: program.colors),
                ),
                child: Stack(
                  children: [
                    const Center(
                      child: Icon(Icons.sports_gymnastics, color: Colors.white, size: 34),
                    ),
                    if (program.premium)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.22),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.workspace_premium,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              program.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${program.weeks} hafta',
              style: const TextStyle(color: AppColors.subtext),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiCoachCard extends StatelessWidget {
  final String advice;

  const _AiCoachCard({required this.advice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI Koç',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  advice,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _InsightBanner({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 6),
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

class _SimpleInfoCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SimpleInfoCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.chevron_right, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 6),
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

class _StatsRow extends StatelessWidget {
  final Program program;

  const _StatsRow({required this.program});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StatBox(title: 'Kardiyo', value: '${program.cardio}/5')),
        const SizedBox(width: 12),
        Expanded(child: _StatBox(title: 'Güç', value: '${program.strength}/5')),
        const SizedBox(width: 12),
        Expanded(child: _StatBox(title: 'Süre', value: '${program.minutes} dk')),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  final String title;
  final String value;

  const _StatBox({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(color: AppColors.subtext),
          ),
        ],
      ),
    );
  }
}

class _PriceCard extends StatelessWidget {
  final String title;
  final String price;
  final bool best;

  const _PriceCard({
    required this.title,
    required this.price,
    this.best = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: best ? AppColors.premium : AppColors.softBlue,
          width: 1.2,
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
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
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
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: AppColors.text,
      ),
    );
  }
}

class _ChipTag extends StatelessWidget {
  final String text;

  const _ChipTag(this.text);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.white,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
