import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MathLearningApp());
}

class MathLearningApp extends StatelessWidget {
  const MathLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Learning for Kids',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        fontFamily: 'Arial',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6B73FF),
              Color(0xFF9C27B0),
              Color(0xFFE91E63),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Title
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      '🎓 Math Learning',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Learn math with fun!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Math Operation Cards
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      _buildMathCard(
                        context,
                        'Addition',
                        '➕',
                        Colors.green,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MathGameScreen(operation: MathOperation.addition),
                          ),
                        ),
                      ),
                      _buildMathCard(
                        context,
                        'Subtraction',
                        '➖',
                        Colors.orange,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MathGameScreen(operation: MathOperation.subtraction),
                          ),
                        ),
                      ),
                      _buildMathCard(
                        context,
                        'Multiplication',
                        '✖️',
                        Colors.red,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MathGameScreen(operation: MathOperation.multiplication),
                          ),
                        ),
                      ),
                      _buildMathCard(
                        context,
                        'Division',
                        '➗',
                        Colors.blue,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MathGameScreen(operation: MathOperation.division),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMathCard(BuildContext context, String title, String emoji, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum MathOperation { addition, subtraction, multiplication, division }

class MathGameScreen extends StatefulWidget {
  final MathOperation operation;

  const MathGameScreen({super.key, required this.operation});

  @override
  State<MathGameScreen> createState() => _MathGameScreenState();
}

class _MathGameScreenState extends State<MathGameScreen> with TickerProviderStateMixin {
  int num1 = 0;
  int num2 = 0;
  int correctAnswer = 0;
  int userAnswer = 0;
  int score = 0;
  int questionCount = 0;
  List<int> answerOptions = [];
  bool showResult = false;
  bool isCorrect = false;
  
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late AnimationController _scoreAnimationController;
  late Animation<double> _scoreScaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    
    _scoreAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scoreScaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _scoreAnimationController, curve: Curves.elasticOut),
    );
    
    _generateQuestion();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scoreAnimationController.dispose();
    super.dispose();
  }

  void _generateQuestion() {
    final random = Random();
    
    switch (widget.operation) {
      case MathOperation.addition:
        num1 = random.nextInt(50) + 1;
        num2 = random.nextInt(50) + 1;
        correctAnswer = num1 + num2;
        break;
      case MathOperation.subtraction:
        num1 = random.nextInt(50) + 20;
        num2 = random.nextInt(num1);
        correctAnswer = num1 - num2;
        break;
      case MathOperation.multiplication:
        num1 = random.nextInt(12) + 1;
        num2 = random.nextInt(12) + 1;
        correctAnswer = num1 * num2;
        break;
      case MathOperation.division:
        correctAnswer = random.nextInt(12) + 1;
        num2 = random.nextInt(12) + 1;
        num1 = correctAnswer * num2;
        break;
    }
    
    _generateAnswerOptions();
    setState(() {
      showResult = false;
      userAnswer = 0;
    });
  }

  void _generateAnswerOptions() {
    final random = Random();
    answerOptions = [correctAnswer];
    
    while (answerOptions.length < 4) {
      int wrongAnswer;
      switch (widget.operation) {
        case MathOperation.addition:
          wrongAnswer = correctAnswer + random.nextInt(20) - 10;
          break;
        case MathOperation.subtraction:
          wrongAnswer = correctAnswer + random.nextInt(20) - 10;
          break;
        case MathOperation.multiplication:
          wrongAnswer = correctAnswer + random.nextInt(30) - 15;
          break;
        case MathOperation.division:
          wrongAnswer = correctAnswer + random.nextInt(10) - 5;
          break;
      }
      
      if (wrongAnswer > 0 && !answerOptions.contains(wrongAnswer)) {
        answerOptions.add(wrongAnswer);
      }
    }
    
    answerOptions.shuffle();
  }

  void _checkAnswer(int selectedAnswer) {
    setState(() {
      userAnswer = selectedAnswer;
      isCorrect = selectedAnswer == correctAnswer;
      showResult = true;
      questionCount++;
      
      if (isCorrect) {
        score++;
        _scoreAnimationController.forward().then((_) {
          _scoreAnimationController.reverse();
        });
      }
    });
    
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (questionCount < 10) {
        _generateQuestion();
      } else {
        _showFinalScore();
      }
    });
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('🎉 Great Job!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your Score: $score/10',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                score >= 8
                    ? 'Excellent! 🌟'
                    : score >= 6
                        ? 'Good work! 👍'
                        : 'Keep practicing! 💪',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  score = 0;
                  questionCount = 0;
                });
                _generateQuestion();
              },
              child: const Text('Play Again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Home'),
            ),
          ],
        );
      },
    );
  }

  String _getOperationSymbol() {
    switch (widget.operation) {
      case MathOperation.addition:
        return '+';
      case MathOperation.subtraction:
        return '-';
      case MathOperation.multiplication:
        return '×';
      case MathOperation.division:
        return '÷';
    }
  }

  String _getOperationName() {
    switch (widget.operation) {
      case MathOperation.addition:
        return 'Addition';
      case MathOperation.subtraction:
        return 'Subtraction';
      case MathOperation.multiplication:
        return 'Multiplication';
      case MathOperation.division:
        return 'Division';
    }
  }

  Color _getOperationColor() {
    switch (widget.operation) {
      case MathOperation.addition:
        return Colors.green;
      case MathOperation.subtraction:
        return Colors.orange;
      case MathOperation.multiplication:
        return Colors.red;
      case MathOperation.division:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_getOperationName()} Practice'),
        backgroundColor: _getOperationColor(),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedBuilder(
              animation: _scoreScaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scoreScaleAnimation.value,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Score: $score',
                      style: TextStyle(
                        color: _getOperationColor(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _getOperationColor().withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Progress indicator
                LinearProgressIndicator(
                  value: questionCount / 10,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(_getOperationColor()),
                ),
                const SizedBox(height: 10),
                Text(
                  'Question ${questionCount + 1} of 10',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                
                // Question
                AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              '$num1 ${_getOperationSymbol()} $num2 = ?',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (showResult) ...[
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: isCorrect ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      isCorrect ? Icons.check_circle : Icons.cancel,
                                      color: isCorrect ? Colors.green : Colors.red,
                                      size: 30,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      isCorrect ? 'Correct! 🎉' : 'Correct answer: $correctAnswer',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: isCorrect ? Colors.green : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 40),
                
                // Answer options
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    children: answerOptions.map((answer) {
                      return GestureDetector(
                        onTap: showResult ? null : () => _checkAnswer(answer),
                        child: Container(
                          decoration: BoxDecoration(
                            color: showResult
                                ? (answer == correctAnswer
                                    ? Colors.green.withOpacity(0.8)
                                    : answer == userAnswer && !isCorrect
                                        ? Colors.red.withOpacity(0.8)
                                        : Colors.grey[300])
                                : _getOperationColor().withOpacity(0.8),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              answer.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
