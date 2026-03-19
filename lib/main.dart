import 'package:flutter/material.dart';
import 'data/trink_fit_data_models.dart';

void main() => runApp(const TrinkFitApp());

enum AppLang { en, tr, de, fr, es, it, pt, ar, hi, zh, ja, ko }
enum GoalType { loseWeight, buildMuscle, stayFit, improveCardio }

class TrinkFitApp extends StatefulWidget {
  const TrinkFitApp({super.key});

  @override
  State<TrinkFitApp> createState() => _TrinkFitAppState();
}

class _TrinkFitAppState extends State<TrinkFitApp> {
  ThemeMode themeMode = ThemeMode.system;
  AppLang lang = AppLang.en;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trink Fit',
      themeMode: themeMode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: MainShell(
        lang: lang,
        themeMode: themeMode,
        onLangChanged: (value) => setState(() => lang = value),
        onThemeModeChanged: (value) => setState(() => themeMode = value),
      ),
    );
  }
}

class AppTheme {
  static const Color primary = Color(0xFF2D7FF9);
  static const Color accent = Color(0xFF21C97A);
  static const Color lightBg = Color(0xFFF4F7FB);
  static const Color darkBg = Color(0xFF0E1726);
  static const Color lightCard = Colors.white;
  static const Color darkCard = Color(0xFF172235);
  static const Color textDark = Color(0xFF111827);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: lightBg,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: textDark,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: lightCard,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: darkBg,
        colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.dark),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: darkCard,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
      );
}

class MainShell extends StatefulWidget {
  final AppLang lang;
  final ThemeMode themeMode;
  final ValueChanged<AppLang> onLangChanged;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const MainShell({
    super.key,
    required this.lang,
    required this.themeMode,
    required this.onLangChanged,
    required this.onThemeModeChanged,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  GoalType goal = GoalType.loseWeight;
  EquipmentType? equipment;
  int waterGlasses = 5;
  int dailySteps = 6842;
  int caloriesLogged = 1280;
  int targetCalories = 1800;

  @override
  Widget build(BuildContext context) {
    final t = Strings(widget.lang);
    final screens = <Widget>[
      HomeScreen(
        t: t,
        goal: goal,
        onGoalChanged: (v) => setState(() => goal = v),
        waterGlasses: waterGlasses,
        dailySteps: dailySteps,
        caloriesLogged: caloriesLogged,
        targetCalories: targetCalories,
      ),
      WorkoutsScreen(
        t: t,
        equipment: equipment,
        onEquipmentChanged: (v) => setState(() => equipment = v),
      ),
      ProgramsScreen(t: t),
      ProgressScreen(
        t: t,
        waterGlasses: waterGlasses,
        onAddWater: () => setState(() => waterGlasses++),
        dailySteps: dailySteps,
      ),
      ProfileScreen(
        t: t,
        lang: widget.lang,
        onLangChanged: widget.onLangChanged,
        themeMode: widget.themeMode,
        onThemeModeChanged: widget.onThemeModeChanged,
      ),
    ];

    return Scaffold(
      body: SafeArea(child: screens[index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home), label: t.home),
          NavigationDestination(icon: const Icon(Icons.fitness_center_outlined), selectedIcon: const Icon(Icons.fitness_center), label: t.workouts),
          NavigationDestination(icon: const Icon(Icons.dashboard_outlined), selectedIcon: const Icon(Icons.dashboard), label: t.programs),
          NavigationDestination(icon: const Icon(Icons.show_chart_outlined), selectedIcon: const Icon(Icons.show_chart), label: t.progress),
          NavigationDestination(icon: const Icon(Icons.person_outline), selectedIcon: const Icon(Icons.person), label: t.profile),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Strings t;
  final GoalType goal;
  final ValueChanged<GoalType> onGoalChanged;
  final int waterGlasses;
  final int dailySteps;
  final int caloriesLogged;
  final int targetCalories;

  const HomeScreen({super.key, required this.t, required this.goal, required this.onGoalChanged, required this.waterGlasses, required this.dailySteps, required this.caloriesLogged, required this.targetCalories});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppTheme.textDark;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.accent]),
              ),
              child: const Icon(Icons.accessibility_new, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Trink Fit', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: textColor)),
                  Text(t.appSubtitle, style: TextStyle(color: textColor.withOpacity(.65))),
                ],
              ),
            ),
            const Icon(Icons.notifications_none),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.accent]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.todaysWorkout, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 6),
              const Text('15 min Fat Burn', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(t.fiveExercisesVoiceCoach, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 14),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppTheme.primary),
                onPressed: () {},
                child: Text(t.startWorkout),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(children: [Expanded(child: StatCard(title: t.dailyStreak, value: '7 ðŸ”¥')), const SizedBox(width: 12), Expanded(child: StatCard(title: t.steps, value: '$dailySteps'))]),
        const SizedBox(height: 12),
        Row(children: [Expanded(child: StatCard(title: t.water, value: '${(waterGlasses * 0.25).toStringAsFixed(2)}L / 2L')), const SizedBox(width: 12), Expanded(child: StatCard(title: t.bmi, value: '24.1'))]),
        const SizedBox(height: 20),
        SectionTitle(title: t.goalSelection),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: GoalType.values.map((g) => ChoiceChip(label: Text(goalLabel(t, g)), selected: goal == g, onSelected: (_) => onGoalChanged(g))).toList(),
        ),
        const SizedBox(height: 20),
        SectionTitle(title: t.quickWorkout),
        const SizedBox(height: 10),
        Row(children: [Expanded(child: DashboardTile(title: t.challenge30Day, subtitle: t.fatBurnPlan, icon: Icons.local_fire_department)), const SizedBox(width: 12), Expanded(child: DashboardTile(title: t.aiTrainer, subtitle: t.createWorkoutForBellyFat, icon: Icons.auto_awesome))]),
        const SizedBox(height: 12),
        Row(children: [Expanded(child: DashboardTile(title: t.calorieTracker, subtitle: '$caloriesLogged / $targetCalories kcal', icon: Icons.restaurant_menu)), const SizedBox(width: 12), Expanded(child: DashboardTile(title: t.smartReminder, subtitle: t.timeForWorkout, icon: Icons.notifications_active))]),
        const SizedBox(height: 20),
        SectionTitle(title: t.premiumPlans),
        const SizedBox(height: 10),
        const PremiumCard(),
      ],
    );
  }
}

class WorkoutsScreen extends StatelessWidget {
  final Strings t;
  final EquipmentType? equipment;
  final ValueChanged<EquipmentType?> onEquipmentChanged;

  const WorkoutsScreen({super.key, required this.t, required this.equipment, required this.onEquipmentChanged});

  @override
  Widget build(BuildContext context) {
    final List<ExerciseItem> filtered = equipment == null ? List<ExerciseItem>.from(trinkExercises) : trinkExercises.where((e) => e.equipment == equipment).toList();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionTitle(title: t.workouts),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ChoiceChip(label: Text(t.all), selected: equipment == null, onSelected: (_) => onEquipmentChanged(null)),
            ...EquipmentType.values.map((e) => ChoiceChip(label: Text(equipmentLabel(t, e)), selected: equipment == e, onSelected: (_) => onEquipmentChanged(e))),
          ],
        ),
        const SizedBox(height: 16),
        ...filtered.map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExerciseDetailScreen(exercise: e, t: t))),
            child: ExerciseCard(exercise: e, t: t),
          ),
        )),
      ],
    );
  }
}

class ProgramsScreen extends StatelessWidget {
  final Strings t;
  const ProgramsScreen({super.key, required this.t});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionTitle(title: t.programs),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: trinkPrograms.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: .95),
          itemBuilder: (context, index) {
            final p = trinkPrograms[index];
            return InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProgramDetailScreen(program: p, t: t))),
              child: ProgramCard(program: p),
            );
          },
        ),
      ],
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final Strings t;
  final int waterGlasses;
  final VoidCallback onAddWater;
  final int dailySteps;
  const ProgressScreen({super.key, required this.t, required this.waterGlasses, required this.onAddWater, required this.dailySteps});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionTitle(title: t.progress),
        const SizedBox(height: 16),
        DashboardTile(title: t.beforeAfter, subtitle: t.trackTransformation, icon: Icons.photo_library_outlined),
        const SizedBox(height: 12),
        DashboardTile(title: t.achievements, subtitle: 'First Workout â€¢ 7 Day Streak', icon: Icons.emoji_events_outlined),
        const SizedBox(height: 12),
        DashboardTile(title: t.waterTracker, subtitle: '${(waterGlasses * 0.25).toStringAsFixed(2)} L', icon: Icons.water_drop_outlined),
        const SizedBox(height: 12),
        FilledButton(onPressed: onAddWater, child: Text(t.addWaterGlass)),
        const SizedBox(height: 12),
        DashboardTile(title: t.stepCounter, subtitle: '$dailySteps ${t.steps}', icon: Icons.directions_walk_outlined),
        const SizedBox(height: 12),
        DashboardTile(title: t.healthIntegration, subtitle: 'Google Fit â€¢ Apple Health', icon: Icons.favorite_border),
      ],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final Strings t;
  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const ProfileScreen({super.key, required this.t, required this.lang, required this.onLangChanged, required this.themeMode, required this.onThemeModeChanged});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionTitle(title: t.profile),
        const SizedBox(height: 16),
        DashboardTile(title: t.theme, subtitle: themeModeLabel(t, themeMode), icon: Icons.palette_outlined),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: [
            ChoiceChip(label: Text(t.lightMode), selected: themeMode == ThemeMode.light, onSelected: (_) => onThemeModeChanged(ThemeMode.light)),
            ChoiceChip(label: Text(t.darkMode), selected: themeMode == ThemeMode.dark, onSelected: (_) => onThemeModeChanged(ThemeMode.dark)),
            ChoiceChip(label: Text(t.systemMode), selected: themeMode == ThemeMode.system, onSelected: (_) => onThemeModeChanged(ThemeMode.system)),
          ],
        ),
        const SizedBox(height: 16),
        DashboardTile(title: t.language, subtitle: langLabel(lang), icon: Icons.language_outlined),
        const SizedBox(height: 10),
        DropdownButtonFormField<AppLang>(
          value: lang,
          items: AppLang.values.map((e) => DropdownMenuItem<AppLang>(value: e, child: Text(langLabel(e)))).toList(),
          onChanged: (value) { if (value != null) onLangChanged(value); },
        ),
        const SizedBox(height: 16),
        DashboardTile(title: t.bmiCalculator, subtitle: 'BMI = 24.1 â€¢ Normal', icon: Icons.monitor_weight_outlined),
        const SizedBox(height: 12),
        DashboardTile(title: t.widgetTitle, subtitle: t.todaysWorkout, icon: Icons.widgets_outlined),
        const SizedBox(height: 12),
        DashboardTile(title: t.adsPremium, subtitle: t.premiumAndAdsModel, icon: Icons.workspace_premium_outlined),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  const StatCard({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800))]),
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const DashboardTile({super.key, required this.title, required this.subtitle, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [Container(width: 46, height: 46, decoration: BoxDecoration(color: AppTheme.primary.withOpacity(.12), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: AppTheme.primary)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 4), Text(subtitle, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.7)))]))]),
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final ExerciseItem exercise;
  final Strings t;
  const ExerciseCard({super.key, required this.exercise, required this.t});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [Container(width: 56, height: 56, decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.accent]), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.play_circle_outline, color: Colors.white)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)), const SizedBox(height: 4), Text('${categoryLabel(t, exercise.category)} â€¢ ${exercise.calories} kcal', style: const TextStyle(fontSize: 12))]))]),
      ),
    );
  }
}

class ProgramCard extends StatelessWidget {
  final ProgramItem program;
  const ProgramCard({super.key, required this.program});
  @override
  Widget build(BuildContext context) {
    final previewGif = programGifAsset(program);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (previewGif != null)
          SizedBox(
            height: 110,
            width: double.infinity,
            child: Image.asset(previewGif, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppTheme.primary, AppTheme.accent])), alignment: Alignment.center, child: const Icon(Icons.play_circle_fill, size: 36, color: Colors.white))),
          )
        else
          Container(height: 110, width: double.infinity, decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppTheme.primary, AppTheme.accent])), alignment: Alignment.center, child: const Icon(Icons.play_circle_fill, size: 36, color: Colors.white)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Expanded(child: Text(program.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16))), if (program.isPremium) const Icon(Icons.workspace_premium, color: Colors.amber)]), const SizedBox(height: 8), Text(program.group), const Spacer(), Text('${program.totalDays} days')]),
          ),
        ),
      ]),
    );
  }
}

class PremiumCard extends StatelessWidget {
  const PremiumCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Premium + Ads Model', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)), SizedBox(height: 10), Text('Monthly   179 TL'), Text('3 Months  399 TL'), Text('6 Months  599 TL'), Text('Yearly    899 TL â­')]),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800));
}

String goalLabel(Strings t, GoalType g) {
  switch (g) {
    case GoalType.loseWeight: return t.loseWeight;
    case GoalType.buildMuscle: return t.buildMuscle;
    case GoalType.stayFit: return t.stayFit;
    case GoalType.improveCardio: return t.improveCardio;
  }
}
String equipmentLabel(Strings t, EquipmentType e) {
  switch (e) {
    case EquipmentType.none: return t.noEquipment;
    case EquipmentType.dumbbell: return t.dumbbell;
    case EquipmentType.resistanceBand: return t.resistanceBand;
    case EquipmentType.gym: return t.gym;
  }
}
String themeModeLabel(Strings t, ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light: return t.lightMode;
    case ThemeMode.dark: return t.darkMode;
    case ThemeMode.system: return t.systemMode;
  }
}
String langLabel(AppLang lang) {
  switch (lang) {
    case AppLang.en: return 'English';
    case AppLang.tr: return 'TÃ¼rkÃ§e';
    case AppLang.de: return 'Deutsch';
    case AppLang.fr: return 'FranÃ§ais';
    case AppLang.es: return 'EspaÃ±ol';
    case AppLang.it: return 'Italiano';
    case AppLang.pt: return 'PortuguÃªs';
    case AppLang.ar: return 'Ø§Ù„Ø¹Ø±Ø¨ÙŠØ©';
    case AppLang.hi: return 'à¤¹à¤¿à¤¨à¥à¤¦à¥€';
    case AppLang.zh: return 'ä¸­æ–‡';
    case AppLang.ja: return 'æ—¥æœ¬èªž';
    case AppLang.ko: return 'í•œêµ­ì–´';
  }
}
String categoryLabel(Strings t, ExerciseCategory c) {
  switch (c) {
    case ExerciseCategory.cardio: return t.cardio;
    case ExerciseCategory.abs: return t.abs;
    case ExerciseCategory.legs: return t.legs;
    case ExerciseCategory.arms: return t.arms;
    case ExerciseCategory.fullBody: return t.fullBody;
    case ExerciseCategory.hiit: return t.hiit;
    case ExerciseCategory.stretch: return t.stretch;
  }
}
ExerciseItem? exerciseById(String id) { for (final exercise in trinkExercises) { if (exercise.id == id) return exercise; } return null; }
List<ExerciseItem> exercisesForDay(ProgramDay day) => day.exerciseIds.map(exerciseById).whereType<ExerciseItem>().toList();
String? programGifAsset(ProgramItem program) { if (program.days.isEmpty || program.days.first.exerciseIds.isEmpty) return null; final firstExercise = exerciseById(program.days.first.exerciseIds.first); if (firstExercise == null || firstExercise.gifAsset.isEmpty) return null; return firstExercise.gifAsset; }
String? programCoverAsset(ProgramItem program) { if (program.days.isEmpty || program.days.first.exerciseIds.isEmpty) return null; final firstExercise = exerciseById(program.days.first.exerciseIds.first); if (firstExercise == null || firstExercise.imageAsset.isEmpty) return null; return firstExercise.imageAsset; }

class Strings {
  final AppLang lang;
  const Strings(this.lang);
  String _pick(String en, String tr, String de, String fr, String es, String it, String pt, String ar, String hi, String zh, String ja, String ko) {
    switch (lang) {
      case AppLang.en: return en; case AppLang.tr: return tr; case AppLang.de: return de; case AppLang.fr: return fr; case AppLang.es: return es; case AppLang.it: return it; case AppLang.pt: return pt; case AppLang.ar: return ar; case AppLang.hi: return hi; case AppLang.zh: return zh; case AppLang.ja: return ja; case AppLang.ko: return ko;
    }
  }
  String get home => _pick('Home', 'Ana Sayfa', 'Start', 'Accueil', 'Inicio', 'Home', 'InÃ­cio', 'Ø§Ù„Ø±Ø¦ÙŠØ³ÙŠØ©', 'à¤¹à¥‹à¤®', 'é¦–é¡µ', 'ãƒ›ãƒ¼ãƒ ', 'í™ˆ');
  String get workouts => _pick('Workouts', 'Antrenmanlar', 'Workouts', 'EntraÃ®nements', 'Entrenos', 'Allenamenti', 'Treinos', 'Ø§Ù„ØªÙ…Ø§Ø±ÙŠÙ†', 'à¤µà¤°à¥à¤•à¤†à¤‰à¤Ÿ', 'è®­ç»ƒ', 'ãƒ¯ãƒ¼ã‚¯ã‚¢ã‚¦ãƒˆ', 'ìš´ë™');
  String get programs => _pick('Programs', 'Programlar', 'Programme', 'Programmes', 'Programas', 'Programmi', 'Programas', 'Ø§Ù„Ø¨Ø±Ø§Ù…Ø¬', 'à¤ªà¥à¤°à¥‹à¤—à¥à¤°à¤¾à¤®', 'è®¡åˆ’', 'ãƒ—ãƒ­ã‚°ãƒ©ãƒ ', 'í”„ë¡œê·¸ëž¨');
  String get progress => _pick('Progress', 'Ä°lerleme', 'Fortschritt', 'ProgrÃ¨s', 'Progreso', 'Progressi', 'Progresso', 'Ø§Ù„ØªÙ‚Ø¯Ù…', 'à¤ªà¥à¤°à¤—à¤¤à¤¿', 'è¿›åº¦', 'é€²æ—', 'ì§„í–‰');
  String get profile => _pick('Profile', 'Profil', 'Profil', 'Profil', 'Perfil', 'Profilo', 'Perfil', 'Ø§Ù„Ù…Ù„Ù Ø§Ù„Ø´Ø®ØµÙŠ', 'à¤ªà¥à¤°à¥‹à¤«à¤¾à¤‡à¤²', 'æˆ‘çš„', 'ãƒ—ãƒ­ãƒ•ã‚£ãƒ¼ãƒ«', 'í”„ë¡œí•„');
  String get appSubtitle => _pick('Home Workout, Weight Loss & Fitness', 'Evde Egzersiz, Kilo Verme ve Fitness', 'Home Training, Gewichtsverlust & Fitness', 'EntraÃ®nement Ã  domicile, perte de poids et fitness', 'Entrenamiento en casa, pÃ©rdida de peso y fitness', 'Allenamento a casa, perdita di peso e fitness', 'Treino em casa, perda de peso e fitness', 'ØªÙ…Ø§Ø±ÙŠÙ† Ù…Ù†Ø²Ù„ÙŠØ©ØŒ Ø®Ø³Ø§Ø±Ø© Ø§Ù„ÙˆØ²Ù† ÙˆØ§Ù„Ù„ÙŠØ§Ù‚Ø©', 'à¤¹à¥‹à¤® à¤µà¤°à¥à¤•à¤†à¤‰à¤Ÿ, à¤µà¤œà¤¨ à¤˜à¤Ÿà¤¾à¤¨à¤¾ à¤”à¤° à¤«à¤¿à¤Ÿà¤¨à¥‡à¤¸', 'å±…å®¶é”»ç‚¼, å‡é‡ä¸Žå¥èº«', 'ãƒ›ãƒ¼ãƒ ãƒ¯ãƒ¼ã‚¯ã‚¢ã‚¦ãƒˆã€æ¸›é‡ã¨ãƒ•ã‚£ãƒƒãƒˆãƒã‚¹', 'í™ˆíŠ¸ë ˆì´ë‹, ì²´ì¤‘ ê°ëŸ‰ ë° í”¼íŠ¸ë‹ˆìŠ¤');
  String get todaysWorkout => _pick("Today's Workout", 'BugÃ¼nÃ¼n AntrenmanÄ±', 'Heutiges Training', "EntraÃ®nement d'aujourd'hui", 'Entrenamiento de hoy', 'Allenamento di oggi', 'Treino de hoje', 'ØªÙ…Ø±ÙŠÙ† Ø§Ù„ÙŠÙˆÙ…', 'à¤†à¤œ à¤•à¤¾ à¤µà¤°à¥à¤•à¤†à¤‰à¤Ÿ', 'ä»Šæ—¥è®­ç»ƒ', 'ä»Šæ—¥ã®ãƒ¯ãƒ¼ã‚¯ã‚¢ã‚¦ãƒˆ', 'ì˜¤ëŠ˜ì˜ ìš´ë™');
  String get fiveExercisesVoiceCoach => _pick('5 Exercises Voice Coach', '5 Egzersiz Sesli KoÃ§', '5 Ãœbungen Sprachcoach', 'Coach vocal 5 exercices', 'Coach de voz de 5 ejercicios', 'Coach vocale 5 esercizi', 'Coach de voz 5 exercÃ­cios', 'Ù…Ø¯Ø±Ø¨ ØµÙˆØªÙŠ Ù„Ù€ 5 ØªÙ…Ø§Ø±ÙŠÙ†', '5 à¤à¤•à¥à¤¸à¤°à¤¸à¤¾à¤‡à¤œà¤¼ à¤µà¥‰à¤‡à¤¸ à¤•à¥‹à¤š', '5 ä¸ªç»ƒä¹ è¯­éŸ³æ•™ç»ƒ', '5ã‚¨ã‚¯ã‚µã‚µã‚¤ã‚ºéŸ³å£°ã‚³ãƒ¼ãƒ', '5ê°œ ìš´ë™ ìŒì„± ì½”ì¹˜');
  String get startWorkout => _pick('Start Workout', 'AntrenmanÄ± BaÅŸlat', 'Training starten', 'Commencer lâ€™entraÃ®nement', 'Iniciar entrenamiento', 'Avvia allenamento', 'Iniciar treino', 'Ø§Ø¨Ø¯Ø£ Ø§Ù„ØªÙ…Ø±ÙŠÙ†', 'à¤µà¤°à¥à¤•à¤†à¤‰à¤Ÿ à¤¶à¥à¤°à¥‚ à¤•à¤°à¥‡à¤‚', 'å¼€å§‹è®­ç»ƒ', 'ãƒ¯ãƒ¼ã‚¯ã‚¢ã‚¦ãƒˆé–‹å§‹', 'ìš´ë™ ì‹œìž‘');
  String get dailyStreak => _pick('Daily Streak', 'GÃ¼nlÃ¼k Seri', 'TÃ¤gliche Serie', 'SÃ©rie quotidienne', 'Racha diaria', 'Serie giornaliera', 'SequÃªncia diÃ¡ria', 'Ø³Ù„Ø³Ù„Ø© ÙŠÙˆÙ…ÙŠØ©', 'à¤¦à¥ˆà¤¨à¤¿à¤• à¤¸à¥à¤Ÿà¥à¤°à¥€à¤•', 'æ¯æ—¥è¿žç»­', 'ãƒ‡ã‚¤ãƒªãƒ¼ã‚¹ãƒˆãƒªãƒ¼ã‚¯', 'ì¼ì¼ ì—°ì†');
  String get steps => _pick('Steps', 'AdÄ±m', 'Schritte', 'Pas', 'Pasos', 'Passi', 'Passos', 'Ø§Ù„Ø®Ø·ÙˆØ§Øª', 'à¤•à¤¦à¤®', 'æ­¥æ•°', 'æ­©æ•°', 'ê±¸ìŒ ìˆ˜');
  String get water => _pick('Water', 'Su', 'Wasser', 'Eau', 'Agua', 'Acqua', 'Ãgua', 'Ø§Ù„Ù…Ø§Ø¡', 'à¤ªà¤¾à¤¨à¥€', 'æ°´', 'æ°´', 'ë¬¼');
  String get bmi => _pick('BMI', 'BMI', 'BMI', 'IMC', 'IMC', 'BMI', 'IMC', 'Ù…Ø¤Ø´Ø± ÙƒØªÙ„Ø© Ø§Ù„Ø¬Ø³Ù…', 'à¤¬à¥€à¤à¤®à¤†à¤ˆ', 'BMI', 'BMI', 'BMI');
  String get goalSelection => _pick('Goal Selection', 'Hedef SeÃ§imi', 'Zielauswahl', 'SÃ©lection dâ€™objectif', 'SelecciÃ³n de objetivo', 'Selezione obiettivo', 'SeleÃ§Ã£o de objetivo', 'Ø§Ø®ØªÙŠØ§Ø± Ø§Ù„Ù‡Ø¯Ù', 'à¤²à¤•à¥à¤·à¥à¤¯ à¤šà¤¯à¤¨', 'ç›®æ ‡é€‰æ‹©', 'ç›®æ¨™é¸æŠž', 'ëª©í‘œ ì„ íƒ');
  String get quickWorkout => _pick('Quick Workout', 'HÄ±zlÄ± Antrenman', 'Schnelles Training', 'EntraÃ®nement rapide', 'Entrenamiento rÃ¡pido', 'Allenamento rapido', 'Treino rÃ¡pido', 'ØªÙ…Ø±ÙŠÙ† Ø³Ø±ÙŠØ¹', 'à¤¤à¥à¤µà¤°à¤¿à¤¤ à¤•à¤¸à¤°à¤¤', 'å¿«é€Ÿè®­ç»ƒ', 'ã‚¯ã‚¤ãƒƒã‚¯ãƒ¯ãƒ¼ã‚¯ã‚¢ã‚¦ãƒˆ', 'ë¹ ë¥¸ ìš´ë™');
  String get challenge30Day => _pick('30-Day Challenge', '30 GÃ¼nlÃ¼k Meydan Okuma', '30-Tage-Challenge', 'DÃ©fi de 30 jours', 'DesafÃ­o de 30 dÃ­as', 'Sfida di 30 giorni', 'Desafio de 30 dias', 'ØªØ­Ø¯ÙŠ 30 ÙŠÙˆÙ…Ù‹Ø§', '30-à¤¦à¤¿à¤µà¤¸à¥€à¤¯ à¤šà¥ˆà¤²à¥‡à¤‚à¤œ', '30å¤©æŒ‘æˆ˜', '30æ—¥é–“ãƒãƒ£ãƒ¬ãƒ³ã‚¸', '30ì¼ ì±Œë¦°ì§€');
  String get fatBurnPlan => _pick('Fat Burn Plan', 'YaÄŸ Yakma PlanÄ±', 'Fettverbrennungsplan', 'Plan brÃ»le-graisse', 'Plan para quemar grasa', 'Piano brucia grassi', 'Plano de queima de gordura', 'Ø®Ø·Ø© Ø­Ø±Ù‚ Ø§Ù„Ø¯Ù‡ÙˆÙ†', 'à¤«à¥ˆà¤Ÿ à¤¬à¤°à¥à¤¨ à¤ªà¥à¤²à¤¾à¤¨', 'ç‡ƒè„‚è®¡åˆ’', 'è„‚è‚ªç‡ƒç„¼ãƒ—ãƒ©ãƒ³', 'ì§€ë°© ì—°ì†Œ í”Œëžœ');
  String get aiTrainer => _pick('AI Trainer', 'Yapay ZekÃ¢ AntrenÃ¶rÃ¼', 'KI-Trainer', 'Coach IA', 'Entrenador IA', 'Allenatore IA', 'Treinador IA', 'Ù…Ø¯Ø±Ø¨ Ø§Ù„Ø°ÙƒØ§Ø¡ Ø§Ù„Ø§ØµØ·Ù†Ø§Ø¹ÙŠ', 'à¤à¤†à¤ˆ à¤Ÿà¥à¤°à¥‡à¤¨à¤°', 'AIæ•™ç»ƒ', 'AIãƒˆãƒ¬ãƒ¼ãƒŠãƒ¼', 'AI íŠ¸ë ˆì´ë„ˆ');
  String get createWorkoutForBellyFat => _pick('Create workout for belly fat', 'GÃ¶bek yaÄŸÄ± iÃ§in antrenman oluÅŸtur', 'Training gegen Bauchfett erstellen', 'CrÃ©er un entraÃ®nement pour la graisse du ventre', 'Crear entrenamiento para grasa abdominal', 'Crea allenamento per il grasso addominale', 'Criar treino para gordura abdominal', 'Ø£Ù†Ø´Ø¦ ØªÙ…Ø±ÙŠÙ†Ù‹Ø§ Ù„Ø¯Ù‡ÙˆÙ† Ø§Ù„Ø¨Ø·Ù†', 'à¤ªà¥‡à¤Ÿ à¤•à¥€ à¤šà¤°à¥à¤¬à¥€ à¤•à¥‡ à¤²à¤¿à¤ à¤µà¤°à¥à¤•à¤†à¤‰à¤Ÿ à¤¬à¤¨à¤¾à¤à¤‚', 'ä¸ºè…¹éƒ¨è„‚è‚ªåˆ›å»ºè®­ç»ƒ', 'ãŠè…¹ã®è„‚è‚ªå‘ã‘ãƒ¯ãƒ¼ã‚¯ã‚¢ã‚¦ãƒˆã‚’ä½œæˆ', 'ë³µë¶€ ì§€ë°©ìš© ìš´ë™ ë§Œë“¤ê¸°');
  String get calorieTracker => _pick('Calorie Tracker', 'Kalori Takibi', 'Kalorien-Tracker', 'Suivi des calories', 'Seguimiento de calorÃ­as', 'Monitor calorie', 'Rastreador de calorias', 'Ù…ØªØªØ¨Ø¹ Ø§Ù„Ø³Ø¹Ø±Ø§Øª Ø§Ù„Ø­Ø±Ø§Ø±ÙŠØ©', 'à¤•à¥ˆà¤²à¥‹à¤°à¥€ à¤Ÿà¥à¤°à¥ˆà¤•à¤°', 'å¡è·¯é‡Œè¿½è¸ª', 'ã‚«ãƒ­ãƒªãƒ¼ãƒˆãƒ©ãƒƒã‚«ãƒ¼', 'ì¹¼ë¡œë¦¬ ì¶”ì ê¸°');
  String get smartReminder => _pick('Smart Reminder', 'AkÄ±llÄ± HatÄ±rlatÄ±cÄ±', 'Intelligente Erinnerung', 'Rappel intelligent', 'Recordatorio inteligente', 'Promemoria intelligente', 'Lembrete inteligente', 'ØªØ°ÙƒÙŠØ± Ø°ÙƒÙŠ', 'à¤¸à¥à¤®à¤¾à¤°à¥à¤Ÿ à¤°à¤¿à¤®à¤¾à¤‡à¤‚à¤¡à¤°', 'æ™ºèƒ½æé†’', 'ã‚¹ãƒžãƒ¼ãƒˆãƒªãƒžã‚¤ãƒ³ãƒ€ãƒ¼', 'ìŠ¤ë§ˆíŠ¸ ì•Œë¦¼');
  String get timeForWorkout => _pick('Time for workout', 'Antrenman zamanÄ±', 'Zeit fÃ¼rs Training', "C'est l'heure de s'entraÃ®ner", 'Hora de entrenar', 'Ãˆ ora di allenarsi', 'Hora do treino', 'Ø­Ø§Ù† ÙˆÙ‚Øª Ø§Ù„ØªÙ…Ø±ÙŠÙ†', 'à¤µà¤°à¥à¤•à¤†à¤‰à¤Ÿ à¤•à¤¾ à¤¸à¤®à¤¯', 'è¯¥é”»ç‚¼äº†', 'ãƒ¯ãƒ¼ã‚¯ã‚¢ã‚¦ãƒˆã®æ™‚é–“', 'ìš´ë™í•  ì‹œê°„');
  String get premiumPlans => _pick('Premium Plans', 'Premium Planlar', 'Premium-PlÃ¤ne', 'Plans premium', 'Planes premium', 'Piani premium', 'Planos premium', 'Ø®Ø·Ø· Ø¨Ø±ÙŠÙ…ÙŠÙˆÙ…', 'à¤ªà¥à¤°à¥€à¤®à¤¿à¤¯à¤® à¤ªà¥à¤²à¤¾à¤¨', 'é«˜çº§è®¡åˆ’', 'ãƒ—ãƒ¬ãƒŸã‚¢ãƒ ãƒ—ãƒ©ãƒ³', 'í”„ë¦¬ë¯¸ì—„ í”Œëžœ');
  String get loseWeight => _pick('Lose Weight', 'Kilo Ver', 'Gewicht verlieren', 'Perdre du poids', 'Perder peso', 'Perdere peso', 'Perder peso', 'Ø¥Ù†Ù‚Ø§Øµ Ø§Ù„ÙˆØ²Ù†', 'à¤µà¤œà¤¨ à¤˜à¤Ÿà¤¾à¤à¤‚', 'å‡è‚¥', 'æ¸›é‡', 'ì²´ì¤‘ ê°ëŸ‰');
  String get buildMuscle => _pick('Build Muscle', 'Kas Yap', 'Muskeln aufbauen', 'DÃ©velopper les muscles', 'Ganar mÃºsculo', 'Costruire muscoli', 'Ganhar mÃºsculos', 'Ø¨Ù†Ø§Ø¡ Ø§Ù„Ø¹Ø¶Ù„Ø§Øª', 'à¤®à¤¾à¤‚à¤¸à¤ªà¥‡à¤¶à¤¿à¤¯à¤¾à¤ à¤¬à¤¨à¤¾à¤à¤‚', 'å¢žè‚Œ', 'ç­‹è‚‰ã‚’ã¤ã‘ã‚‹', 'ê·¼ìœ¡ ë§Œë“¤ê¸°');
  String get stayFit => _pick('Stay Fit', 'Formda Kal', 'Fit bleiben', 'Rester en forme', 'Mantenerse en forma', 'Rimani in forma', 'Manter a forma', 'Ø§Ù„Ø­ÙØ§Ø¸ Ø¹Ù„Ù‰ Ø§Ù„Ù„ÙŠØ§Ù‚Ø©', 'à¤«à¤¿à¤Ÿ à¤°à¤¹à¥‡à¤‚', 'ä¿æŒå¥åº·', 'å¥åº·ã‚’ä¿ã¤', 'ëª¸ë§¤ ìœ ì§€');
  String get improveCardio => _pick('Improve Cardio', 'Kardiyoyu GeliÅŸtir', 'Cardio verbessern', 'AmÃ©liorer le cardio', 'Mejorar cardio', 'Migliora il cardio', 'Melhorar cardio', 'ØªØ­Ø³ÙŠÙ† Ø§Ù„ÙƒØ§Ø±Ø¯ÙŠÙˆ', 'à¤•à¤¾à¤°à¥à¤¡à¤¿à¤¯à¥‹ à¤¸à¥à¤§à¤¾à¤°à¥‡à¤‚', 'æå‡å¿ƒè‚ºåŠŸèƒ½', 'æœ‰é…¸ç´ èƒ½åŠ›ã‚’å‘ä¸Š', 'ìœ ì‚°ì†Œ ëŠ¥ë ¥ í–¥ìƒ');
  String get beforeAfter => _pick('Before & After', 'Ã–ncesi ve SonrasÄ±', 'Vorher & Nachher', 'Avant / AprÃ¨s', 'Antes y DespuÃ©s', 'Prima e Dopo', 'Antes e Depois', 'Ù‚Ø¨Ù„ ÙˆØ¨Ø¹Ø¯', 'à¤ªà¤¹à¤²à¥‡ à¤”à¤° à¤¬à¤¾à¤¦ à¤®à¥‡à¤‚', 'å‰åŽå¯¹æ¯”', 'ãƒ“ãƒ•ã‚©ãƒ¼ã‚¢ãƒ•ã‚¿ãƒ¼', 'ì „í›„ ë¹„êµ');
  String get trackTransformation => _pick('Track Transformation', 'DeÄŸiÅŸimi Takip Et', 'Transformation verfolgen', 'Suivre la transformation', 'Seguir transformaciÃ³n', 'Monitora trasformazione', 'Acompanhar transformaÃ§Ã£o', 'ØªØªØ¨Ø¹ Ø§Ù„ØªØºÙŠÙŠØ±', 'à¤ªà¤°à¤¿à¤µà¤°à¥à¤¤à¤¨ à¤Ÿà¥à¤°à¥ˆà¤• à¤•à¤°à¥‡à¤‚', 'è¿½è¸ªå˜åŒ–', 'å¤‰åŒ–ã‚’è¿½è·¡', 'ë³€í™” ì¶”ì ');
  String get achievements => _pick('Achievements', 'BaÅŸarÄ±lar', 'Erfolge', 'SuccÃ¨s', 'Logros', 'Risultati', 'Conquistas', 'Ø§Ù„Ø¥Ù†Ø¬Ø§Ø²Ø§Øª', 'à¤‰à¤ªà¤²à¤¬à¥à¤§à¤¿à¤¯à¤¾à¤', 'æˆå°±', 'å®Ÿç¸¾', 'ì—…ì ');
  String get waterTracker => _pick('Water Tracker', 'Su Takibi', 'Wasser Tracker', 'Suivi de lâ€™eau', 'Seguimiento de agua', 'Monitoraggio acqua', 'Monitor de Ã¡gua', 'Ù…ØªØ§Ø¨Ø¹Ø© Ø§Ù„Ù…Ø§Ø¡', 'à¤µà¥‰à¤Ÿà¤° à¤Ÿà¥à¤°à¥ˆà¤•à¤°', 'é¥®æ°´è¿½è¸ª', 'æ°´åˆ†ãƒˆãƒ©ãƒƒã‚«ãƒ¼', 'ë¬¼ ì„­ì·¨ ì¶”ì ');
  String get stepCounter => _pick('Step Counter', 'AdÄ±m SayacÄ±', 'SchrittzÃ¤hler', 'Compteur de pas', 'Contador de pasos', 'Contapassi', 'Contador de passos', 'Ø¹Ø¯Ø§Ø¯ Ø§Ù„Ø®Ø·ÙˆØ§Øª', 'à¤¸à¥à¤Ÿà¥‡à¤ª à¤•à¤¾à¤‰à¤‚à¤Ÿà¤°', 'è®¡æ­¥å™¨', 'æ­©æ•°è¨ˆ', 'ë§Œë³´ê³„');
  String get addWaterGlass => _pick('Add Water', 'Su Ekle', 'Wasser hinzufÃ¼gen', 'Ajouter de lâ€™eau', 'Agregar agua', 'Aggiungi acqua', 'Adicionar Ã¡gua', 'Ø¥Ø¶Ø§ÙØ© Ù…Ø§Ø¡', 'à¤ªà¤¾à¤¨à¥€ à¤œà¥‹à¤¡à¤¼à¥‡à¤‚', 'æ·»åŠ é¥®æ°´', 'æ°´ã‚’è¿½åŠ ', 'ë¬¼ ì¶”ê°€');
  String get adsPremium => _pick('Ads Premium', 'Reklam Premium', 'Werbe-Premium', 'Premium pubs', 'Premium con anuncios', 'Premium con pubblicitÃ ', 'Premium com anÃºncios', 'Ø¨Ø±ÙŠÙ…ÙŠÙˆÙ… Ù…Ø¹ Ø¥Ø¹Ù„Ø§Ù†Ø§Øª', 'à¤µà¤¿à¤œà¥à¤žà¤¾à¤ªà¤¨ à¤ªà¥à¤°à¥€à¤®à¤¿à¤¯à¤®', 'å¹¿å‘Šé«˜çº§ç‰ˆ', 'åºƒå‘Šä»˜ããƒ—ãƒ¬ãƒŸã‚¢ãƒ ', 'ê´‘ê³  í¬í•¨ í”„ë¦¬ë¯¸ì—„');
  String get premiumAndAdsModel => _pick('Premium + Ads Model', 'Premium + Reklam Modeli', 'Premium + Werbemodell', 'ModÃ¨le Premium + pubs', 'Modelo Premium + anuncios', 'Modello Premium + pubblicitÃ ', 'Modelo Premium + anÃºncios', 'Ù†Ù…ÙˆØ°Ø¬ Ø¨Ø±ÙŠÙ…ÙŠÙˆÙ… + Ø¥Ø¹Ù„Ø§Ù†Ø§Øª', 'à¤ªà¥à¤°à¥€à¤®à¤¿à¤¯à¤® + à¤µà¤¿à¤œà¥à¤žà¤¾à¤ªà¤¨ à¤®à¥‰à¤¡à¤²', 'é«˜çº§ç‰ˆ + å¹¿å‘Šæ¨¡å¼', 'ãƒ—ãƒ¬ãƒŸã‚¢ãƒ  + åºƒå‘Šãƒ¢ãƒ‡ãƒ«', 'í”„ë¦¬ë¯¸ì—„ + ê´‘ê³  ëª¨ë¸');
  String get theme => _pick('Theme', 'Tema', 'Thema', 'ThÃ¨me', 'Tema', 'Tema', 'Tema', 'Ø§Ù„Ø³Ù…Ø©', 'à¤¥à¥€à¤®', 'ä¸»é¢˜', 'ãƒ†ãƒ¼ãƒž', 'í…Œë§ˆ');
  String get language => _pick('Language', 'Dil', 'Sprache', 'Langue', 'Idioma', 'Lingua', 'Idioma', 'Ø§Ù„Ù„ØºØ©', 'à¤­à¤¾à¤·à¤¾', 'è¯­è¨€', 'è¨€èªž', 'ì–¸ì–´');
  String get bmiCalculator => _pick('BMI Calculator', 'BMI HesaplayÄ±cÄ±', 'BMI Rechner', 'Calculateur IMC', 'Calculadora IMC', 'Calcolatore BMI', 'Calculadora de IMC', 'Ø­Ø§Ø³Ø¨Ø© BMI', 'BMI à¤•à¥ˆà¤²à¤•à¥à¤²à¥‡à¤Ÿà¤°', 'BMI è®¡ç®—å™¨', 'BMIè¨ˆç®—æ©Ÿ', 'BMI ê³„ì‚°ê¸°');
  String get widgetTitle => _pick('Widgets', 'Widgetler', 'Widgets', 'Widgets', 'Widgets', 'Widget', 'Widgets', 'Ø§Ù„ÙˆÙŠØ¯Ø¬Øª', 'à¤µà¤¿à¤œà¥‡à¤Ÿà¥à¤¸', 'å°ç»„ä»¶', 'ã‚¦ã‚£ã‚¸ã‚§ãƒƒãƒˆ', 'ìœ„ì ¯');
  String get healthIntegration => _pick('Health Integration', 'SaÄŸlÄ±k Entegrasyonu', 'Gesundheitsintegration', 'IntÃ©gration SantÃ©', 'IntegraciÃ³n de Salud', 'Integrazione Salute', 'IntegraÃ§Ã£o de SaÃºde', 'ØªÙƒØ§Ù…Ù„ Ø§Ù„ØµØ­Ø©', 'à¤¹à¥‡à¤²à¥à¤¥ à¤‡à¤‚à¤Ÿà¥€à¤—à¥à¤°à¥‡à¤¶à¤¨', 'å¥åº·é›†æˆ', 'ãƒ˜ãƒ«ã‚¹é€£æº', 'ê±´ê°• ì—°ë™');
  String get darkMode => _pick('Dark Mode', 'Koyu Mod', 'Dunkler Modus', 'Mode sombre', 'Modo oscuro', 'ModalitÃ  scura', 'Modo escuro', 'Ø§Ù„ÙˆØ¶Ø¹ Ø§Ù„Ø¯Ø§ÙƒÙ†', 'à¤¡à¤¾à¤°à¥à¤• à¤®à¥‹à¤¡', 'æ·±è‰²æ¨¡å¼', 'ãƒ€ãƒ¼ã‚¯ãƒ¢ãƒ¼ãƒ‰', 'ë‹¤í¬ ëª¨ë“œ');
  String get lightMode => _pick('Light Mode', 'AÃ§Ä±k Mod', 'Heller Modus', 'Mode clair', 'Modo claro', 'ModalitÃ  chiara', 'Modo claro', 'Ø§Ù„ÙˆØ¶Ø¹ Ø§Ù„ÙØ§ØªØ­', 'à¤²à¤¾à¤‡à¤Ÿ à¤®à¥‹à¤¡', 'æµ…è‰²æ¨¡å¼', 'ãƒ©ã‚¤ãƒˆãƒ¢ãƒ¼ãƒ‰', 'ë¼ì´íŠ¸ ëª¨ë“œ');
  String get systemMode => _pick('System Mode', 'Sistem Modu', 'Systemmodus', 'Mode systÃ¨me', 'Modo del sistema', 'ModalitÃ  sistema', 'Modo do sistema', 'ÙˆØ¶Ø¹ Ø§Ù„Ù†Ø¸Ø§Ù…', 'à¤¸à¤¿à¤¸à¥à¤Ÿà¤® à¤®à¥‹à¤¡', 'ç³»ç»Ÿæ¨¡å¼', 'ã‚·ã‚¹ãƒ†ãƒ ãƒ¢ãƒ¼ãƒ‰', 'ì‹œìŠ¤í…œ ëª¨ë“œ');
  String get all => _pick('All', 'TÃ¼mÃ¼', 'Alle', 'Tous', 'Todos', 'Tutti', 'Todos', 'Ø§Ù„ÙƒÙ„', 'à¤¸à¤­à¥€', 'å…¨éƒ¨', 'ã™ã¹ã¦', 'ì „ì²´');
  String get noEquipment => _pick('No Equipment', 'EkipmansÄ±z', 'Ohne GerÃ¤te', 'Sans Ã©quipement', 'Sin equipo', 'Senza attrezzi', 'Sem equipamento', 'Ø¨Ø¯ÙˆÙ† Ù…Ø¹Ø¯Ø§Øª', 'à¤¬à¤¿à¤¨à¤¾ à¤‰à¤ªà¤•à¤°à¤£', 'æ— å™¨æ¢°', 'å™¨å…·ãªã—', 'ìž¥ë¹„ ì—†ìŒ');
  String get dumbbell => _pick('Dumbbell', 'DambÄ±l', 'Hantel', 'HaltÃ¨re', 'Mancuerna', 'Manubrio', 'Halter', 'Ø¯Ù…Ø¨Ù„', 'à¤¡à¤®à¥à¤¬à¤²', 'å“‘é“ƒ', 'ãƒ€ãƒ³ãƒ™ãƒ«', 'ë¤ë²¨');
  String get resistanceBand => _pick('Resistance Band', 'DirenÃ§ BandÄ±', 'Widerstandsband', 'Bande de rÃ©sistance', 'Banda elÃ¡stica', 'Banda di resistenza', 'Banda elÃ¡stica', 'Ø­Ø¨Ù„ Ù…Ù‚Ø§ÙˆÙ…Ø©', 'à¤°à¥‡à¤œà¤¼à¤¿à¤¸à¥à¤Ÿà¥‡à¤‚à¤¸ à¤¬à¥ˆà¤‚à¤¡', 'é˜»åŠ›å¸¦', 'ãƒ¬ã‚¸ã‚¹ã‚¿ãƒ³ã‚¹ãƒãƒ³ãƒ‰', 'ì €í•­ ë°´ë“œ');
  String get gym => _pick('Gym', 'Spor Salonu', 'Fitnessstudio', 'Salle de sport', 'Gimnasio', 'Palestra', 'Academia', 'ØµØ§Ù„Ø© Ø±ÙŠØ§Ø¶ÙŠØ©', 'à¤œà¤¿à¤®', 'å¥èº«æˆ¿', 'ã‚¸ãƒ ', 'í—¬ìŠ¤ìž¥');
  String get cardio => _pick('Cardio', 'Kardiyo', 'Cardio', 'Cardio', 'Cardio', 'Cardio', 'Cardio', 'ÙƒØ§Ø±Ø¯ÙŠÙˆ', 'à¤•à¤¾à¤°à¥à¤¡à¤¿à¤¯à¥‹', 'æœ‰æ°§', 'æœ‰é…¸ç´ ', 'ìœ ì‚°ì†Œ');
  String get abs => _pick('Abs', 'KarÄ±n', 'Bauch', 'Abdos', 'Abdominales', 'Addominali', 'Abdominais', 'Ø§Ù„Ø¨Ø·Ù†', 'à¤à¤¬à¥à¤¸', 'è…¹è‚Œ', 'è…¹ç­‹', 'ë³µê·¼');
  String get legs => _pick('Legs', 'Bacaklar', 'Beine', 'Jambes', 'Piernas', 'Gambe', 'Pernas', 'Ø§Ù„Ø³Ø§Ù‚ÙŠÙ†', 'à¤ªà¥ˆà¤°', 'è…¿', 'è„š', 'ë‹¤ë¦¬');
  String get arms => _pick('Arms', 'Kollar', 'Arme', 'Bras', 'Brazos', 'Braccia', 'BraÃ§os', 'Ø§Ù„Ø°Ø±Ø§Ø¹ÙŠÙ†', 'à¤¬à¤¾à¤‚à¤¹à¥‡à¤‚', 'æ‰‹è‡‚', 'è…•', 'íŒ”');
  String get fullBody => _pick('Full Body', 'TÃ¼m VÃ¼cut', 'GanzkÃ¶rper', 'Corps entier', 'Cuerpo completo', 'Corpo intero', 'Corpo inteiro', 'Ø§Ù„Ø¬Ø³Ù… Ø¨Ø§Ù„ÙƒØ§Ù…Ù„', 'à¤ªà¥‚à¤°à¥à¤£ à¤¶à¤°à¥€à¤°', 'å…¨èº«', 'å…¨èº«', 'ì „ì‹ ');
  String get hiit => _pick('HIIT', 'HIIT', 'HIIT', 'HIIT', 'HIIT', 'HIIT', 'HIIT', 'Ù‡ÙŠØª', 'HIIT', 'HIIT', 'HIIT', 'HIIT');
  String get stretch => _pick('Stretch', 'Esneme', 'Dehnen', 'Ã‰tirement', 'Estiramiento', 'Stretching', 'Alongamento', 'ØªÙ…Ø¯Ø¯', 'à¤¸à¥à¤Ÿà¥à¤°à¥‡à¤š', 'æ‹‰ä¼¸', 'ã‚¹ãƒˆãƒ¬ãƒƒãƒ', 'ìŠ¤íŠ¸ë ˆì¹­');
}

class ExerciseDetailScreen extends StatelessWidget {
  final ExerciseItem exercise;
  final Strings t;
  const ExerciseDetailScreen({super.key, required this.exercise, required this.t});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(exercise.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(exercise.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              Wrap(spacing: 8, runSpacing: 8, children: [Chip(label: Text(categoryLabel(t, exercise.category))), Chip(label: Text('${exercise.durationSec} sn')), Chip(label: Text('${exercise.calories} kcal')), Chip(label: Text(equipmentLabel(t, exercise.equipment)))]),
            ]),
          ),
          const SizedBox(height: 20),
          Text(exercise.description, style: const TextStyle(fontSize: 16, height: 1.5)),
          const SizedBox(height: 24),
          if (exercise.gifAsset.isNotEmpty)
            ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset(exercise.gifAsset, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(height: 220, alignment: Alignment.center, decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20)), child: const Text('GIF bulunamadÄ±'))))
          else if (exercise.imageAsset.isNotEmpty)
            ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset(exercise.imageAsset, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(height: 220, alignment: Alignment.center, decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20)), child: const Text('GÃ¶rsel bulunamadÄ±')))),
        ]),
      ),
    );
  }
}

class ProgramDetailScreen extends StatelessWidget {
  final ProgramItem program;
  final Strings t;
  const ProgramDetailScreen({super.key, required this.program, required this.t});
  @override
  Widget build(BuildContext context) {
    final previewGif = programGifAsset(program);
    return Scaffold(
      appBar: AppBar(title: Text(program.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (previewGif != null)
            ClipRRect(borderRadius: BorderRadius.circular(24), child: Image.asset(previewGif, height: 180, width: double.infinity, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(height: 180, decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.accent]), borderRadius: BorderRadius.circular(24)), alignment: Alignment.center, child: const Icon(Icons.play_circle_fill, size: 44, color: Colors.white))))
          else
            Container(height: 180, decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.accent]), borderRadius: BorderRadius.circular(24)), alignment: Alignment.center, child: const Icon(Icons.play_circle_fill, size: 44, color: Colors.white)),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(program.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text(program.group),
                const SizedBox(height: 12),
                Wrap(spacing: 8, runSpacing: 8, children: [Chip(label: Text('${program.totalDays} days')), Chip(label: Text(program.level.name)), Chip(label: Text(equipmentLabel(t, program.equipment))), if (program.isPremium) const Chip(label: Text('Premium'))]),
              ]),
            ),
          ),
          const SizedBox(height: 16),
          ...program.days.map((day) {
            final exercises = exercisesForDay(day);
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Day ${day.day}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  ...exercises.map((exercise) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(width: 48, height: 48, decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.accent]), borderRadius: BorderRadius.circular(10)), alignment: Alignment.center, child: const Icon(Icons.play_arrow, color: Colors.white)),
                    title: Text(exercise.name),
                    subtitle: Text('${categoryLabel(t, exercise.category)} â€¢ ${exercise.durationSec} sn â€¢ ${exercise.calories} kcal'),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExerciseDetailScreen(exercise: exercise, t: t))),
                  )),
                ]),
              ),
            );
          }),
        ],
      ),
    );
  }
}
