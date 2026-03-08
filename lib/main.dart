import 'dart:async';
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
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class Exercise {
  final String name;
  final String image;
  final int duration;
  final int calories;

  Exercise({
    required this.name,
    required this.image,
    required this.duration,
    required this.calories,
  });
}

List<Exercise> exercises = [
  Exercise(
    name: "Jumping Jacks",
    image: "assets/exercises/jumping.jpg",
    duration: 60,
    calories: 27,
  ),
  Exercise(
    name: "Push Up",
    image: "assets/exercises/pushup.jpg",
    duration: 45,
    calories: 18,
  ),
  Exercise(
    name: "Squat",
    image: "assets/exercises/squat.jpg",
    duration: 50,
    calories: 22,
  ),
  Exercise(
    name: "Plank",
    image: "assets/exercises/plank.jpg",
    duration: 40,
    calories: 14,
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Trink Fit"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Text(
            "AI Koç Önerisi",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              "Bugün 20 dakikalık kardiyo ve core egzersizi öneriyorum.",
              style: TextStyle(fontSize: 16),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Egzersizler",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: exercises.length,
              itemBuilder: (context, index) {

                final exercise = exercises[index];

                return GestureDetector(
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExercisePage(exercise: exercise),
                      ),
                    );

                  },
                  child: Container(
                    width: 250,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black12,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          child: Image.asset(
                            exercise.image,
                            height: 170,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                exercise.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                "${exercise.duration} sn",
                              ),

                              Text(
                                "${exercise.calories} kcal",
                              ),

                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [

                Text(
                  "Kilo Takibi",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 10),

                Text("Başlangıç: 84 kg"),

                Text("Hedef: 78 kg"),

                SizedBox(height: 10),

                LinearProgressIndicator(
                  value: 0.45,
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}

class ExercisePage extends StatefulWidget {

  final Exercise exercise;

  const ExercisePage({super.key, required this.exercise});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {

  late int remaining;

  Timer? timer;

  bool running = false;

  @override
  void initState() {
    super.initState();
    remaining = widget.exercise.duration;
  }

  void startTimer() {

    if (running) return;

    running = true;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) {

        if (remaining > 0) {
          setState(() {
            remaining--;
          });
        } else {
          t.cancel();
        }

      },
    );

  }

  void resetTimer() {

    timer?.cancel();

    setState(() {
      remaining = widget.exercise.duration;
      running = false;
    });

  }

  String formatTime(int sec) {

    final m = sec ~/ 60;

    final s = sec % 60;

    return "$m:${s.toString().padLeft(2, '0')}";

  }

  @override
  Widget build(BuildContext context) {

    final exercise = widget.exercise;

    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(

          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                exercise.image,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              exercise.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text("${exercise.duration} saniye"),

            Text("${exercise.calories} kcal"),

            const SizedBox(height: 30),

            Text(
              formatTime(remaining),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    onPressed: startTimer,
                    child: const Text("Başlat"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: resetTimer,
                    child: const Text("Sıfırla"),
                  ),
                ),

              ],
            )

          ],
        ),
      ),
    );
  }
}
