import 'package:flutter/material.dart';
import '../utils/audio_service.dart';
import '../widgets/number_card.dart';
import 'quiz_screen.dart';

class NumbersScreen extends StatefulWidget {
  const NumbersScreen({super.key});

  @override
  State<NumbersScreen> createState() => _NumbersScreenState();
}

class _NumbersScreenState extends State<NumbersScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final List<int> _numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  final Map<int, String> _numberWords = {
    1: 'One 1️⃣',
    2: 'Two 2️⃣',
    3: 'Three 3️⃣',
    4: 'Four 4️⃣',
    5: 'Five 5️⃣',
    6: 'Six 6️⃣',
    7: 'Seven 7️⃣',
    8: 'Eight 8️⃣',
    9: 'Nine 9️⃣',
    10: 'Ten 🔟',
  };

  final Map<int, String> _examples = {
    1: '🍎',
    2: '🍎🍎',
    3: '🍎🍎🍎',
    4: '🍎🍎🍎🍎',
    5: '🍎🍎🍎🍎🍎',
    6: '⭐⭐⭐⭐⭐⭐',
    7: '⭐⭐⭐⭐⭐⭐⭐',
    8: '⭐⭐⭐⭐⭐⭐⭐⭐',
    9: '⭐⭐⭐⭐⭐⭐⭐⭐⭐',
    10: '🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟',
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
          'Learn 123',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4ECDC4),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.quiz),
            onPressed: () async {
              await AudioService.speak('Let\'s take a numbers quiz!');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuizScreen(isAlphabet: false),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: () {
              AudioService.speak('This is the numbers learning page. Tap any number to hear it!');
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
              Color(0xFF4ECDC4),
              Color(0xFF44A08D),
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
                          '🔢',
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Tap a number to count!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4ECDC4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Numbers Grid
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: _numbers.length,
                      itemBuilder: (context, index) {
                        final number = _numbers[index];
                        return NumberCard(
                          number: number,
                          word: _numberWords[number]!,
                          example: _examples[number]!,
                          delay: Duration(milliseconds: index * 100),
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