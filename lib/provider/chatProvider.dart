import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

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

  ChatState get state => _state;
  bool get isInConversation => _isInConversation;
  List<Message> get conversationHistory =>
      List.unmodifiable(_conversationHistory);

  ChatProvider() {
    _initializeSpeech();
    _setupAudioPlayerListeners();
  }

  void _setupAudioPlayerListeners() {
    _audioPlayer.playerStateStream.listen((playerState) async {
      if (playerState.processingState == ProcessingState.completed) {
        print('Audio playback completed');
        await _handlePlaybackCompleted();
      }
    });
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
    final contextPrompt = _buildContextPrompt(userInput);
    return await _repository.getChatCompletion(contextPrompt);
  }

  String _buildContextPrompt(String userInput) {
    final recentMessages = _conversationHistory.length > 4
        ? _conversationHistory.sublist(_conversationHistory.length - 4)
        : _conversationHistory;

    if (recentMessages.isEmpty) return userInput;

    String context = 'Previous conversation:\n';
    for (var msg in recentMessages) {
      context += '${msg.isUser ? "User" : "Assistant"}: ${msg.content}\n';
    }
    context += '\nCurrent user input: $userInput\n';
    context +=
        '\nPlease provide a contextual response based on the conversation history.';

    return context;
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
