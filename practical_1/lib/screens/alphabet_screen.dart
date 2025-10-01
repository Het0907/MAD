import 'package:flutter/material.dart';
import '../utils/audio_service.dart';
import '../widgets/letter_card.dart';
import 'quiz_screen.dart';

class AlphabetScreen extends StatefulWidget {
  const AlphabetScreen({super.key});

  @override
  State<AlphabetScreen> createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final List<String> _alphabet = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

  final Map<String, String> _words = {
    'A': 'Apple 🍎',
    'B': 'Ball ⚽',
    'C': 'Cat 🐱',
    'D': 'Dog 🐶',
    'E': 'Elephant 🐘',
    'F': 'Fish 🐟',
    'G': 'Giraffe 🦒',
    'H': 'Horse 🐴',
    'I': 'Ice cream 🍦',
    'J': 'Juice 🧃',
    'K': 'Kite 🪁',
    'L': 'Lion 🦁',
    'M': 'Monkey 🐵',
    'N': 'Nest 🪺',
    'O': 'Orange 🍊',
    'P': 'Penguin 🐧',
    'Q': 'Queen 👸',
    'R': 'Rainbow 🌈',
    'S': 'Sun ☀️',
    'T': 'Tiger 🐅',
    'U': 'Umbrella ☂️',
    'V': 'Van 🚐',
    'W': 'Whale 🐋',
    'X': 'Xylophone 🎵',
    'Y': 'Yacht ⛵',
    'Z': 'Zebra 🦓',
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Learn ABC',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFFF6B6B),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.quiz),
            onPressed: () async {
              await AudioService.speak('Let\'s take a quiz!');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuizScreen(isAlphabet: true),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: () {
              AudioService.speak('This is the alphabet learning page. Tap any letter to hear it!');
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF6B6B),
              Color(0xFFFFE66D),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '🔤',
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Tap a letter to hear it!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4A90E2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Alphabet Grid
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: _alphabet.length,
                      itemBuilder: (context, index) {
                        return LetterCard(
                          letter: _alphabet[index],
                          word: _words[_alphabet[index]]!,
                          delay: Duration(milliseconds: index * 50),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}