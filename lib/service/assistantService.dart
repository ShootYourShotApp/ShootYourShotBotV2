import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class AssistantService {
  static const String apiKey =
      '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';

  Future<String> transcribeAudio(List<int> audioBytes) async {
    try {
      // Create a temporary file for the audio
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/temp_audio.m4a';
      await File(tempPath).writeAsBytes(audioBytes);

      // Prepare the file for upload
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.openai.com/v1/audio/transcriptions'),
      );

      request.headers.addAll({
        'Authorization': 'Bearer $apiKey',
      });

      request.fields['model'] = 'whisper-1';
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          tempPath,
        ),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      // Clean up temporary file
      await File(tempPath).delete();

      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);
        return data['text'];
      } else {
        throw Exception('Failed to transcribe audio: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in transcribeAudio: $e');
      rethrow;
    }
  }

  Future<String> getChatCompletion(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data['choices'][0]['message']['content']);
        return data['choices'][0]['message']['content'];
      } else {
        throw Exception(
            'Failed to get chat completion: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getChatCompletion: $e');
      rethrow;
    }
  }

  Future<List<int>> textToSpeech(String text) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/audio/speech'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'tts-1',
          'input': text,
          'voice': 'onyx',
        }),
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception(
            'Failed to convert text to speech: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in textToSpeech: $e');
      rethrow;
    }
  }
}
