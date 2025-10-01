# Kids Learning App 🌟

A colorful and interactive Flutter application designed to help children learn the alphabet (A-Z) and numbers (1-10) with attractive UI, sound effects, and engaging animations.

## Features

### 🔤 Alphabet Learning
- Interactive alphabet cards (A-Z)
- Each letter associated with a word and emoji
- Text-to-speech pronunciation
- Attractive animations and colors
- Quiz mode to test learning

### 🔢 Numbers Learning  
- Interactive number cards (1-10)
- Visual representation with emojis
- Number pronunciation and counting
- Engaging animations
- Quiz mode for assessment

### 🎯 Interactive Features
- **Text-to-Speech**: Speaks letters, numbers, and words
- **Animated UI**: Smooth transitions and interactive buttons
- **Quiz Mode**: Test knowledge with fun quizzes
- **Sound Effects**: Audio feedback for interactions
- **Colorful Design**: Child-friendly gradient backgrounds

## Project Structure

```
lib/
├── main.dart                 # Main app entry point
├── screens/
│   ├── home_screen.dart      # Main navigation screen
│   ├── alphabet_screen.dart  # Alphabet learning screen
│   ├── numbers_screen.dart   # Numbers learning screen
│   └── quiz_screen.dart      # Quiz functionality
├── widgets/
│   ├── animated_button.dart  # Custom animated button
│   ├── letter_card.dart      # Alphabet card widget
│   └── number_card.dart      # Number card widget
└── utils/
    └── audio_service.dart    # Text-to-speech service
```

## Dependencies

- `flutter_tts`: Text-to-speech functionality
- `audioplayers`: Sound effects
- `lottie`: Animations support

## Getting Started

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd practical_1
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Screenshots

### Home Screen
- Colorful gradient background
- Two main options: Learn ABC and Learn 123
- Animated welcome message

### Alphabet Screen
- Grid layout of letter cards
- Each card shows letter, word, and emoji
- Tap to hear pronunciation
- Quiz button for testing

### Numbers Screen
- Grid layout of number cards
- Visual counting with emojis
- Interactive number pronunciation
- Quiz functionality

### Quiz Screens
- Multiple choice questions
- Score tracking
- Animated feedback
- Results summary

## Educational Value

This app helps children:
- Learn letter recognition and phonics
- Practice number counting and recognition
- Develop hand-eye coordination through touch interaction
- Improve listening skills with audio feedback
- Build confidence through interactive quizzes

## Technical Features

- **Responsive Design**: Works on various screen sizes
- **Smooth Animations**: Engaging visual feedback
- **Audio Integration**: Clear speech synthesis
- **State Management**: Efficient Flutter state handling
- **Clean Architecture**: Separated concerns with organized file structure

## Future Enhancements

- More interactive games
- Progress tracking
- Parental controls
- Additional languages
- Writing practice mode
- Advanced quiz levels

## License

This project is created for educational purposes.
