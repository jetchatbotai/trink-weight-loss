import 'package:flutter/material.dart';
import 'data/trink_fit_data_models.dart';
void main() { runApp(const TrinkFitApp()); }

enum AppLang { en, tr, de, fr, es, it, pt, ar, hi, zh, ja, ko, }

enum GoalType { loseWeight, buildMuscle, stayFit, improveCardio } enum EquipmentType { all, noEquipment, dumbbell, resistanceBand, gym }

class TrinkFitApp extends StatefulWidget { const TrinkFitApp({super.key});

@override State<TrinkFitApp> createState() => _TrinkFitAppState(); }

class _TrinkFitAppState extends State<TrinkFitApp> { ThemeMode themeMode = ThemeMode.system; AppLang lang = AppLang.en;

@override Widget build(BuildContext context) { return MaterialApp( debugShowCheckedModeBanner: false, title: 'Trink Fit', themeMode: themeMode, theme: AppTheme.light, darkTheme: AppTheme.dark, home: MainShell( lang: lang, themeMode: themeMode, onLangChanged: (value) => setState(() => lang = value), onThemeModeChanged: (value) => setState(() => themeMode = value), ), ); } }

class AppTheme { static const Color primary = Color(0xFF2D7FF9); static const Color accent = Color(0xFF21C97A); static const Color lightBg = Color(0xFFF4F7FB); static const Color darkBg = Color(0xFF0E1726); static const Color lightCard = Colors.white; static const Color darkCard = Color(0xFF172235); static const Color textDark = Color(0xFF111827);

static ThemeData get light => ThemeData( useMaterial3: true, scaffoldBackgroundColor: lightBg, colorScheme: ColorScheme.fromSeed(seedColor: primary), appBarTheme: const AppBarTheme( backgroundColor: Colors.transparent, foregroundColor: textDark, elevation: 0, centerTitle: false, ), cardTheme: CardThemeData( color: lightCard, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), ), );

static ThemeData get dark => ThemeData( useMaterial3: true, scaffoldBackgroundColor: darkBg, colorScheme: ColorScheme.fromSeed( seedColor: primary, brightness: Brightness.dark, ), appBarTheme: const AppBarTheme( backgroundColor: Colors.transparent, foregroundColor: Colors.white, elevation: 0, centerTitle: false, ), cardTheme: CardThemeData( color: darkCard, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), ), ); }

class MainShell extends StatefulWidget { final AppLang lang; final ThemeMode themeMode; final ValueChanged<AppLang> onLangChanged; final ValueChanged<ThemeMode> onThemeModeChanged;

const MainShell({ super.key, required this.lang, required this.themeMode, required this.onLangChanged, required this.onThemeModeChanged, });

@override State<MainShell> createState() => _MainShellState(); }

class _MainShellState extends State<MainShell> { int index = 0; GoalType goal = GoalType.loseWeight; EquipmentType equipment = EquipmentType.all; int waterGlasses = 5; int dailySteps = 6842; int caloriesLogged = 1280; int targetCalories = 1800;

@override Widget build(BuildContext context) { final t = Strings(widget.lang); final screens = [ HomeScreen( t: t, goal: goal, onGoalChanged: (v) => setState(() => goal = v), waterGlasses: waterGlasses, dailySteps: dailySteps, caloriesLogged: caloriesLogged, targetCalories: targetCalories, ), WorkoutsScreen( t: t, equipment: equipment, onEquipmentChanged: (v) => setState(() => equipment = v), ), ProgramsScreen(t: t), ProgressScreen( t: t, waterGlasses: waterGlasses, onAddWater: () => setState(() => waterGlasses++), dailySteps: dailySteps, ), ProfileScreen( t: t, lang: widget.lang, onLangChanged: widget.onLangChanged, themeMode: widget.themeMode, onThemeModeChanged: widget.onThemeModeChanged, ), ];

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

} }

class HomeScreen extends StatelessWidget { final Strings t; final GoalType goal; final ValueChanged<GoalType> onGoalChanged; final int waterGlasses; final int dailySteps; final int caloriesLogged; final int targetCalories;

const HomeScreen({ super.key, required this.t, required this.goal, required this.onGoalChanged, required this.waterGlasses, required this.dailySteps, required this.caloriesLogged, required this.targetCalories, });

@override Widget build(BuildContext context) { final isDark = Theme.of(context).brightness == Brightness.dark; final textColor = isDark ? Colors.white : AppTheme.textDark;

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

} }

class WorkoutsScreen extends StatelessWidget { final Strings t; final EquipmentType equipment; final ValueChanged<EquipmentType> onEquipmentChanged;

const WorkoutsScreen({ super.key, required this.t, required this.equipment, required this.onEquipmentChanged, });

@override Widget build(BuildContext context) { final filtered = equipment == EquipmentType.all ? trinkExercises
:trinkExercises.where((e) => e.equipment == equipment).toList();

return ListView(
  padding: const EdgeInsets.all(16),
  children: [
    SectionTitle(title: t.workouts),
    const SizedBox(height: 10),
    Wrap(
      spacing: 8,
      runSpacing: 8,
      children: EquipmentType.values.map((e) {
        return ChoiceChip(
          label: Text(equipmentLabel(t, e)),
          selected: equipment == e,
          onSelected: (_) => onEquipmentChanged(e),
        );
      }).toList(),
    ),
    const SizedBox(height: 16),
    ...filtered.map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ExerciseCard(exercise: e),
        )),
  ],
);

} }

class ProgramsScreen extends StatelessWidget { final Strings t;

const ProgramsScreen({super.key, required this.t});

@override Widget build(BuildContext context) { return ListView( padding: const EdgeInsets.all(16), children: [ SectionTitle(title: t.programs), const SizedBox(height: 16), GridView.builder( shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: FakeData.programs.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: .95, ), itemBuilder: (context, index) { final p = FakeData.programs[index]; return ProgramCard(program: p); }, ), ], ); } }

class ProgressScreen extends StatelessWidget { final Strings t; final int waterGlasses; final VoidCallback onAddWater; final int dailySteps;

const ProgressScreen({ super.key, required this.t, required this.waterGlasses, required this.onAddWater, required this.dailySteps, });

@override Widget build(BuildContext context) { return ListView( padding: const EdgeInsets.all(16), children: [ SectionTitle(title: t.progress), const SizedBox(height: 16), DashboardTile(title: t.beforeAfter, subtitle: t.trackTransformation, icon: Icons.photo_library_outlined), const SizedBox(height: 12), DashboardTile(title: t.achievements, subtitle: 'First Workout • 7 Day Streak', icon: Icons.emoji_events_outlined), const SizedBox(height: 12), DashboardTile(title: t.waterTracker, subtitle: '${(waterGlasses * 0.25).toStringAsFixed(2)} L', icon: Icons.water_drop_outlined), const SizedBox(height: 12), FilledButton(onPressed: onAddWater, child: Text(t.addWaterGlass)), const SizedBox(height: 12), DashboardTile(title: t.stepCounter, subtitle: '$dailySteps ${t.steps}', icon: Icons.directions_walk_outlined), const SizedBox(height: 12), DashboardTile(title: t.healthIntegration, subtitle: 'Google Fit • Apple Health', icon: Icons.favorite_border), ], ); } }

class ProfileScreen extends StatelessWidget { final Strings t; final AppLang lang; final ValueChanged<AppLang> onLangChanged; final ThemeMode themeMode; final ValueChanged<ThemeMode> onThemeModeChanged;

const ProfileScreen({ super.key, required this.t, required this.lang, required this.onLangChanged, required this.themeMode, required this.onThemeModeChanged, });

@override Widget build(BuildContext context) { return ListView( padding: const EdgeInsets.all(16), children: [ SectionTitle(title: t.profile), const SizedBox(height: 16), DashboardTile(title: t.theme, subtitle: themeModeLabel(t, themeMode), icon: Icons.palette_outlined), const SizedBox(height: 10), Wrap( spacing: 8, children: [ ChoiceChip(label: Text(t.lightMode), selected: themeMode == ThemeMode.light, onSelected: () => onThemeModeChanged(ThemeMode.light)), ChoiceChip(label: Text(t.darkMode), selected: themeMode == ThemeMode.dark, onSelected: () => onThemeModeChanged(ThemeMode.dark)), ChoiceChip(label: Text(t.systemMode), selected: themeMode == ThemeMode.system, onSelected: (_) => onThemeModeChanged(ThemeMode.system)), ], ), const SizedBox(height: 16), DashboardTile(title: t.language, subtitle: langLabel(lang), icon: Icons.language_outlined), const SizedBox(height: 10), DropdownButtonFormField<AppLang>( value: lang, items: AppLang.values .map((e) => DropdownMenuItem<AppLang>( value: e, child: Text(langLabel(e)), )) .toList(), onChanged: (value) { if (value != null) onLangChanged(value); }, ), const SizedBox(height: 16), DashboardTile(title: t.bmiCalculator, subtitle: 'BMI = 24.1 • Normal', icon: Icons.monitor_weight_outlined), const SizedBox(height: 12), DashboardTile(title: t.widgetTitle, subtitle: t.todaysWorkout, icon: Icons.widgets_outlined), const SizedBox(height: 12), DashboardTile(title: t.adsPremium, subtitle: t.premiumAndAdsModel, icon: Icons.workspace_premium_outlined), ], ); } }

class StatCard extends StatelessWidget { final String title; final String value;

const StatCard({super.key, required this.title, required this.value});

@override Widget build(BuildContext context) { return Card( child: Padding( padding: const EdgeInsets.all(18), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)), ], ), ), ); } }

class DashboardTile extends StatelessWidget { final String title; final String subtitle; final IconData icon;

const DashboardTile({ super.key, required this.title, required this.subtitle, required this.icon, });

@override Widget build(BuildContext context) { return Card( child: Padding( padding: const EdgeInsets.all(16), child: Row( children: [ Container( width: 46, height: 46, decoration: BoxDecoration( color: AppTheme.primary.withOpacity(.12), borderRadius: BorderRadius.circular(14), ), child: Icon(icon, color: AppTheme.primary), ), const SizedBox(width: 12), Expanded( child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ Text(title, style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 4), Text(subtitle, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.7))), ], ), ), ], ), ), ); } }

class ExerciseCard extends StatelessWidget { final WorkoutExercise exercise;

const ExerciseCard({super.key, required this.exercise});

@override Widget build(BuildContext context) { return Card( child: Padding( padding: const EdgeInsets.all(16), child: Row( children: [ Container( width: 56, height: 56, decoration: BoxDecoration( gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.accent]), borderRadius: BorderRadius.circular(16), ), child: const Icon(Icons.play_circle_outline, color: Colors.white), ), const SizedBox(width: 12), Expanded( child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)), const SizedBox(height: 4), Text('${exercise.category} • ${exercise.seconds}s • ${exercise.calories} kcal'), const SizedBox(height: 4), Text(exercise.cue, style: const TextStyle(fontSize: 12)), ], ), ), ], ), ), ); } }

class ProgramCard extends StatelessWidget { final WorkoutProgram program;

const ProgramCard({super.key, required this.program});

@override Widget build(BuildContext context) { return Card( child: Padding( padding: const EdgeInsets.all(16), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ Row( children: [ Expanded( child: Text( program.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16), ), ), if (program.premium) const Icon(Icons.workspace_premium, color: Colors.amber), ], ), const SizedBox(height: 8), Text(program.subtitle), const Spacer(), Text('${program.days} days'), const SizedBox(height: 4), Text('${program.exercises.length} exercises'), ], ), ), ); } }

class PremiumCard extends StatelessWidget { const PremiumCard({super.key});

@override Widget build(BuildContext context) { return Card( child: Padding( padding: const EdgeInsets.all(18), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: const [ Text('Premium + Ads Model', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)), SizedBox(height: 10), Text('Monthly   179 TL'), Text('3 Months  399 TL'), Text('6 Months  599 TL'), Text('Yearly    899 TL ⭐'), ], ), ), ); } }

class SectionTitle extends StatelessWidget { final String title;

const SectionTitle({super.key, required this.title});

@override Widget build(BuildContext context) { return Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)); } }

String goalLabel(Strings t, GoalType g) { switch (g) { case GoalType.loseWeight: return t.loseWeight; case GoalType.buildMuscle: return t.buildMuscle; case GoalType.stayFit: return t.stayFit; case GoalType.improveCardio: return t.improveCardio; } }

String equipmentLabel(Strings t, EquipmentType e) { switch (e) { case EquipmentType.all: return t.all; case EquipmentType.noEquipment: return t.noEquipment; case EquipmentType.dumbbell: return t.dumbbell; case EquipmentType.resistanceBand: return t.resistanceBand; case EquipmentType.gym: return t.gymEquipment; } }

String themeModeLabel(Strings t, ThemeMode mode) { switch (mode) { case ThemeMode.light: return t.lightMode; case ThemeMode.dark: return t.darkMode; case ThemeMode.system: return t.systemMode; } }

String langLabel(AppLang lang) { switch (lang) { case AppLang.en: return 'English'; case AppLang.tr: return 'Türkçe'; case AppLang.de: return 'Deutsch'; case AppLang.fr: return 'Français'; case AppLang.es: return 'Español'; case AppLang.it: return 'Italiano'; case AppLang.pt: return 'Português'; case AppLang.ar: return 'العربية'; case AppLang.hi: return 'हिन्दी'; case AppLang.zh: return '中文'; case AppLang.ja: return '日本語'; case AppLang.ko: return '한국어'; } }
 
class Strings {
  final AppLang lang;
  Strings(this.lang);

  String get systemMode => _pick(
    'System Mode',
    'Sistem Modu',
    'Systemmodus',
    'Mode système',
    'Modo del sistema',
    'Modalità sistema',
    'Modo do sistema',
    'وضع النظام',
    'सिस्टम मोड',
    '系统模式',
    'システムモード',
    '시스템 모드',
  );

  String get lightMode => _pick(
    'Light Mode',
    'Açık Mod',
    'Heller Modus',
    'Mode clair',
    'Modo claro',
    'Modalità chiara',
    'Modo claro',
    'الوضع الفاتح',
    'लाइट मोड',
    '浅色模式',
    'ライトモード',
    '라이트 모드',
  );

  String get darkMode => _pick(
    'Dark Mode',
    'Koyu Mod',
    'Dunkler Modus',
    'Mode sombre',
    'Modo oscuro',
    'Modalità scura',
    'Modo escuro',
    'الوضع الداكن',
    'डार्क मोड',
    '深色模式',
    'ダークモード',
    '다크 모드',
  );
 String get all => _pick(
  'All',
  'Tümü',
  'Alle',
  'Tous',
  'Todos',
  'Tutti',
  'Todos',
  'الكل',
  'सभी',
  '全部',
  'すべて',
  '전체',
);

String get noEquipment => _pick(
  'No Equipment',
  'Ekipmansız',
  'Ohne Geräte',
  'Sans équipement',
  'Sin equipo',
  'Senza attrezzi',
  'Sem equipamento',
  'بدون معدات',
  'बिना उपकरण',
  '无器械',
  '器具なし',
  '장비 없음',
);

String get dumbbell => _pick(
  'Dumbbell',
  'Dambıl',
  'Hantel',
  'Haltère',
  'Mancuerna',
  'Manubrio',
  'Halter',
  'دمبل',
  'डम्बल',
  '哑铃',
  'ダンベル',
  '덤벨',
);

String get resistanceBand => _pick(
  'Resistance Band',
  'Direnç Bandı',
  'Widerstandsband',
  'Bande élastique',
  'Banda de resistencia',
  'Fascia elastica',
  'Faixa elástica',
  'شريط مقاومة',
  'रेज़िस्टेंस बैंड',
  '阻力带',
  'レジスタンスバンド',
  '저항 밴드',
);

String get gymEquipment => _pick(
  'Gym Equipment',
  'Spor Salonu Ekipmanı',
  'Fitnessgeräte',
  'Équipement de gym',
  'Equipo de gimnasio',
  'Attrezzi palestra',
  'Equipamento de academia',
  'معدات الجيم',
  'जिम उपकरण',
  '健身器械',
  'ジム器具',
  '헬스장 장비',
); 
String get home => _pick('Home', 'Ana Sayfa', 'Start', 'Accueil', 'Inicio', 'Home', 'Início', 'الرئيسية', 'होम', '首页', 'ホーム', '홈');

String get workouts => _pick('Workouts', 'Antrenmanlar', 'Workouts', 'Séances', 'Entrenos', 'Allenamenti', 'Treinos', 'التمارين', 'वर्कआउट', '训练', 'ワークアウト', '운동');

String get programs => _pick('Programs', 'Programlar', 'Programme', 'Programmes', 'Programas', 'Programmi', 'Programas', 'البرامج', 'प्रोग्राम', '计划', 'プログラム', '프로그램');

String get progress => _pick('Progress', 'İlerleme', 'Fortschritt', 'Progrès', 'Progreso', 'Progressi', 'Progresso', 'التقدم', 'प्रगति', '进度', '進捗', '진행');

String get profile => _pick('Profile', 'Profil', 'Profil', 'Profil', 'Perfil', 'Profilo', 'Perfil', 'الملف الشخصي', 'प्रोफाइल', '我的', 'プロフィール', '프로필');
String get improveCardio => _pick(
  'Improve Cardio',
  'Kardiyoyu Geliştir',
  'Kondition verbessern',
  'Améliorer le cardio',
  'Mejorar cardio',
  'Migliora il cardio',
  'Melhorar cardio',
  'تحسين الكارديو',
  'कार्डियो सुधारें',
  '提升心肺功能',
  '有酸素能力を向上',
  '유산소 능력 향상',
);
  String get loseWeight => _pick(
  'Lose Weight',
  'Kilo Ver',
  'Gewicht verlieren',
  'Perdre du poids',
  'Perder peso',
  'Perdere peso',
  'Perder peso',
  'إنقاص الوزن',
  'वजन घटाएं',
  '减肥',
  '減量',
  '체중 감량',
);

String get buildMuscle => _pick(
  'Build Muscle',
  'Kas Yap',
  'Muskeln aufbauen',
  'Développer les muscles',
  'Ganar músculo',
  'Sviluppare muscoli',
  'Ganhar músculos',
  'بناء العضلات',
  'मांसपेशियां बनाएं',
  '增肌',
  '筋肉をつける',
  '근육 만들기',
);

String get stayFit => _pick(
  'Stay Fit',
  'Formda Kal',
  'Fit bleiben',
  'Rester en forme',
  'Mantenerse en forma',
  'Rimani in forma',
  'Manter a forma',
  'ابقَ لائقًا',
  'फिट रहें',
  '保持健康',
  '健康を保つ',
  '몸매 유지',
);
String get appSubtitle => _pick(
  'Home Workout, Weight Loss & Fitness',
  'Evde Egzersiz, Kilo Verme ve Fitness',
  'Home Training, Gewichtsverlust & Fitness',
  'Entraînement à domicile, perte de poids et fitness',
  'Entrenamiento en casa, pérdida de peso y fitness',
  'Allenamento a casa, perdita di peso e fitness',
  'Treino em casa, perda de peso e fitness',
  'تمارين منزلية، خسارة الوزن واللياقة',
  'होम वर्कआउट, वजन घटाना और फिटनेस',
  '居家锻炼、减重与健身',
  'ホームワークアウト、減量とフィットネス',
  '홈트레이닝, 체중 감량 및 피트니스',
);
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
  return en;
}
