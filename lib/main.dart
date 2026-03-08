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
  static const primary = Color(0xFF2F80ED);
  static const secondary = Color(0xFF56CCF2);
  static const background = Color(0xFFF4F8FD);
  static const card = Color(0xFFFFFFFF);
  static const softBlue = Color(0xFFEAF3FF);
  static const text = Color(0xFF1F2937);
  static const subtext = Color(0xFF6B7280);
  static const premium = Color(0xFFF2C94C);
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

class Program {
  final String id;
  final String title;
  final String category;
  final int weeks;
  final int minutes;
  final int cardio;
  final int strength;
  final bool premium;
  final List<String> exercises;
  final List<Color> colors;

  const Program({
    required this.id,
    required this.title,
    required this.category,
    required this.weeks,
    required this.minutes,
    required this.cardio,
    required this.strength,
    required this.premium,
    required this.exercises,
    required this.colors,
  });
}

class DemoData {
  static final Random _random = Random(7);

  static const List<String> exercisePool = [
    'Jumping Jacks',
    'Bodyweight Squat',
    'Push Up',
    'Forward Lunge',
    'Reverse Lunge',
    'Plank',
    'Mountain Climbers',
    'Glute Bridge',
    'High Knees',
    'Bicycle Crunch',
    'Burpee',
    'Fast Feet',
    'Skaters',
    'Arm Circles',
    'Donkey Kick',
    'Fire Hydrant',
    'Leg Raise',
    'Russian Twist',
    'Superman Hold',
    'Bird Dog',
  ];

  static final List<Program> allPrograms = _buildPrograms();

  static List<Program> _buildPrograms() {
    final categories = {
      'Yağ Yakma': [
        'Hızlı Yağ Yak',
        'Karın Erit',
        'Kardiyo Blast',
        'Yağ Yakıcı Başlangıç',
        'Dengeli Kilo Ver',
      ],
      'Kas Yap': [
        'Kas Yapıcı',
        'Full Body Güç',
        'Upper Body Builder',
        'Core Power',
        'Direnç Programı',
      ],
      'Ev Antrenmanı': [
        'Evde Başla',
        'Ekipmansız Fit',
        'Morning Workout',
        'Quick Burn',
        'Salon Yok Programı',
      ],
      'Kardiyo': [
        'HIIT Başlangıç',
        'Kalori Yakıcı',
        'Cardio Wave',
        'Pulse Session',
        'Tempo Boost',
      ],
      'Forma Gir': [
        'Daha Formda',
        'Shape Up',
        'Slim Start',
        'Active Life',
        'Everyday Fit',
      ],
    };

    final gradients = <List<Color>>[
      [const Color(0xFF2F80ED), const Color(0xFF56CCF2)],
      [const Color(0xFF4A6CF7), const Color(0xFF7FB3FF)],
      [const Color(0xFF11998E), const Color(0xFF38EF7D)],
      [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      [const Color(0xFF36D1DC), const Color(0xFF5B86E5)],
    ];

    final List<Program> list = [];
    int i = 1;

    categories.forEach((category, names) {
      for (int round = 0; round < 4; round++) {
        for (final name in names) {
          final start = _random.nextInt(exercisePool.length);
          final exercises = List.generate(
            6,
            (index) => exercisePool[(start + index) % exercisePool.length],
          );

          list.add(
            Program(
              id: 'p_$i',
              title: '$name ${round + 1}',
              category: category,
              weeks: 4 + _random.nextInt(9),
              minutes: 12 + _random.nextInt(24),
              cardio: 1 + _random.nextInt(5),
              strength: 1 + _random.nextInt(5),
              premium: i > 20,
              exercises: exercises,
              colors: gradients[i % gradients.length],
            ),
          );
          i++;
        }
      }
    });

    while (list.length < 100) {
      final category = categories.keys.elementAt(_random.nextInt(categories.length));
      list.add(
        Program(
          id: 'p_$i',
          title: '$category Özel ${list.length + 1}',
          category: category,
          weeks: 4 + _random.nextInt(9),
          minutes: 12 + _random.nextInt(24),
          cardio: 1 + _random.nextInt(5),
          strength: 1 + _random.nextInt(5),
          premium: i > 20,
          exercises: List.generate(
            6,
            (index) => exercisePool[(_random.nextInt(exercisePool.length) + index) % exercisePool.length],
          ),
          colors: gradients[i % gradients.length],
        ),
      );
      i++;
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
          height: 185,
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
        const _SectionHeader(title: 'Daha formda olmak'),
        const SizedBox(height: 12),
        _HorizontalProgramRow(programs: DemoData.byCategory('Forma Gir').take(6).toList()),
        const SizedBox(height: 20),
        const _InsightBanner(
          title: 'Bugün 2.1 L su hedefi',
          subtitle: 'Su takibini aktif tutarak yağ yakımını destekle.',
          icon: Icons.water_drop_outlined,
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
        const _InsightBanner(
          title: 'Haftalık ilerleme',
          subtitle: '3 gün tamamlandı, bugün 1 kısa antrenman daha ekleyebilirsin.',
          icon: Icons.show_chart,
        ),
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
          'Kategori bazlı dağınık ve geniş kartlı görünüm',
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
            childAspectRatio: 0.88,
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
                Text('• Gelişmiş içerikler'),
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
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.play_circle_outline, color: AppColors.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        e,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                  ],
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
