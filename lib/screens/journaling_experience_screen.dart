import 'package:flutter/material.dart';
import 'secondary_goals_screen.dart';

class JournalingExperienceScreen extends StatefulWidget {
  const JournalingExperienceScreen({super.key});

  @override
  State<JournalingExperienceScreen> createState() =>
      _JournalingExperienceScreenState();
}

class _JournalingExperienceScreenState
    extends State<JournalingExperienceScreen> {
  final List<String> options = [
    "Yes, I have experience",
    "Yes, but I would like to learn more",
    "Yes, a long time ago",
    "No, I have never tried",
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5B3B8C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 10),

              /// TOP BAR
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SecondaryGoalsScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              /// INDICATOR
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _Indicator(active: true),
                  _Indicator(active: true),
                  _Indicator(active: false),
                ],
              ),

              const SizedBox(height: 32),

              const Text(
                "Have You Tried Journaling ?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final selected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => selectedIndex = index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFFB27BCB)
                              : const Color(0xFF9E6FB3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            options[index],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// NEXT
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: selectedIndex == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SecondaryGoalsScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD6E8),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Next",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  final bool active;
  const _Indicator({required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 24 : 14,
      height: 4,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white30,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
