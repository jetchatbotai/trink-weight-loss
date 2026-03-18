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
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.dark,
        ),
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
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: t.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.fitness_center_outlined),
            selectedIcon: const Icon(Icons.fitness_center),
            label: t.workouts,
          ),
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard),
            label: t.programs,
          ),
          NavigationDestination(
            icon: const Icon(Icons.show_chart_outlined),
            selectedIcon: const Icon(Icons.show_chart),
            label: t.progress,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: t.profile,
          ),
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

  const HomeScreen({
    super.key,
    required this.t,
    required this.goal,
    required this.onGoalChanged,
    required this.waterGlasses,
    required this.dailySteps,
    required this.caloriesLogged,
    required this.targetCalories,
  });

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
                  Text(
                    'Trink Fit',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: textColor),
                  ),
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
              const Text(
                '15 min Fat Burn',
                style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(t.fiveExercisesVoiceCoach, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 14),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.primary,
                ),
                onPressed: () {},
                child: Text(t.startWorkout),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: StatCard(title: t.dailyStreak, value: '7 🔥')),
            const SizedBox(width: 12),
            Expanded(child: StatCard(title: t.steps, value: '$dailySteps')),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: StatCard(title: t.water, value: '${(waterGlasses * 0.25).toStringAsFixed(2)}L / 2L')),
            const SizedBox(width: 12),
            Expanded(child: StatCard(title: t.bmi, value: '24.1')),
          ],
        ),
        const SizedBox(height: 20),
        SectionTitle(title: t.goalSelection),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: GoalType.values.map((g) {
            return ChoiceChip(
              label: Text(goalLabel(t, g)),
              selected: goal == g,
              onSelected: (_) => onGoalChanged(g),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        SectionTitle(title: t.quickWorkout),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: DashboardTile(title: t.challenge30Day, subtitle: t.fatBurnPlan, icon: Icons.local_fire_department)),
            const SizedBox(width: 12),
            Expanded(child: DashboardTile(title: t.aiTrainer, subtitle: t.createWorkoutForBellyFat, icon: Icons.auto_awesome)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: DashboardTile(title: t.calorieTracker, subtitle: '$caloriesLogged / $targetCalories kcal', icon: Icons.restaurant_menu)),
            const SizedBox(width: 12),
            Expanded(child: DashboardTile(title: t.smartReminder, subtitle: t.timeForWorkout, icon: Icons.notifications_active)),
          ],
        ),
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

  const WorkoutsScreen({
    super.key,
    required this.t,
    required this.equipment,
    required this.onEquipmentChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<ExerciseItem> filtered = equipment == null
        ? List<ExerciseItem>.from(trinkExercises)
        : trinkExercises.where((e) => e.equipment == equipment).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionTitle(title: t.workouts),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ChoiceChip(
              label: Text(t.all),
              selected: equipment == null,
              onSelected: (_) => onEquipmentChanged(null),
            ),
            ...EquipmentType.values.map((e) {
              return ChoiceChip(
                label: Text(equipmentLabel(t, e)),
                selected: equipment == e,
                onSelected: (_) => onEquipmentChanged(e),
              );
            }),
          ],
        ),
        const SizedBox(height: 16),
        ...filtered.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(28),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ExerciseDetailScreen(
                        exercise: e,
                        t: t,
                      ),
                    ),
                  );
                },
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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: .95,
          ),
          itemBuilder: (context, index) {
            final p = trinkPrograms[index];
            return InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProgramDetailScreen(program: p, t: t),
                  ),
                );
              },
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

  const ProgressScreen({
    super.key,
    required this.t,
    required this.waterGlasses,
    required this.onAddWater,
    required this.dailySteps,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionTitle(title: t.progress),
        const SizedBox(height: 16),
        DashboardTile(title: t.beforeAfter, subtitle: t.trackTransformation, icon: Icons.photo_library_outlined),
        const SizedBox(height: 12),
        DashboardTile(title: t.achievements, subtitle: 'First Workout • 7 Day Streak', icon: Icons.emoji_events_outlined),
        const SizedBox(height: 12),
        DashboardTile(title: t.waterTracker, subtitle: '${(waterGlasses * 0.25).toStringAsFixed(2)} L', icon: Icons.water_drop_outlined),
        const SizedBox(height: 12),
        FilledButton(onPressed: onAddWater, child: Text(t.addWaterGlass)),
        const SizedBox(height: 12),
        DashboardTile(title: t.stepCounter, subtitle: '$dailySteps ${t.steps}', icon: Icons.directions_walk_outlined),
        const SizedBox(height: 12),
        DashboardTile(title: t.healthIntegration, subtitle: 'Google Fit • Apple Health', icon: Icons.favorite_border),
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

  const ProfileScreen({
    super.key,
    required this.t,
    required this.lang,
    required this.onLangChanged,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

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
          onChanged: (value) {
            if (value != null) onLangChanged(value);
          },
        ),
        const SizedBox(height: 16),
        DashboardTile(title: t.bmiCalculator, subtitle: 'BMI = 24.1 • Normal', icon: Icons.monitor_weight_outlined),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const DashboardTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppTheme.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.7))),
                ],
              ),
            ),
          ],
        ),
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
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.accent]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.play_circle_outline, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${categoryLabel(t, exercise.category)} • ${exercise.calories} kcal',
                    style: const TextStyle(fontSize: 12),
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

class ProgramCard extends StatelessWidget {
  final ProgramItem program;

  const ProgramCard({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final previewGif = programGifAsset(program);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (previewGif != null)
            SizedBox(
              height: 110,
              width: double.infinity,
              child: Image.asset(
                previewGif,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.accent]),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.play_circle_fill, size: 36, color: Colors.white),
                  );
                },
              ),
            )
          else
            Container(
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.accent]),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.play_circle_fill, size: 36, color: Colors.white),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          program.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                      ),
                      if (program.isPremium) ...[
                        const Icon(Icons.workspace_premium, color: Colors.amber),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(program.group),
                  const Spacer(),
                  Text('${program.totalDays} days'),
                ],
              ),
            ),
          ),
        ],
      ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Premium + Ads Model', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            SizedBox(height: 10),
            Text('Monthly   179 TL'),
            Text('3 Months  399 TL'),
            Text('6 Months  599 TL'),
            Text('Yearly    899 TL ⭐'),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800));
  }
}

String goalLabel(Strings t, GoalType g) {
  switch (g) {
    case GoalType.loseWeight:
      return t.loseWeight;
    case GoalType.buildMuscle:
      return t.buildMuscle;
    case GoalType.stayFit:
      return t.stayFit;
    case GoalType.improveCardio:
      return t.improveCardio;
  }
}

String equipmentLabel(Strings t, EquipmentType e) {
  switch (e) {
    case EquipmentType.none:
      return t.noEquipment;
    case EquipmentType.dumbbell:
      return t.dumbbell;
    case EquipmentType.resistanceBand:
      return t.resistanceBand;
    case EquipmentType.gym:
      return t.gym;
  }
}

String themeModeLabel(Strings t, ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return t.lightMode;
    case ThemeMode.dark:
      return t.darkMode;
    case ThemeMode.system:
      return t.systemMode;
  }
}

String langLabel(AppLang lang) {
  switch (lang) {
    case AppLang.en:
      return 'English';
    case AppLang.tr:
      return 'Türkçe';
    case AppLang.de:
      return 'Deutsch';
    case AppLang.fr:
      return 'Français';
    case AppLang.es:
      return 'Español';
    case AppLang.it:
      return 'Italiano';
    case AppLang.pt:
      return 'Português';
    case AppLang.ar:
      return 'العربية';
    case AppLang.hi:
      return 'हिन्दी';
    case AppLang.zh:
      return '中文';
    case AppLang.ja:
      return '日本語';
    case AppLang.ko:
      return '한국어';
  }
}

String categoryLabel(Strings t, ExerciseCategory c) {
  switch (c) {
    case ExerciseCategory.cardio:
      return t.cardio;
    case ExerciseCategory.abs:
      return t.abs;
    case ExerciseCategory.legs:
      return t.legs;
    case ExerciseCategory.arms:
      return t.arms;
    case ExerciseCategory.fullBody:
      return t.fullBody;
    case ExerciseCategory.hiit:
      return t.hiit;
    case ExerciseCategory.stretch:
      return t.stretch;
  }
}


ExerciseItem? findExerciseById(String id) {
  for (final e in trinkExercises) {
    if (e.id == id) return e;
  }
  return null;
}

ExerciseItem? exerciseById(String id) {
  for (final exercise in trinkExercises) {
    if (exercise.id == id) return exercise;
  }
  return null;
}

List<ExerciseItem> exercisesForDay(ProgramDay day) {
  return day.exerciseIds
      .map(exerciseById)
      .whereType<ExerciseItem>()
      .toList();
}

String? programGifAsset(ProgramItem program) {
  if (program.days.isEmpty || program.days.first.exerciseIds.isEmpty) return null;
  final firstExercise = exerciseById(program.days.first.exerciseIds.first);
  if (firstExercise == null || firstExercise.gifAsset.isEmpty) return null;
  return firstExercise.gifAsset;
}

String? programCoverAsset(ProgramItem program) {
  if (program.days.isEmpty || program.days.first.exerciseIds.isEmpty) return null;
  final firstExercise = exerciseById(program.days.first.exerciseIds.first);
  if (firstExercise == null || firstExercise.imageAsset.isEmpty) return null;
  return firstExercise.imageAsset;
}

class Strings {
  final AppLang lang;
  const Strings(this.lang);

  String _pick(
    String en,
    String tr,
    String de,
    String fr,
    String es,
    String it,
    String pt,
    String ar,
    String hi,
    String zh,
    String ja,
    String ko,
  ) {
    switch (lang) {
      case AppLang.en:
        return en;
      case AppLang.tr:
        return tr;
      case AppLang.de:
        return de;
      case AppLang.fr:
        return fr;
      case AppLang.es:
        return es;
      case AppLang.it:
        return it;
      case AppLang.pt:
        return pt;
      case AppLang.ar:
        return ar;
      case AppLang.hi:
        return hi;
      case AppLang.zh:
        return zh;
      case AppLang.ja:
        return ja;
      case AppLang.ko:
        return ko;
    }
  }

  String get home => _pick('Home', 'Ana Sayfa', 'Start', 'Accueil', 'Inicio', 'Home', 'Início', 'الرئيسية', 'होम', '首页', 'ホーム', '홈');
  String get workouts => _pick('Workouts', 'Antrenmanlar', 'Workouts', 'Entraînements', 'Entrenos', 'Allenamenti', 'Treinos', 'التمارين', 'वर्कआउट', '训练', 'ワークアウト', '운동');
  String get programs => _pick('Programs', 'Programlar', 'Programme', 'Programmes', 'Programas', 'Programmi', 'Programas', 'البرامج', 'प्रोग्राम', '计划', 'プログラム', '프로그램');
  String get progress => _pick('Progress', 'İlerleme', 'Fortschritt', 'Progrès', 'Progreso', 'Progressi', 'Progresso', 'التقدم', 'प्रगति', '进度', '進捗', '진행');
  String get profile => _pick('Profile', 'Profil', 'Profil', 'Profil', 'Perfil', 'Profilo', 'Perfil', 'الملف الشخصي', 'प्रोफाइल', '我的', 'プロフィール', '프로필');
  String get appSubtitle => _pick('Home Workout, Weight Loss & Fitness', 'Evde Egzersiz, Kilo Verme ve Fitness', 'Home Training, Gewichtsverlust & Fitness', 'Entraînement à domicile, perte de poids et fitness', 'Entrenamiento en casa, pérdida de peso y fitness', 'Allenamento a casa, perdita di peso e fitness', 'Treino em casa, perda de peso e fitness', 'تمارين منزلية، خسارة الوزن واللياقة', 'होम वर्कआउट, वजन घटाना और फिटनेस', '居家锻炼, 减重与健身', 'ホームワークアウト、減量とフィットネス', '홈트레이닝, 체중 감량 및 피트니스');
  String get todaysWorkout => _pick("Today's Workout", 'Bugünün Antrenmanı', 'Heutiges Training', "Entraînement d'aujourd'hui", 'Entrenamiento de hoy', 'Allenamento di oggi', 'Treino de hoje', 'تمرين اليوم', 'आज का वर्कआउट', '今日训练', '今日のワークアウト', '오늘의 운동');
  String get fiveExercisesVoiceCoach => _pick('5 Exercises Voice Coach', '5 Egzersiz Sesli Koç', '5 Übungen Sprachcoach', 'Coach vocal 5 exercices', 'Coach de voz de 5 ejercicios', 'Coach vocale 5 esercizi', 'Coach de voz 5 exercícios', 'مدرب صوتي لـ 5 تمارين', '5 एक्सरसाइज़ वॉइस कोच', '5 个练习语音教练', '5エクササイズ音声コーチ', '5개 운동 음성 코치');
  String get startWorkout => _pick('Start Workout', 'Antrenmanı Başlat', 'Training starten', 'Commencer l’entraînement', 'Iniciar entrenamiento', 'Avvia allenamento', 'Iniciar treino', 'ابدأ التمرين', 'वर्कआउट शुरू करें', '开始训练', 'ワークアウト開始', '운동 시작');
  String get dailyStreak => _pick('Daily Streak', 'Günlük Seri', 'Tägliche Serie', 'Série quotidienne', 'Racha diaria', 'Serie giornaliera', 'Sequência diária', 'سلسلة يومية', 'दैनिक स्ट्रीक', '每日连续', 'デイリーストリーク', '일일 연속');
  String get steps => _pick('Steps', 'Adım', 'Schritte', 'Pas', 'Pasos', 'Passi', 'Passos', 'الخطوات', 'कदम', '步数', '歩数', '걸음 수');
  String get water => _pick('Water', 'Su', 'Wasser', 'Eau', 'Agua', 'Acqua', 'Água', 'الماء', 'पानी', '水', '水', '물');
  String get bmi => _pick('BMI', 'BMI', 'BMI', 'IMC', 'IMC', 'BMI', 'IMC', 'مؤشر كتلة الجسم', 'बीएमआई', 'BMI', 'BMI', 'BMI');
  String get goalSelection => _pick('Goal Selection', 'Hedef Seçimi', 'Zielauswahl', 'Sélection d’objectif', 'Selección de objetivo', 'Selezione obiettivo', 'Seleção de objetivo', 'اختيار الهدف', 'लक्ष्य चयन', '目标选择', '目標選択', '목표 선택');
  String get quickWorkout => _pick('Quick Workout', 'Hızlı Antrenman', 'Schnelles Training', 'Entraînement rapide', 'Entrenamiento rápido', 'Allenamento rapido', 'Treino rápido', 'تمرين سريع', 'त्वरित कसरत', '快速训练', 'クイックワークアウト', '빠른 운동');
  String get challenge30Day => _pick('30-Day Challenge', '30 Günlük Meydan Okuma', '30-Tage-Challenge', 'Défi de 30 jours', 'Desafío de 30 días', 'Sfida di 30 giorni', 'Desafio de 30 dias', 'تحدي 30 يومًا', '30-दिवसीय चैलेंज', '30天挑战', '30日間チャレンジ', '30일 챌린지');
  String get fatBurnPlan => _pick('Fat Burn Plan', 'Yağ Yakma Planı', 'Fettverbrennungsplan', 'Plan brûle-graisse', 'Plan para quemar grasa', 'Piano brucia grassi', 'Plano de queima de gordura', 'خطة حرق الدهون', 'फैट बर्न प्लान', '燃脂计划', '脂肪燃焼プラン', '지방 연소 플랜');
  String get aiTrainer => _pick('AI Trainer', 'Yapay Zekâ Antrenörü', 'KI-Trainer', 'Coach IA', 'Entrenador IA', 'Allenatore IA', 'Treinador IA', 'مدرب الذكاء الاصطناعي', 'एआई ट्रेनर', 'AI教练', 'AIトレーナー', 'AI 트레이너');
  String get createWorkoutForBellyFat => _pick('Create workout for belly fat', 'Göbek yağı için antrenman oluştur', 'Training gegen Bauchfett erstellen', 'Créer un entraînement pour la graisse du ventre', 'Crear entrenamiento para grasa abdominal', 'Crea allenamento per il grasso addominale', 'Criar treino para gordura abdominal', 'أنشئ تمرينًا لدهون البطن', 'पेट की चर्बी के लिए वर्कआउट बनाएं', '为腹部脂肪创建训练', 'お腹の脂肪向けワークアウトを作成', '복부 지방용 운동 만들기');
  String get calorieTracker => _pick('Calorie Tracker', 'Kalori Takibi', 'Kalorien-Tracker', 'Suivi des calories', 'Seguimiento de calorías', 'Monitor calorie', 'Rastreador de calorias', 'متتبع السعرات الحرارية', 'कैलोरी ट्रैकर', '卡路里追踪', 'カロリートラッカー', '칼로리 추적기');
  String get smartReminder => _pick('Smart Reminder', 'Akıllı Hatırlatıcı', 'Intelligente Erinnerung', 'Rappel intelligent', 'Recordatorio inteligente', 'Promemoria intelligente', 'Lembrete inteligente', 'تذكير ذكي', 'स्मार्ट रिमाइंडर', '智能提醒', 'スマートリマインダー', '스마트 알림');
  String get timeForWorkout => _pick('Time for workout', 'Antrenman zamanı', 'Zeit fürs Training', "C'est l'heure de s'entraîner", 'Hora de entrenar', 'È ora di allenarsi', 'Hora do treino', 'حان وقت التمرين', 'वर्कआउट का समय', '该锻炼了', 'ワークアウトの時間', '운동할 시간');
  String get premiumPlans => _pick('Premium Plans', 'Premium Planlar', 'Premium-Pläne', 'Plans premium', 'Planes premium', 'Piani premium', 'Planos premium', 'خطط بريميوم', 'प्रीमियम प्लान', '高级计划', 'プレミアムプラン', '프리미엄 플랜');
  String get loseWeight => _pick('Lose Weight', 'Kilo Ver', 'Gewicht verlieren', 'Perdre du poids', 'Perder peso', 'Perdere peso', 'Perder peso', 'إنقاص الوزن', 'वजन घटाएं', '减肥', '減量', '체중 감량');
  String get buildMuscle => _pick('Build Muscle', 'Kas Yap', 'Muskeln aufbauen', 'Développer les muscles', 'Ganar músculo', 'Costruire muscoli', 'Ganhar músculos', 'بناء العضلات', 'मांसपेशियाँ बनाएं', '增肌', '筋肉をつける', '근육 만들기');
  String get stayFit => _pick('Stay Fit', 'Formda Kal', 'Fit bleiben', 'Rester en forme', 'Mantenerse en forma', 'Rimani in forma', 'Manter a forma', 'الحفاظ على اللياقة', 'फिट रहें', '保持健康', '健康を保つ', '몸매 유지');
  String get improveCardio => _pick('Improve Cardio', 'Kardiyoyu Geliştir', 'Cardio verbessern', 'Améliorer le cardio', 'Mejorar cardio', 'Migliora il cardio', 'Melhorar cardio', 'تحسين الكارديو', 'कार्डियो सुधारें', '提升心肺功能', '有酸素能力を向上', '유산소 능력 향상');
  String get beforeAfter => _pick('Before & After', 'Öncesi ve Sonrası', 'Vorher & Nachher', 'Avant / Après', 'Antes y Después', 'Prima e Dopo', 'Antes e Depois', 'قبل وبعد', 'पहले और बाद में', '前后对比', 'ビフォーアフター', '전후 비교');
  String get trackTransformation => _pick('Track Transformation', 'Değişimi Takip Et', 'Transformation verfolgen', 'Suivre la transformation', 'Seguir transformación', 'Monitora trasformazione', 'Acompanhar transformação', 'تتبع التغيير', 'परिवर्तन ट्रैक करें', '追踪变化', '変化を追跡', '변화 추적');
  String get achievements => _pick('Achievements', 'Başarılar', 'Erfolge', 'Succès', 'Logros', 'Risultati', 'Conquistas', 'الإنجازات', 'उपलब्धियाँ', '成就', '実績', '업적');
  String get waterTracker => _pick('Water Tracker', 'Su Takibi', 'Wasser Tracker', 'Suivi de l’eau', 'Seguimiento de agua', 'Monitoraggio acqua', 'Monitor de água', 'متابعة الماء', 'वॉटर ट्रैकर', '饮水追踪', '水分トラッカー', '물 섭취 추적');
  String get stepCounter => _pick('Step Counter', 'Adım Sayacı', 'Schrittzähler', 'Compteur de pas', 'Contador de pasos', 'Contapassi', 'Contador de passos', 'عداد الخطوات', 'स्टेप काउंटर', '计步器', '歩数計', '만보계');
  String get addWaterGlass => _pick('Add Water', 'Su Ekle', 'Wasser hinzufügen', 'Ajouter de l’eau', 'Agregar agua', 'Aggiungi acqua', 'Adicionar água', 'إضافة ماء', 'पानी जोड़ें', '添加饮水', '水を追加', '물 추가');
  String get adsPremium => _pick('Ads Premium', 'Reklam Premium', 'Werbe-Premium', 'Premium pubs', 'Premium con anuncios', 'Premium con pubblicità', 'Premium com anúncios', 'بريميوم مع إعلانات', 'विज्ञापन प्रीमियम', '广告高级版', '広告付きプレミアム', '광고 포함 프리미엄');
  String get premiumAndAdsModel => _pick('Premium + Ads Model', 'Premium + Reklam Modeli', 'Premium + Werbemodell', 'Modèle Premium + pubs', 'Modelo Premium + anuncios', 'Modello Premium + pubblicità', 'Modelo Premium + anúncios', 'نموذج بريميوم + إعلانات', 'प्रीमियम + विज्ञापन मॉडल', '高级版 + 广告模式', 'プレミアム + 広告モデル', '프리미엄 + 광고 모델');
  String get theme => _pick('Theme', 'Tema', 'Thema', 'Thème', 'Tema', 'Tema', 'Tema', 'السمة', 'थीम', '主题', 'テーマ', '테마');
  String get language => _pick('Language', 'Dil', 'Sprache', 'Langue', 'Idioma', 'Lingua', 'Idioma', 'اللغة', 'भाषा', '语言', '言語', '언어');
  String get bmiCalculator => _pick('BMI Calculator', 'BMI Hesaplayıcı', 'BMI Rechner', 'Calculateur IMC', 'Calculadora IMC', 'Calcolatore BMI', 'Calculadora de IMC', 'حاسبة BMI', 'BMI कैलकुलेटर', 'BMI 计算器', 'BMI計算機', 'BMI 계산기');
  String get widgetTitle => _pick('Widgets', 'Widgetler', 'Widgets', 'Widgets', 'Widgets', 'Widget', 'Widgets', 'الويدجت', 'विजेट्स', '小组件', 'ウィジェット', '위젯');
  String get healthIntegration => _pick('Health Integration', 'Sağlık Entegrasyonu', 'Gesundheitsintegration', 'Intégration Santé', 'Integración de Salud', 'Integrazione Salute', 'Integração de Saúde', 'تكامل الصحة', 'हेल्थ इंटीग्रेशन', '健康集成', 'ヘルス連携', '건강 연동');
  String get themeTitle => theme;
  String get darkMode => _pick('Dark Mode', 'Koyu Mod', 'Dunkler Modus', 'Mode sombre', 'Modo oscuro', 'Modalità scura', 'Modo escuro', 'الوضع الداكن', 'डार्क मोड', '深色模式', 'ダークモード', '다크 모드');
  String get lightMode => _pick('Light Mode', 'Açık Mod', 'Heller Modus', 'Mode clair', 'Modo claro', 'Modalità chiara', 'Modo claro', 'الوضع الفاتح', 'लाइट मोड', '浅色模式', 'ライトモード', '라이트 모드');
  String get systemMode => _pick('System Mode', 'Sistem Modu', 'Systemmodus', 'Mode système', 'Modo del sistema', 'Modalità sistema', 'Modo do sistema', 'وضع النظام', 'सिस्टम मोड', '系统模式', 'システムモード', '시스템 모드');
  String get all => _pick('All', 'Tümü', 'Alle', 'Tous', 'Todos', 'Tutti', 'Todos', 'الكل', 'सभी', '全部', 'すべて', '전체');
  String get noEquipment => _pick('No Equipment', 'Ekipmansız', 'Ohne Geräte', 'Sans équipement', 'Sin equipo', 'Senza attrezzi', 'Sem equipamento', 'بدون معدات', 'बिना उपकरण', '无器械', '器具なし', '장비 없음');
  String get dumbbell => _pick('Dumbbell', 'Dambıl', 'Hantel', 'Haltère', 'Mancuerna', 'Manubrio', 'Halter', 'دمبل', 'डम्बल', '哑铃', 'ダンベル', '덤벨');
  String get resistanceBand => _pick('Resistance Band', 'Direnç Bandı', 'Widerstandsband', 'Bande de résistance', 'Banda elástica', 'Banda di resistenza', 'Banda elástica', 'حبل مقاومة', 'रेज़िस्टेंस बैंड', '阻力带', 'レジスタンスバンド', '저항 밴드');
  String get gym => _pick('Gym', 'Spor Salonu', 'Fitnessstudio', 'Salle de sport', 'Gimnasio', 'Palestra', 'Academia', 'صالة رياضية', 'जिम', '健身房', 'ジム', '헬스장');
  String get cardio => _pick('Cardio', 'Kardiyo', 'Cardio', 'Cardio', 'Cardio', 'Cardio', 'Cardio', 'كارديو', 'कार्डियो', '有氧', '有酸素', '유산소');
  String get abs => _pick('Abs', 'Karın', 'Bauch', 'Abdos', 'Abdominales', 'Addominali', 'Abdominais', 'البطن', 'एब्स', '腹肌', '腹筋', '복근');
  String get legs => _pick('Legs', 'Bacaklar', 'Beine', 'Jambes', 'Piernas', 'Gambe', 'Pernas', 'الساقين', 'पैर', '腿', '脚', '다리');
  String get arms => _pick('Arms', 'Kollar', 'Arme', 'Bras', 'Brazos', 'Braccia', 'Braços', 'الذراعين', 'बांहें', '手臂', '腕', '팔');
  String get fullBody => _pick('Full Body', 'Tüm Vücut', 'Ganzkörper', 'Corps entier', 'Cuerpo completo', 'Corpo intero', 'Corpo inteiro', 'الجسم بالكامل', 'पूर्ण शरीर', '全身', '全身', '전신');
  String get hiit => _pick('HIIT', 'HIIT', 'HIIT', 'HIIT', 'HIIT', 'HIIT', 'HIIT', 'هيت', 'HIIT', 'HIIT', 'HIIT', 'HIIT');
  String get stretch => _pick('Stretch', 'Esneme', 'Dehnen', 'Étirement', 'Estiramiento', 'Stretching', 'Alongamento', 'تمدد', 'स्ट्रेच', '拉伸', 'ストレッチ', '스트레칭');
}


class ExerciseDetailScreen extends StatelessWidget {
  final ExerciseItem exercise;
  final Strings t;

  const ExerciseDetailScreen({
    super.key,
    required this.exercise,
    required this.t,
  });

  String equipmentLabelLocal(Strings t, EquipmentType e) {
    switch (e) {
      case EquipmentType.none:
        return t.noEquipment;
      case EquipmentType.dumbbell:
        return t.dumbbell;
      case EquipmentType.resistanceBand:
        return t.resistanceBand;
      case EquipmentType.gym:
        return t.gym;
    }
  }

  @override
  Widget build(BuildContext context) {
    final exercise = this.exercise;
    final t = this.t;

    return Scaffold(
      appBar: AppBar(title: Text(exercise.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(label: Text(categoryLabel(t, exercise.category))),
                      Chip(label: Text('${exercise.durationSec} sn')),
                      Chip(label: Text('${exercise.calories} kcal')),
                      Chip(label: Text(equipmentLabelLocal(t, exercise.equipment))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(exercise.description, style: const TextStyle(fontSize: 16, height: 1.5)),
            const SizedBox(height: 24),
            if (exercise.gifAsset.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  exercise.gifAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 220,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('GIF bulunamadı'),
                    );
                  },
                ),
              )
            else if (exercise.imageAsset.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  exercise.imageAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 220,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Görsel bulunamadı'),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ProgramDetailScreen extends StatelessWidget {
  final ProgramItem program;
  final Strings t;

  const ProgramDetailScreen({
    super.key,
    required this.program,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final previewGif = programGifAsset(program);

    return Scaffold(
      appBar: AppBar(
        title: Text(program.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (previewGif != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                previewGif,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.accent]),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.play_circle_fill, size: 44, color: Colors.white),
                  );
                },
              ),
            )
          else
            Container(
              height: 180,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.accent]),
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.play_circle_fill, size: 44, color: Colors.white),
            ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text(program.group),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(label: Text('${program.totalDays} days')),
                      Chip(label: Text(program.level.name)),
                      Chip(label: Text(equipmentLabel(t, program.equipment))),
                      if (program.isPremium) const Chip(label: Text('Premium')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...program.days.map((day) {
            final exercises = exercisesForDay(day);
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Day ${day.day}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 10),
                    ...exercises.map((exercise) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.accent]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(Icons.play_arrow, color: Colors.white),
                        ),
                        title: Text(exercise.name),
                        subtitle: Text(
                          '${categoryLabel(t, exercise.category)} • ${exercise.durationSec} sn • ${exercise.calories} kcal',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ExerciseDetailScreen(
                                exercise: exercise,
                                t: t,
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
