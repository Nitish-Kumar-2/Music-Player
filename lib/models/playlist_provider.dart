import "package:audioplayers/audioplayers.dart";
import "package:flutter/material.dart";
import "package:music_player/models/song.dart";

class PlayListProvider extends ChangeNotifier {
  // playList of songs
  final List<Song> _playlist = [
    // song 1
    Song(
      songName: "Neele Neele Ambar",
      artistName: "Kishore Kumar",
      albumArtImagePath: "assets/images/song1.jpg",
      audioPath: "audio/song1.mp3",
    ),
    Song(
      songName: "Tum aa Gaye Ho",
      artistName: "Kishore Kumar",
      albumArtImagePath: "assets/images/song2.png",
      audioPath: "audio/song2.mp3",
    ),
    Song(
      songName: "Neele Neele Ambar",
      artistName: "Kishore Kumar",
      albumArtImagePath: "assets/images/song3.png",
      audioPath: "audio/song1.mp3",
    ),
  ];
  int? _currentSongIndex;
  // A U D I O P L A Y E R
  //audio palyer
  final AudioPlayer _audioPlayer = AudioPlayer();
  // durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
  PlayListProvider() {
    listenToDuration();
  }
  // initially not player
  bool _isPlaying = false;
  // play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  // pause the song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void paurseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // seek to a specific postion int the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  // play previous song
  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  // list to duration
  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    _audioPlayer.onPositionChanged.listen((newPostion) {
      _currentDuration = newPostion;
      notifyListeners();
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }
  // dispose audio player

  // G E T T E R S
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isplaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // S E T T E R S
  set currentSongIndex(int? newIndex) {
    // update current song index
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    // update UI
    notifyListeners();
  }
}
