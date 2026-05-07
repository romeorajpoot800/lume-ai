import 'package:flutter/material.dart';
import 'goals_screens.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6A1B9A),
              Color(0xFF8E24AA),
              Color(0xFF4A148C),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Let your thoughts flow,\nLet your mind glow.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 40),

              _button(
                text: "Sign Up",
                filled: false,
                onTap: () {},
              ),

              const SizedBox(height: 16),

              _button(
                text: "Log In",
                filled: true,
                onTap: () {},
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GoalsScreen(), // ❌ NO const here
                    ),
                  );
                },
                child: const Text(
                  "Continue without Registration",
                  style: TextStyle(color: Colors.white70),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _button({
    required String text,
    required bool filled,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 260,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor:
          filled ? const Color(0xFFFFD6E8) : Colors.transparent,
          foregroundColor: filled ? Colors.black : Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: filled
                ? BorderSide.none
                : const BorderSide(color: Colors.white),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
