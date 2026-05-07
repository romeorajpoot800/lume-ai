import 'package:flutter/material.dart';
import 'today.screen.dart';

class SecondaryGoalsScreen extends StatefulWidget {
  const SecondaryGoalsScreen({super.key});

  @override
  State<SecondaryGoalsScreen> createState() => _SecondaryGoalsScreenState();
}

class _SecondaryGoalsScreenState extends State<SecondaryGoalsScreen> {
  final List<String> goals = [
    'Heal childhood trauma',
    'Quit a bad habit',
    'Self-reflection',
    'Lose weight',
    'Improve relationships',
  ];

  final List<bool> selected = List.generate(5, (_) => false);

  bool get hasSelection => selected.any((e) => e);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A3FA0),
      body: SafeArea(
        child: Column(
          children: [

            /// ─── TOP BAR ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),

                  Row(
                    children: const [
                      _Indicator(),
                      SizedBox(width: 6),
                      _Indicator(),
                      SizedBox(width: 6),
                      _Indicator(),
                    ],
                  ),

                  TextButton(
                    onPressed: _goNext,
                    child: const Text('Skip',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            /// ─── TITLE (CENTERED LIKE OTHER SCREENS) ─────────────
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Anything Else You Would Like To Achieve?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 28),

            /// ─── GOALS LIST ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: List.generate(goals.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected[index] = !selected[index];
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 54,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selected[index]
                              ? const Color(0xFFB78BCB)
                              : const Color(0xFF9E6FB3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          goals[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const Spacer(),

            /// ─── NEXT BUTTON (DISABLED UNTIL SELECTED) ──────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: hasSelection ? _goNext : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD9E6),
                    disabledBackgroundColor:
                    const Color(0xFFFFD9E6).withOpacity(0.4),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Color(0xFF6A3FA0),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goNext() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => TodayScreen()),
    );
  }
}

/// ─── INDICATOR ───────────────────────────────────────────────
class _Indicator extends StatelessWidget {
  const _Indicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
