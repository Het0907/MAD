import 'package:flutter/material.dart';
import '../utils/audio_service.dart';
import '../widgets/animated_button.dart';

class QuizScreen extends StatefulWidget {
  final bool isAlphabet;
  
  const QuizScreen({
    super.key,
    required this.isAlphabet,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _answered = false;
  String? _selectedAnswer;

  final List<Map<String, dynamic>> _alphabetQuestions = [
    {
      'question': 'Which letter comes after A?',
      'options': ['B', 'C', 'D', 'Z'],
      'correct': 'B',
      'emoji': '🅰️',
    },
    {
      'question': 'What does C stand for?',
      'options': ['Cat', 'Dog', 'Bird', 'Fish'],
      'correct': 'Cat',
      'emoji': '🐱',
    },
    {
      'question': 'Which letter comes before Z?',
      'options': ['X', 'Y', 'W', 'A'],
      'correct': 'Y',
      'emoji': '🔤',
    },
  ];

  final List<Map<String, dynamic>> _numbersQuestions = [
    {
      'question': 'What comes after 5?',
      'options': ['4', '6', '7', '3'],
      'correct': '6',
      'emoji': '5️⃣',
    },
    {
      'question': 'How many fingers do you have?',
      'options': ['8', '9', '10', '11'],
      'correct': '10',
      'emoji': '✋',
    },
    {
      'question': 'What comes before 3?',
      'options': ['1', '2', '4', '5'],
      'correct': '2',
      'emoji': '3️⃣',
    },
  ];

  List<Map<String, dynamic>> get _questions =>
      widget.isAlphabet ? _alphabetQuestions : _numbersQuestions;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectAnswer(String answer) async {
    if (_answered) return;

    setState(() {
      _selectedAnswer = answer;
      _answered = true;
    });

    final isCorrect = answer == _questions[_currentQuestionIndex]['correct'];
    
    if (isCorrect) {
      setState(() {
        _score++;
      });
      await AudioService.speak('Correct! Well done!');
    } else {
      await AudioService.speak('Oops! Try again next time!');
    }

    await Future.delayed(const Duration(milliseconds: 1500));
    _nextQuestion();
  }

  void _nextQuestion() async {
    if (_currentQuestionIndex < _questions.length - 1) {
      await _animationController.forward();
      setState(() {
        _currentQuestionIndex++;
        _answered = false;
        _selectedAnswer = null;
      });
      await _animationController.reverse();
    } else {
      _showResults();
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          '🎉 Quiz Complete!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your Score: $_score/${_questions.length}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              _score == _questions.length
                  ? '🌟 Perfect! You\'re amazing! 🌟'
                  : _score >= _questions.length / 2
                      ? '👏 Great job! Keep learning! 👏'
                      : '💪 Good try! Practice more! 💪',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          AnimatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Back to Home',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isAlphabet ? 'ABC Quiz' : '123 Quiz',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: widget.isAlphabet
            ? const Color(0xFFFF6B6B)
            : const Color(0xFF4ECDC4),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: widget.isAlphabet
                ? [const Color(0xFFFF6B6B), const Color(0xFFFFE66D)]
                : [const Color(0xFF4ECDC4), const Color(0xFF44A08D)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(-1.0, 0.0),
              ).animate(_slideAnimation),
              child: Column(
                children: [
                  // Progress indicator
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Score: $_score',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Question
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
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
                    child: Column(
                      children: [
                        Text(
                          question['emoji'],
                          style: const TextStyle(fontSize: 50),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          question['question'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Answer options
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 2,
                      ),
                      itemCount: question['options'].length,
                      itemBuilder: (context, index) {
                        final option = question['options'][index];
                        final isSelected = _selectedAnswer == option;
                        final isCorrect = option == question['correct'];
                        
                        Color backgroundColor = Colors.white;
                        Color borderColor = Colors.grey.shade300;
                        
                        if (_answered) {
                          if (isCorrect) {
                            backgroundColor = Colors.green.shade100;
                            borderColor = Colors.green;
                          } else if (isSelected && !isCorrect) {
                            backgroundColor = Colors.red.shade100;
                            borderColor = Colors.red;
                          }
                        }
                        
                        return AnimatedButton(
                          onPressed: () => _selectAnswer(option),
                          child: Container(
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: borderColor, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                option,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
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