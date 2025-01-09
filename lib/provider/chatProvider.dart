import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:string_similarity/string_similarity.dart';

import 'package:sysbotv2/model/message.dart';
import 'package:sysbotv2/service/assistantService.dart';

enum ChatState {
  idle,
  listening,
  processing,
  speaking,
}

class ChatProvider extends ChangeNotifier {
  final AssistantService _repository = AssistantService();
  final _audioPlayer = AudioPlayer();
  final SpeechToText _speech = SpeechToText();
  final List<Message> _conversationHistory = [];
  // final ttsService = ElevenLabsService(
  //   apiKey: 'sk_5757615d3628c14eb5a1eb618e158331cbc0f823d78258f0',
  // );
  ChatState _state = ChatState.idle;
  bool _isInitialized = false;
  bool _isInConversation = false;
  String _currentUserInput = '';
  bool _isProcessingSpeech = false;
  Timer? _speechTimer;
  bool _isSpeechFinalized = false;
  String _currentCategory = ''; // Added for category support
  static const Map<String, String> categoryGreetings = {
    'Build Confidence':
        "Yo, ready to level up your confidence? Let's work on owning the room, staying cool under pressure, and standing out socially. Whatever's holding you back, I'm here to help you break through.",
    'Shoot Your Shot':
        "Hey there! Looking to up your dating game? Whether it's making that first move, keeping conversations flowing, or building real connections - I've got your back. Let's make you irresistible!",
    'Look Good Dress Well':
        "Welcome style seeker! Ready to transform your look and boost your presence? From fashion essentials to grooming tips, I'll help you craft a style that turns heads and feels authentically you.",
    'Up Your Influence':
        "Hey future leader! Ready to boost your social impact and command respect? Whether it's public speaking, networking, or leading teams - I'll help you develop that magnetic presence that draws people in.",
    'Escape The Matrix':
        "What's up achiever! Time to break free from average and level up your life. Whether it's crushing goals, building habits, or maximizing productivity - I'm here to help you reach your full potential.",
    '': "Hey there! I'm your AI assistant. How can I help you today?" // Default greeting
  };
  static const Map<String, Map<String, dynamic>> categoryConfig = {
    'Shoot Your Shot': {
      'prompt':
          '''You are a friendly and engaging dating and relationship coach who can handle both casual conversation and specific advice questions. Your personality:

1. Be warm and approachable - respond naturally to greetings, thanks, and casual comments
2. Show empathy and understanding when users share their experiences
3. Keep conversations flowing naturally by acknowledging what users say before giving advice
4. Use a mix of professional expertise and friendly conversation

When giving dating/relationship advice:
- Focus on practical, actionable suggestions
- Share insights about dating, relationships, and social connections
- Maintain an encouraging and supportive tone

Remember to:
- Respond appropriately to greetings, goodbyes, and thanks
- Engage in small talk while gently steering towards dating/relationship topics
- Ask follow-up questions to better understand the situation
- Share relevant examples and stories
- Be understanding of dating anxieties and concerns''',
      'topics': [
        {
          'name': 'dating',
          'synonyms': [
            'date',
            'courtship',
            'seeing someone',
            'going out',
            'meeting people',
            'romantic interest'
          ]
        },
        {
          'name': 'relationships',
          'synonyms': [
            'partnership',
            'couple',
            'romantic',
            'commitment',
            'connection',
            'attachment',
            'bond'
          ]
        },
        {
          'name': 'love',
          'synonyms': [
            'affection',
            'romance',
            'attraction',
            'feelings',
            'chemistry',
            'passion',
            'emotional'
          ]
        },
        {
          'name': 'social',
          'synonyms': [
            'interact',
            'connect',
            'bond',
            'communicate',
            'socialize',
            'mingle',
            'network'
          ]
        },
        {
          'name': 'dating apps',
          'synonyms': [
            'tinder',
            'bumble',
            'hinge',
            'online dating',
            'dating profile',
            'match',
            'swipe'
          ]
        },
        {
          'name': 'breakup',
          'synonyms': [
            'separation',
            'split',
            'divorce',
            'end relationship',
            'heartbreak',
            'moving on'
          ]
        },
        {
          'name': 'dating advice',
          'synonyms': [
            'relationship help',
            'dating tips',
            'relationship guidance',
            'love advice'
          ]
        },
        {
          'name': 'flirting',
          'synonyms': [
            'hitting on',
            'chatting up',
            'pickup',
            'approach',
            'charm',
            'attract'
          ]
        },
        {
          'name': 'relationship problems',
          'synonyms': [
            'issues',
            'challenges',
            'difficulties',
            'conflicts',
            'disagreements'
          ]
        },
        {
          'name': 'dating anxiety',
          'synonyms': [
            'nervous',
            'scared',
            'worried',
            'overthinking',
            'fear of rejection'
          ]
        }
      ],
      'contexts': [
        'how to',
        'what if',
        'should i',
        'meeting someone',
        'asking out',
        'getting closer',
        'relationship problems',
        'dating situation',
        'feelings for someone',
        'interested in',
        'crushing on',
        'texting',
        'messaging',
        'approaching',
        'talking to',
        'getting to know',
        'moving forward',
        'taking next step'
      ]
    },
    'Build Confidence': {
      'prompt':
          '''You are a supportive and understanding confidence coach who balances friendly conversation with expert guidance. Your personality:

1. Be warm and encouraging - respond naturally to all types of messages
2. Show genuine interest in users' experiences and concerns
3. Balance professional advice with casual, friendly conversation
4. Create a safe space for sharing insecurities and fears

When giving confidence advice:
- Provide practical steps for building self-esteem
- Share techniques for personal growth
- Maintain an optimistic but realistic tone

Remember to:
- Acknowledge and respond to casual conversation naturally
- Show empathy when users share their struggles
- Ask thoughtful follow-up questions
- Share relevant examples and success stories
- Validate feelings while encouraging growth''',
      'topics': [
        {
          'name': 'confidence',
          'synonyms': [
            'self-assured',
            'certainty',
            'belief in self',
            'assertive',
            'secure',
            'empowered'
          ]
        },
        {
          'name': 'self-esteem',
          'synonyms': [
            'self-worth',
            'self-image',
            'self-respect',
            'self-value',
            'dignity',
            'pride'
          ]
        },
        {
          'name': 'personal growth',
          'synonyms': [
            'self-improvement',
            'development',
            'progress',
            'advancement',
            'evolution'
          ]
        },
        {
          'name': 'mental health',
          'synonyms': [
            'emotional health',
            'psychological',
            'mental wellbeing',
            'mental state'
          ]
        },
        {
          'name': 'anxiety',
          'synonyms': [
            'worry',
            'fear',
            'stress',
            'nervousness',
            'apprehension',
            'unease'
          ]
        },
        {
          'name': 'motivation',
          'synonyms': [
            'drive',
            'inspiration',
            'ambition',
            'determination',
            'willpower'
          ]
        },
        {
          'name': 'mindset',
          'synonyms': [
            'attitude',
            'perspective',
            'outlook',
            'thinking',
            'mentality'
          ]
        },
        {
          'name': 'self-doubt',
          'synonyms': [
            'insecurity',
            'uncertainty',
            'hesitation',
            'low confidence',
            'questioning'
          ]
        },
        {
          'name': 'empowerment',
          'synonyms': [
            'strength',
            'capability',
            'potential',
            'inner power',
            'self-belief'
          ]
        },
        {
          'name': 'resilience',
          'synonyms': [
            'toughness',
            'perseverance',
            'grit',
            'bounce back',
            'recovery'
          ]
        }
      ],
      'contexts': [
        'feel better',
        'improve myself',
        'overcome',
        'deal with',
        'handle',
        'manage',
        'build up',
        'develop',
        'strengthen',
        'boost',
        'enhance',
        'grow',
        'learn to',
        'want to be',
        'become more',
        'feeling down',
        'struggling with',
        'working on'
      ]
    },
    'Look Good Dress Well': {
      'prompt':
          '''You are a friendly and stylish fashion consultant who enjoys both casual chat and giving style advice. Your personality:

1. Be enthusiastic and approachable - engage naturally in all types of conversation
2. Show genuine interest in users' style journey
3. Balance professional expertise with friendly discussion
4. Make fashion and grooming advice feel accessible and fun

When giving style advice:
- Provide practical and actionable fashion tips
- Share grooming and self-care guidance
- Maintain an encouraging and non-judgmental tone

Remember to:
- Engage in casual conversation while naturally incorporating style topics
- Show enthusiasm for users' interest in self-improvement
- Ask questions to better understand their style preferences
- Share relevant trends and tips
- Make fashion advice feel personal and achievable''',
      'topics': [
        {
          'name': 'fashion',
          'synonyms': [
            'style',
            'clothing',
            'outfits',
            'attire',
            'wardrobe',
            'dress',
            'looks'
          ]
        },
        {
          'name': 'grooming',
          'synonyms': [
            'hygiene',
            'self-care',
            'maintenance',
            'appearance',
            'personal care'
          ]
        },
        {
          'name': 'skincare',
          'synonyms': [
            'skin',
            'complexion',
            'face care',
            'beauty routine',
            'treatment'
          ]
        },
        {
          'name': 'haircare',
          'synonyms': [
            'hairstyle',
            'hair maintenance',
            'hair products',
            'styling',
            'cuts'
          ]
        },
        {
          'name': 'accessories',
          'synonyms': [
            'jewelry',
            'watches',
            'bags',
            'belts',
            'shoes',
            'complementary items'
          ]
        },
        {
          'name': 'body care',
          'synonyms': [
            'fitness',
            'health',
            'wellness',
            'physique',
            'physical appearance'
          ]
        },
        {
          'name': 'makeup',
          'synonyms': [
            'cosmetics',
            'beauty products',
            'face makeup',
            'application',
            'looks'
          ]
        },
        {
          'name': 'trends',
          'synonyms': [
            'fashion trends',
            'current styles',
            'popular looks',
            'seasonal fashion'
          ]
        },
        {
          'name': 'shopping',
          'synonyms': [
            'buying clothes',
            'retail',
            'fashion stores',
            'online shopping'
          ]
        },
        {
          'name': 'image',
          'synonyms': [
            'appearance',
            'look',
            'presentation',
            'visual impact',
            'impression'
          ]
        }
      ],
      'contexts': [
        'what to wear',
        'how to style',
        'looking good',
        'improve appearance',
        'fashion advice',
        'dress for',
        'match with',
        'coordinate',
        'put together',
        'maintain',
        'take care of',
        'recommend',
        'suggestion for',
        'tips on',
        'routine for',
        'products for',
        'best way to'
      ]
    },
    'Up Your Influence': {
      'prompt':
          '''You are a charismatic leadership coach who combines friendly conversation with powerful insights. Your personality:

1. Be engaging and inspiring - handle all types of interaction naturally
2. Show genuine interest in users' leadership journey
3. Balance professional guidance with authentic conversation
4. Create an empowering atmosphere

When giving leadership advice:
- Share practical strategies for building influence
- Provide insights on social dynamics
- Maintain an empowering yet approachable tone

Remember to:
- Engage naturally in casual conversation
- Show interest in users' professional goals
- Ask insightful follow-up questions
- Share relevant examples and success stories
- Make leadership concepts accessible''',
      'topics': [
        {
          'name': 'leadership',
          'synonyms': [
            'leading',
            'management',
            'guidance',
            'direction',
            'authority',
            'command'
          ]
        },
        {
          'name': 'influence',
          'synonyms': [
            'impact',
            'sway',
            'persuasion',
            'effect',
            'power',
            'leverage'
          ]
        },
        {
          'name': 'charisma',
          'synonyms': [
            'charm',
            'magnetism',
            'appeal',
            'presence',
            'personality',
            'attractiveness'
          ]
        },
        {
          'name': 'communication',
          'synonyms': [
            'speaking',
            'presentation',
            'expression',
            'articulation',
            'delivery'
          ]
        },
        {
          'name': 'networking',
          'synonyms': [
            'connections',
            'relationships',
            'contacts',
            'professional network'
          ]
        },
        {
          'name': 'negotiation',
          'synonyms': [
            'bargaining',
            'discussion',
            'dealing',
            'mediation',
            'compromise'
          ]
        },
        {
          'name': 'personal brand',
          'synonyms': [
            'reputation',
            'image',
            'presence',
            'standing',
            'credibility'
          ]
        },
        {
          'name': 'social skills',
          'synonyms': [
            'people skills',
            'interpersonal',
            'social intelligence',
            'rapport'
          ]
        },
        {
          'name': 'emotional intelligence',
          'synonyms': ['EQ', 'empathy', 'social awareness', 'understanding']
        },
        {
          'name': 'public speaking',
          'synonyms': [
            'presentations',
            'speeches',
            'talks',
            'addressing groups'
          ]
        }
      ],
      'contexts': [
        'how to lead',
        'better at',
        'improve my',
        'develop',
        'strengthen',
        'build',
        'enhance',
        'manage',
        'deal with',
        'handle',
        'approach to',
        'strategy for',
        'technique to',
        'way to',
        'method for',
        'system of',
        'practice of'
      ]
    },
    'Escape The Matrix': {
      'prompt':
          '''You are a motivating success coach who combines friendly conversation with powerful guidance. Your personality:

1. Be energetic and supportive - engage naturally in all interactions
2. Show genuine interest in users' goals and dreams
3. Balance motivation with realistic conversation
4. Create an atmosphere of possibility and growth

When giving success advice:
- Share practical strategies for achieving goals
- Provide productivity and motivation tips
- Maintain an inspiring yet grounded tone

Remember to:
- Respond naturally to casual conversation
- Show enthusiasm for users' ambitions
- Ask thoughtful questions about their goals
- Share relevant examples and insights
- Make success principles accessible''',
      'topics': [
        {
          'name': 'success',
          'synonyms': [
            'achievement',
            'accomplishment',
            'attainment',
            'triumph',
            'victory'
          ]
        },
        {
          'name': 'productivity',
          'synonyms': [
            'efficiency',
            'output',
            'performance',
            'effectiveness',
            'results'
          ]
        },
        {
          'name': 'goals',
          'synonyms': [
            'objectives',
            'targets',
            'aims',
            'aspirations',
            'ambitions',
            'plans'
          ]
        },
        {
          'name': 'motivation',
          'synonyms': [
            'drive',
            'inspiration',
            'ambition',
            'determination',
            'willpower'
          ]
        },
        {
          'name': 'mindset',
          'synonyms': [
            'attitude',
            'mentality',
            'perspective',
            'outlook',
            'thinking'
          ]
        },
        {
          'name': 'habits',
          'synonyms': [
            'routines',
            'practices',
            'behaviors',
            'patterns',
            'disciplines'
          ]
        },
        {
          'name': 'time management',
          'synonyms': ['scheduling', 'planning', 'organizing', 'prioritizing']
        },
        {
          'name': 'personal development',
          'synonyms': ['self-improvement', 'growth', 'advancement', 'progress']
        },
        {
          'name': 'career growth',
          'synonyms': [
            'professional development',
            'advancement',
            'promotion',
            'success'
          ]
        },
        {
          'name': 'life balance',
          'synonyms': ['work-life balance', 'lifestyle', 'wellbeing', 'harmony']
        }
      ],
      'contexts': [
        'how to achieve',
        'want to succeed',
        'improve my',
        'better at',
        'more effective',
        'efficient way',
        'maximize',
        'optimize',
        'enhance',
        'develop',
        'create',
        'establish',
        'maintain',
        'reach my',
        'accomplish',
        'achieve',
        'succeed in',
        'excel at'
      ]
    }
  };
  ChatState get state => _state;
  bool get isInConversation => _isInConversation;
  List<Message> get conversationHistory =>
      List.unmodifiable(_conversationHistory);
  String get currentCategory => _currentCategory;

  ChatProvider() {
    _initializeSpeech();
    _setupAudioPlayerListeners();
  }
  void setCategory(String category) {
    _currentCategory = category;
    _conversationHistory.clear();
    notifyListeners();
  }

  void _setupAudioPlayerListeners() {
    _audioPlayer.playerStateStream.listen((playerState) async {
      if (playerState.processingState == ProcessingState.completed) {
        print('Audio playback completed');
        await _handlePlaybackCompleted();
      }
    });
  }

  Future<void> playInitialGreeting() async {
    final greeting =
        categoryGreetings[_currentCategory] ?? categoryGreetings['']!;
    _conversationHistory.add(Message(
      content: greeting,
      isUser: false,
      timestamp: DateTime.now(),
    ));
    await playWelcomeMessage(greeting);
    _state = ChatState.idle;
    notifyListeners();
  }

  Future<void> _handlePlaybackCompleted() async {
    _state = ChatState.idle;
    notifyListeners();

    if (_isInConversation) {
      // Add a longer delay before starting to listen again
      await Future.delayed(const Duration(seconds: 1));
      await _startNewListeningSession();
    }
  }

  Future<void> _initializeSpeech() async {
    try {
      _isInitialized = await _speech.initialize(
        onError: (error) {
          print('Error initializing speech: $error');
          startListening();
        },
        onStatus: (status) => _handleSpeechStatus(status),
      );
      notifyListeners();
    } catch (e) {
      print('Error initializing speech: $e');
      _isInitialized = false;
    }
  }

  void _handleSpeechStatus(String status) {
    print('Speech status: $status');
    if (status == 'done' || status == 'notListening') {
      if (_isSpeechFinalized) {
        _processSpeechInput();
      }
    }
  }

  Future<void> _startNewListeningSession() async {
    if (!_isInConversation) {
      _state = ChatState.idle;
      notifyListeners();
      return;
    }

    if (_state == ChatState.listening) {
      await _speech.stop();
    }

    _currentUserInput = '';
    _isProcessingSpeech = false;
    _isSpeechFinalized = false;

    // Only start listening if still in conversation
    if (_isInConversation) {
      await Future.delayed(const Duration(milliseconds: 500));
      await startListening();
    }
  }

  Future<void> startListening() async {
    if (!_isInConversation) return;

    if (!_isInitialized) {
      await _initializeSpeech();
    }

    if (_state == ChatState.speaking) {
      await stopPlaying();
      await Future.delayed(const Duration(milliseconds: 500));
    }

    try {
      _state = ChatState.listening;
      _isProcessingSpeech = false;
      _isSpeechFinalized = false;
      notifyListeners();

      // Check again before starting to listen
      if (_isInConversation) {
        await _speech.listen(
          onResult: (result) => _handleSpeechResult(result),
        );
      }
    } catch (e) {
      print('Error starting speech recognition: $e');
      if (_isInConversation) {
        _state = ChatState.idle;
        notifyListeners();
      }
    }
  }

  void _handleSpeechResult(SpeechRecognitionResult result) {
    print(
        'Speech result received: ${result.recognizedWords} (final: ${result.finalResult})');

    if (result.finalResult) {
      _currentUserInput = result.recognizedWords;
      _isSpeechFinalized = true;
      if (_currentUserInput.isNotEmpty) {
        _processSpeechInput();
      }
    } else {
      // Just update current input for partial results
      _currentUserInput = result.recognizedWords;
    }
  }

  void _processSpeechInput() {
    if (_isProcessingSpeech || _currentUserInput.isEmpty || !_isInConversation)
      return;

    _isProcessingSpeech = true;
    _speechTimer?.cancel();

    _speechTimer = Timer(const Duration(milliseconds: 500), () async {
      if (_currentUserInput.isNotEmpty && _isInConversation) {
        _state = ChatState.processing;
        notifyListeners();

        // Add user message to history
        _conversationHistory.add(Message(
          content: _currentUserInput,
          isUser: true,
          timestamp: DateTime.now(),
        ));

        // Get AI response with context
        final response = await _getAIResponse(_currentUserInput);

        // Only proceed if still in conversation
        if (_isInConversation) {
          // Add AI response to history
          _conversationHistory.add(Message(
            content: response,
            isUser: false,
            timestamp: DateTime.now(),
          ));

          await playResponse(response);
        }
      } else {
        _isProcessingSpeech = false;
        if (_isInConversation) {
          await _startNewListeningSession();
        }
      }
    });
  }

  Future<String> _getAIResponse(String userInput) async {
    final conversationContext = _buildConversationContext(userInput);
    return await _repository.getChatCompletion(conversationContext);
  }

  String _buildConversationContext(String userInput) {
    String contextPrompt = '';

    // Add category-specific context if available
    if (_currentCategory.isNotEmpty &&
        categoryConfig.containsKey(_currentCategory)) {
      contextPrompt += '''${categoryConfig[_currentCategory]!['prompt']}

Current conversation state:
- Category: ${_currentCategory}
- Previous messages: ${_getRecentMessages()}
- User input: $userInput

Guidelines:
1. Always respond naturally to greetings, thanks, and casual comments
2. If the message is conversational, engage appropriately while gently steering towards category topics
3. If the message is a direct question, provide helpful advice while maintaining a friendly tone
4. Use the conversation history to maintain context and provide personalized responses
''';
    } else {
      // Default conversational prompt if no category is selected
      contextPrompt +=
          '''You are a friendly and helpful assistant. Engage naturally in conversation while providing valuable insights.

Current conversation state:
- Previous messages: ${_getRecentMessages()}
- User input: $userInput

Guidelines:
1. Respond naturally to all types of messages
2. Maintain a warm and engaging conversation
3. Provide helpful information when asked
4. Use conversation history for context
''';
    }

    return contextPrompt;
  }

  String _getRecentMessages() {
    final recentMessages = _conversationHistory.length > 4
        ? _conversationHistory.sublist(_conversationHistory.length - 4)
        : _conversationHistory;

    return recentMessages
        .map((msg) => '${msg.isUser ? "User" : "Assistant"}: ${msg.content}')
        .join('\n');
  }

  Future<void> interruptAndListen() async {
    if (_state == ChatState.speaking) {
      print('Manual interruption requested');
      await _audioPlayer.stop();

      if (_isInConversation) {
        // Set state before starting to listen
        _state = ChatState.listening;
        notifyListeners();

        _isProcessingSpeech = false;
        _isSpeechFinalized = false;

        try {
          await _speech.listen(
            onResult: (result) => _handleSpeechResult(result),
          );
        } catch (e) {
          print('Error starting speech recognition after interruption: $e');
          if (_isInConversation) {
            _state = ChatState.idle;
            notifyListeners();
          }
        }
      }
    }
  }

  Future<void> startConversation() async {
    _isInConversation = true;
    _conversationHistory.clear();
    await Future.delayed(const Duration(milliseconds: 300));
    await startListening();
  }

  Future<void> cancelConversation() async {
    print('Canceling conversation');
    _isInConversation = false;
    stopPlaying();
    await _audioPlayer.stop();
    _speechTimer?.cancel();
    await _speech.stop();
    _state = ChatState.idle;
    _conversationHistory.clear();
    _currentUserInput = '';
    _isProcessingSpeech = false;
    _isSpeechFinalized = false;
    notifyListeners();
  }

  Future<void> playResponse(String text) async {
    try {
      final audioBytes = await _repository.textToSpeech(text);

      final tempDir = Directory.systemTemp;
      final tempPath =
          '${tempDir.path}/response_${DateTime.now().millisecondsSinceEpoch}.mp3';
      await File(tempPath).writeAsBytes(audioBytes);

      _state = ChatState.speaking;
      notifyListeners();

      await _audioPlayer.setFilePath(tempPath);
      await _audioPlayer.play();
      await File(tempPath).delete();
      await Future.delayed(const Duration(milliseconds: 100));
      await _audioPlayer.stop();
      _state = ChatState.listening;
      notifyListeners();
    } catch (e) {
      print('Error playing response: $e');
      _state = ChatState.idle;
      notifyListeners();
    }
  }

  Future<void> playWelcomeMessage(String text) async {
    try {
      final audioBytes = await _repository.textToSpeech(text);

      final tempDir = Directory.systemTemp;
      final tempPath =
          '${tempDir.path}/initialresponse_${DateTime.now().millisecondsSinceEpoch}.mp3';
      await File(tempPath).writeAsBytes(audioBytes);

      _state = ChatState.speaking;
      notifyListeners();

      await _audioPlayer.setFilePath(tempPath);
      await _audioPlayer.play();
      await File(tempPath).delete();
      await Future.delayed(const Duration(milliseconds: 100));
      await _audioPlayer.stop();
      _state = ChatState.idle;
      notifyListeners();
    } catch (e) {
      print('Error playing response: $e');
      _state = ChatState.idle;
      notifyListeners();
    }
  }

  Future<void> stopPlaying() async {
    try {
      await _audioPlayer.stop();
      _state = ChatState.idle;
      notifyListeners();
    } catch (e) {
      print('Error stopping playback: $e');
    }
  }

  @override
  void dispose() {
    _speechTimer?.cancel();
    _audioPlayer.dispose();
    _speech.stop();
    _speech.cancel();
    _isInConversation = false;
    super.dispose();
  }
}
