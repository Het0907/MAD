import 'package:flutter/material.dart';

void main() {
  runApp(const ITQuizApp());
}

class ITQuizApp extends StatelessWidget {
  const ITQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IT Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SubjectSelectionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Data Models
class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}

class QuizData {
  static Map<String, List<Question>> subjects = {
    'Programming': [
      Question(
        question: 'Which of the following is not a programming language?',
        options: ['Java', 'Python', 'HTML', 'C++'],
        correctAnswerIndex: 2,
        explanation: 'HTML is a markup language, not a programming language.',
      ),
      Question(
        question: 'What does OOP stand for?',
        options: ['Object-Oriented Programming', 'Open-Oriented Programming', 'Object-Only Programming', 'Online-Only Programming'],
        correctAnswerIndex: 0,
        explanation: 'OOP stands for Object-Oriented Programming.',
      ),
      Question(
        question: 'Which language is primarily used for web development?',
        options: ['C++', 'JavaScript', 'Assembly', 'COBOL'],
        correctAnswerIndex: 1,
        explanation: 'JavaScript is the primary language for web development.',
      ),
      Question(
        question: 'What is the time complexity of binary search?',
        options: ['O(n)', 'O(log n)', 'O(n²)', 'O(1)'],
        correctAnswerIndex: 1,
        explanation: 'Binary search has O(log n) time complexity.',
      ),
      Question(
        question: 'Which of these is a Python web framework?',
        options: ['React', 'Angular', 'Django', 'Vue'],
        correctAnswerIndex: 2,
        explanation: 'Django is a popular Python web framework.',
      ),
    ],
    'Database': [
      Question(
        question: 'What does SQL stand for?',
        options: ['Structured Query Language', 'Simple Query Language', 'Standard Query Language', 'System Query Language'],
        correctAnswerIndex: 0,
        explanation: 'SQL stands for Structured Query Language.',
      ),
      Question(
        question: 'Which of the following is a NoSQL database?',
        options: ['MySQL', 'PostgreSQL', 'MongoDB', 'Oracle'],
        correctAnswerIndex: 2,
        explanation: 'MongoDB is a popular NoSQL database.',
      ),
      Question(
        question: 'What is a primary key?',
        options: ['A key that opens the database', 'A unique identifier for a record', 'A key used for encryption', 'A key for indexing'],
        correctAnswerIndex: 1,
        explanation: 'A primary key uniquely identifies each record in a table.',
      ),
      Question(
        question: 'Which SQL command is used to retrieve data?',
        options: ['INSERT', 'UPDATE', 'SELECT', 'DELETE'],
        correctAnswerIndex: 2,
        explanation: 'SELECT command is used to retrieve data from database.',
      ),
      Question(
        question: 'What does ACID stand for in databases?',
        options: ['Atomicity, Consistency, Isolation, Durability', 'Accuracy, Consistency, Integrity, Data', 'Atomic, Concurrent, Independent, Durable', 'Access, Control, Identity, Design'],
        correctAnswerIndex: 0,
        explanation: 'ACID stands for Atomicity, Consistency, Isolation, Durability.',
      ),
    ],
    'Networking': [
      Question(
        question: 'What does HTTP stand for?',
        options: ['HyperText Transfer Protocol', 'High Transfer Text Protocol', 'HyperText Transport Protocol', 'High Text Transfer Protocol'],
        correctAnswerIndex: 0,
        explanation: 'HTTP stands for HyperText Transfer Protocol.',
      ),
      Question(
        question: 'Which layer of OSI model handles routing?',
        options: ['Physical', 'Data Link', 'Network', 'Transport'],
        correctAnswerIndex: 2,
        explanation: 'The Network layer (Layer 3) handles routing.',
      ),
      Question(
        question: 'What is the default port for HTTPS?',
        options: ['80', '443', '8080', '21'],
        correctAnswerIndex: 1,
        explanation: 'HTTPS uses port 443 by default.',
      ),
      Question(
        question: 'Which protocol is used for email transfer?',
        options: ['HTTP', 'FTP', 'SMTP', 'SNMP'],
        correctAnswerIndex: 2,
        explanation: 'SMTP (Simple Mail Transfer Protocol) is used for email transfer.',
      ),
      Question(
        question: 'What does DNS stand for?',
        options: ['Domain Name System', 'Data Network Service', 'Dynamic Name Server', 'Digital Network Security'],
        correctAnswerIndex: 0,
        explanation: 'DNS stands for Domain Name System.',
      ),
    ],
    'Operating Systems': [
      Question(
        question: 'Which of the following is not an operating system?',
        options: ['Windows', 'Linux', 'macOS', 'Microsoft Office'],
        correctAnswerIndex: 3,
        explanation: 'Microsoft Office is an application suite, not an operating system.',
      ),
      Question(
        question: 'What is a process in operating systems?',
        options: ['A running program', 'A file on disk', 'A user account', 'A hardware component'],
        correctAnswerIndex: 0,
        explanation: 'A process is a running instance of a program.',
      ),
      Question(
        question: 'Which scheduling algorithm gives priority to shorter jobs?',
        options: ['FCFS', 'Round Robin', 'SJF', 'Priority'],
        correctAnswerIndex: 2,
        explanation: 'SJF (Shortest Job First) gives priority to shorter jobs.',
      ),
      Question(
        question: 'What is virtual memory?',
        options: ['Memory that doesn\'t exist', 'RAM expansion technique', 'Cache memory', 'ROM memory'],
        correctAnswerIndex: 1,
        explanation: 'Virtual memory is a technique to expand available RAM using disk space.',
      ),
      Question(
        question: 'Which command is used to list files in Linux?',
        options: ['dir', 'list', 'ls', 'show'],
        correctAnswerIndex: 2,
        explanation: 'The "ls" command is used to list files in Linux.',
      ),
    ],
  };
}

// Subject Selection Screen
class SubjectSelectionScreen extends StatelessWidget {
  const SubjectSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IT Quiz - Select Subject',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.blue.shade300],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Choose Your Subject',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Test your knowledge in IT fundamentals',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: QuizData.subjects.keys.length,
                  itemBuilder: (context, index) {
                    String subject = QuizData.subjects.keys.elementAt(index);
                    
                    return SubjectCard(
                      subject: subject,
                      icon: _getSubjectIcon(subject),
                      color: _getSubjectColor(index),
                      questionCount: QuizData.subjects[subject]!.length,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(subject: subject),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getSubjectIcon(String subject) {
    switch (subject) {
      case 'Programming':
        return Icons.code;
      case 'Database':
        return Icons.storage;
      case 'Networking':
        return Icons.network_wifi;
      case 'Operating Systems':
        return Icons.computer;
      default:
        return Icons.quiz;
    }
  }

  Color _getSubjectColor(int index) {
    List<Color> colors = [
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.red,
    ];
    return colors[index % colors.length];
  }
}

// Quiz Screen
class QuizScreen extends StatefulWidget {
  final String subject;

  const QuizScreen({super.key, required this.subject});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int? selectedAnswer;
  int score = 0;
  bool showResult = false;
  List<int> userAnswers = [];
  bool isAnswerSelected = false;
  bool showExplanation = false;

  List<Question> get questions => QuizData.subjects[widget.subject]!;

  @override
  void initState() {
    super.initState();
    userAnswers = List.filled(questions.length, -1);
  }

  void _selectAnswer(int answerIndex) {
    setState(() {
      selectedAnswer = answerIndex;
      isAnswerSelected = true;
    });
  }

  void _nextQuestion() {
    if (selectedAnswer != null) {
      userAnswers[currentQuestionIndex] = selectedAnswer!;
      
      if (selectedAnswer == questions[currentQuestionIndex].correctAnswerIndex) {
        score++;
      }

      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          selectedAnswer = null;
          isAnswerSelected = false;
          showExplanation = false;
        });
      } else {
        setState(() {
          showResult = true;
        });
      }
    }
  }

  void _showExplanation() {
    setState(() {
      showExplanation = true;
    });
  }

  void _restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      selectedAnswer = null;
      score = 0;
      showResult = false;
      userAnswers = List.filled(questions.length, -1);
      isAnswerSelected = false;
      showExplanation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showResult) {
      return ResultScreen(
        subject: widget.subject,
        score: score,
        totalQuestions: questions.length,
        questions: questions,
        userAnswers: userAnswers,
        onRestart: _restartQuiz,
      );
    }

    Question currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.subject} Quiz',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.blue.shade300],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress indicator
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question ${currentQuestionIndex + 1}/${questions.length}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Score: $score',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: (currentQuestionIndex + 1) / questions.length,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              
              // Question
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  currentQuestion.question,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              // Options
              Expanded(
                child: ListView.builder(
                  itemCount: currentQuestion.options.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedAnswer == index;
                    bool isCorrect = index == currentQuestion.correctAnswerIndex;
                    bool showAnswer = isAnswerSelected;

                    Color getOptionColor() {
                      if (!showAnswer) {
                        return isSelected ? Colors.blue.shade100 : Colors.white;
                      }
                      if (isCorrect) {
                        return Colors.green.shade100;
                      }
                      if (isSelected && !isCorrect) {
                        return Colors.red.shade100;
                      }
                      return Colors.white;
                    }

                    Color getBorderColor() {
                      if (!showAnswer) {
                        return isSelected ? Colors.blue : Colors.grey.shade300;
                      }
                      if (isCorrect) {
                        return Colors.green;
                      }
                      if (isSelected && !isCorrect) {
                        return Colors.red;
                      }
                      return Colors.grey.shade300;
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: isAnswerSelected ? null : () => _selectAnswer(index),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: getOptionColor(),
                            border: Border.all(color: getBorderColor(), width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: getBorderColor(),
                                ),
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + index), // A, B, C, D
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  currentQuestion.options[index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (showAnswer && isCorrect)
                                const Icon(Icons.check_circle, color: Colors.green),
                              if (showAnswer && isSelected && !isCorrect)
                                const Icon(Icons.cancel, color: Colors.red),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Explanation
              if (showExplanation)
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Explanation:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentQuestion.explanation,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              
              // Action buttons
              Row(
                children: [
                  if (isAnswerSelected && !showExplanation)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _showExplanation,
                        icon: const Icon(Icons.info_outline),
                        label: const Text('Show Explanation'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  if (isAnswerSelected && !showExplanation)
                    const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isAnswerSelected ? _nextQuestion : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        currentQuestionIndex == questions.length - 1 ? 'Finish Quiz' : 'Next Question',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Result Screen
class ResultScreen extends StatelessWidget {
  final String subject;
  final int score;
  final int totalQuestions;
  final List<Question> questions;
  final List<int> userAnswers;
  final VoidCallback onRestart;

  const ResultScreen({
    super.key,
    required this.subject,
    required this.score,
    required this.totalQuestions,
    required this.questions,
    required this.userAnswers,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = (score / totalQuestions) * 100;
    String grade = _getGrade(percentage);
    Color gradeColor = _getGradeColor(percentage);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz Results',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.blue.shade300],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Result Summary
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
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      percentage >= 70 ? Icons.emoji_events : Icons.sentiment_satisfied,
                      size: 80,
                      color: gradeColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Quiz Completed!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subject,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildResultStat('Score', '$score/$totalQuestions', Colors.blue),
                        _buildResultStat('Percentage', '${percentage.toStringAsFixed(1)}%', Colors.green),
                        _buildResultStat('Grade', grade, gradeColor),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewScreen(
                              subject: subject,
                              questions: questions,
                              userAnswers: userAnswers,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.rate_review),
                      label: const Text('Review Answers'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onRestart,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retake Quiz'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('Back to Subjects'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  String _getGrade(double percentage) {
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B';
    if (percentage >= 60) return 'C';
    if (percentage >= 50) return 'D';
    return 'F';
  }

  Color _getGradeColor(double percentage) {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.orange;
    return Colors.red;
  }
}

// Review Screen
class ReviewScreen extends StatelessWidget {
  final String subject;
  final List<Question> questions;
  final List<int> userAnswers;

  const ReviewScreen({
    super.key,
    required this.subject,
    required this.questions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$subject - Review',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.blue.shade300],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            Question question = questions[index];
            int userAnswer = userAnswers[index];
            bool isCorrect = userAnswer == question.correctAnswerIndex;

            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isCorrect ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Q${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isCorrect ? Icons.check_circle : Icons.cancel,
                        color: isCorrect ? Colors.green : Colors.red,
                      ),
                      const Spacer(),
                      Text(
                        isCorrect ? 'Correct' : 'Incorrect',
                        style: TextStyle(
                          color: isCorrect ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Question
                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Options
                  ...question.options.asMap().entries.map((entry) {
                    int optionIndex = entry.key;
                    String option = entry.value;
                    bool isUserAnswer = userAnswer == optionIndex;
                    bool isCorrectAnswer = question.correctAnswerIndex == optionIndex;

                    Color getBackgroundColor() {
                      if (isCorrectAnswer) return Colors.green.shade100;
                      if (isUserAnswer && !isCorrectAnswer) return Colors.red.shade100;
                      return Colors.grey.shade50;
                    }

                    Color getBorderColor() {
                      if (isCorrectAnswer) return Colors.green;
                      if (isUserAnswer && !isCorrectAnswer) return Colors.red;
                      return Colors.grey.shade300;
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: getBackgroundColor(),
                        border: Border.all(color: getBorderColor()),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${String.fromCharCode(65 + optionIndex)}. ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Text(option)),
                          if (isCorrectAnswer)
                            const Icon(Icons.check, color: Colors.green, size: 20),
                          if (isUserAnswer && !isCorrectAnswer)
                            const Icon(Icons.close, color: Colors.red, size: 20),
                        ],
                      ),
                    );
                  }).toList(),
                  
                  const SizedBox(height: 12),
                  
                  // Explanation
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Explanation:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(question.explanation),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        icon: const Icon(Icons.home),
        label: const Text('Back to Home'),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String subject;
  final IconData icon;
  final Color color;
  final int questionCount;
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.icon,
    required this.color,
    required this.questionCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.8), color.withOpacity(1.0)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 50,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                Text(
                  subject,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '$questionCount Questions',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
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
