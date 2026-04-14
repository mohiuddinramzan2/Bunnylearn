// lib/data/app_data.dart

class AlphabetItem {
  final String letter;
  final String word;
  final String emoji;
  final String phonetic;
  final String color;

  const AlphabetItem({
    required this.letter,
    required this.word,
    required this.emoji,
    required this.phonetic,
    required this.color,
  });
}

class WordItem {
  final String word;
  final String emoji;
  final String category;
  final String color;
  final String sentence;

  const WordItem({
    required this.word,
    required this.emoji,
    required this.category,
    required this.color,
    required this.sentence,
  });
}

class QuizQuestion {
  final String question;
  final String emoji;
  final List<String> options;
  final int correctIndex;

  const QuizQuestion({
    required this.question,
    required this.emoji,
    required this.options,
    required this.correctIndex,
  });
}

class AppData {
  static const List<AlphabetItem> alphabet = [
    AlphabetItem(letter: 'A', word: 'Apple', emoji: '🍎', phonetic: '/eɪ/', color: '#FF6B6B'),
    AlphabetItem(letter: 'B', word: 'Bear', emoji: '🐻', phonetic: '/biː/', color: '#FF9F43'),
    AlphabetItem(letter: 'C', word: 'Cat', emoji: '🐱', phonetic: '/siː/', color: '#FECA57'),
    AlphabetItem(letter: 'D', word: 'Dog', emoji: '🐶', phonetic: '/diː/', color: '#48DBFB'),
    AlphabetItem(letter: 'E', word: 'Elephant', emoji: '🐘', phonetic: '/iː/', color: '#FF9FF3'),
    AlphabetItem(letter: 'F', word: 'Fish', emoji: '🐟', phonetic: '/ɛf/', color: '#54A0FF'),
    AlphabetItem(letter: 'G', word: 'Grape', emoji: '🍇', phonetic: '/dʒiː/', color: '#5F27CD'),
    AlphabetItem(letter: 'H', word: 'House', emoji: '🏠', phonetic: '/eɪtʃ/', color: '#00D2D3'),
    AlphabetItem(letter: 'I', word: 'Ice Cream', emoji: '🍦', phonetic: '/aɪ/', color: '#FF9CAC'),
    AlphabetItem(letter: 'J', word: 'Jam', emoji: '🫙', phonetic: '/dʒeɪ/', color: '#EE5A24'),
    AlphabetItem(letter: 'K', word: 'Kite', emoji: '🪁', phonetic: '/keɪ/', color: '#009432'),
    AlphabetItem(letter: 'L', word: 'Lion', emoji: '🦁', phonetic: '/ɛl/', color: '#F9CA24'),
    AlphabetItem(letter: 'M', word: 'Moon', emoji: '🌙', phonetic: '/ɛm/', color: '#6C5CE7'),
    AlphabetItem(letter: 'N', word: 'Night', emoji: '🌙', phonetic: '/ɛn/', color: '#2C3E50'),
    AlphabetItem(letter: 'O', word: 'Orange', emoji: '🍊', phonetic: '/oʊ/', color: '#E67E22'),
    AlphabetItem(letter: 'P', word: 'Penguin', emoji: '🐧', phonetic: '/piː/', color: '#74B9FF'),
    AlphabetItem(letter: 'Q', word: 'Queen', emoji: '👑', phonetic: '/kjuː/', color: '#A29BFE'),
    AlphabetItem(letter: 'R', word: 'Rainbow', emoji: '🌈', phonetic: '/ɑːr/', color: '#FD79A8'),
    AlphabetItem(letter: 'S', word: 'Star', emoji: '⭐', phonetic: '/ɛs/', color: '#FDCB6E'),
    AlphabetItem(letter: 'T', word: 'Tree', emoji: '🌳', phonetic: '/tiː/', color: '#00B894'),
    AlphabetItem(letter: 'U', word: 'Umbrella', emoji: '☂️', phonetic: '/juː/', color: '#0984E3'),
    AlphabetItem(letter: 'V', word: 'Violin', emoji: '🎻', phonetic: '/viː/', color: '#6D4C41'),
    AlphabetItem(letter: 'W', word: 'Whale', emoji: '🐋', phonetic: '/ˈdʌbljuː/', color: '#00CEC9'),
    AlphabetItem(letter: 'X', word: 'X-Ray', emoji: '🔭', phonetic: '/ɛks/', color: '#636E72'),
    AlphabetItem(letter: 'Y', word: 'Yellow', emoji: '🌻', phonetic: '/waɪ/', color: '#FFEAA7'),
    AlphabetItem(letter: 'Z', word: 'Zebra', emoji: '🦓', phonetic: '/zɛd/', color: '#2D3436'),
  ];

  static const List<WordItem> words = [
    WordItem(word: 'Cat', emoji: '🐱', category: 'Animals', color: '#FF6B6B', sentence: 'The cat is sleeping.'),
    WordItem(word: 'Dog', emoji: '🐶', category: 'Animals', color: '#FF9F43', sentence: 'The dog is happy.'),
    WordItem(word: 'Bird', emoji: '🐦', category: 'Animals', color: '#48DBFB', sentence: 'The bird can fly.'),
    WordItem(word: 'Fish', emoji: '🐟', category: 'Animals', color: '#54A0FF', sentence: 'The fish swims fast.'),
    WordItem(word: 'Frog', emoji: '🐸', category: 'Animals', color: '#00B894', sentence: 'The frog jumps high.'),
    WordItem(word: 'Apple', emoji: '🍎', category: 'Fruits', color: '#FF6B6B', sentence: 'An apple a day!'),
    WordItem(word: 'Banana', emoji: '🍌', category: 'Fruits', color: '#FECA57', sentence: 'Monkeys love bananas.'),
    WordItem(word: 'Orange', emoji: '🍊', category: 'Fruits', color: '#E67E22', sentence: 'Oranges are juicy.'),
    WordItem(word: 'Grapes', emoji: '🍇', category: 'Fruits', color: '#6C5CE7', sentence: 'Grapes are sweet.'),
    WordItem(word: 'Mango', emoji: '🥭', category: 'Fruits', color: '#FDCB6E', sentence: 'I love mangoes!'),
    WordItem(word: 'Sun', emoji: '☀️', category: 'Nature', color: '#FECA57', sentence: 'The sun is bright.'),
    WordItem(word: 'Moon', emoji: '🌙', category: 'Nature', color: '#A29BFE', sentence: 'The moon shines at night.'),
    WordItem(word: 'Rain', emoji: '🌧️', category: 'Nature', color: '#74B9FF', sentence: 'Rain makes flowers grow.'),
    WordItem(word: 'Tree', emoji: '🌳', category: 'Nature', color: '#00B894', sentence: 'Trees give us shade.'),
    WordItem(word: 'Star', emoji: '⭐', category: 'Nature', color: '#FDCB6E', sentence: 'Stars twinkle at night.'),
    WordItem(word: 'Ball', emoji: '⚽', category: 'Toys', color: '#FF6B6B', sentence: 'Kick the ball!'),
    WordItem(word: 'Doll', emoji: '🪆', category: 'Toys', color: '#FF9FF3', sentence: 'She loves her doll.'),
    WordItem(word: 'Kite', emoji: '🪁', category: 'Toys', color: '#54A0FF', sentence: 'Fly the kite high!'),
    WordItem(word: 'Drum', emoji: '🥁', category: 'Toys', color: '#EE5A24', sentence: 'Beat the drum loud!'),
    WordItem(word: 'Bike', emoji: '🚲', category: 'Toys', color: '#00CEC9', sentence: 'Ride your bike fast!'),
  ];

  static List<QuizQuestion> get quizQuestions => [
    const QuizQuestion(
      question: 'Which letter does 🍎 start with?',
      emoji: '🍎',
      options: ['A', 'B', 'C', 'D'],
      correctIndex: 0,
    ),
    const QuizQuestion(
      question: 'Which letter does 🐻 start with?',
      emoji: '🐻',
      options: ['A', 'B', 'C', 'D'],
      correctIndex: 1,
    ),
    const QuizQuestion(
      question: 'Which letter does 🐱 start with?',
      emoji: '🐱',
      options: ['A', 'B', 'C', 'D'],
      correctIndex: 2,
    ),
    const QuizQuestion(
      question: 'Which letter does 🐶 start with?',
      emoji: '🐶',
      options: ['A', 'B', 'C', 'D'],
      correctIndex: 3,
    ),
    const QuizQuestion(
      question: 'What animal is this? 🦁',
      emoji: '🦁',
      options: ['Tiger', 'Bear', 'Lion', 'Wolf'],
      correctIndex: 2,
    ),
    const QuizQuestion(
      question: 'Which fruit is this? 🍌',
      emoji: '🍌',
      options: ['Apple', 'Banana', 'Mango', 'Orange'],
      correctIndex: 1,
    ),
    const QuizQuestion(
      question: 'What is this? 🌈',
      emoji: '🌈',
      options: ['Rain', 'Cloud', 'Rainbow', 'Storm'],
      correctIndex: 2,
    ),
    const QuizQuestion(
      question: 'Which letter does 🐘 start with?',
      emoji: '🐘',
      options: ['E', 'F', 'G', 'H'],
      correctIndex: 0,
    ),
    const QuizQuestion(
      question: 'What is this? ⭐',
      emoji: '⭐',
      options: ['Moon', 'Sun', 'Star', 'Planet'],
      correctIndex: 2,
    ),
    const QuizQuestion(
      question: 'Which letter does 🌳 start with?',
      emoji: '🌳',
      options: ['R', 'S', 'T', 'U'],
      correctIndex: 2,
    ),
  ];
}
