import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
class AudioConfiguration {
  final AudioPlayer audioPlayer;

  AudioConfiguration(this.audioPlayer);

  Future<void> init(String url) async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    audioPlayer.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    // Try to load audio from a source and catch any errors.
    try {
      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url)));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }
}