import 'dart:async';
import 'tracks.dart';


enum Track{
  track,
  lyrics
}
class Block{
  final _streamController = StreamController<List<Tracks>>.broadcast();

  StreamSink<List<Tracks>> get counterSink => _streamController.sink;
  Stream<List<Tracks>> get counterStream => _streamController.stream;

  final _streamControllerLyrics = StreamController<List<Lyrics>>.broadcast();

  StreamSink<List<Lyrics>> get counterSinkLyrics => _streamControllerLyrics.sink;
  Stream<List<Lyrics>> get counterStreamLyrics => _streamControllerLyrics.stream;


  final _eventStreamController = StreamController<Track>.broadcast();

  StreamSink<Track> get eventSink => _eventStreamController.sink;
  Stream<Track> get eventStream => _eventStreamController.stream;

  Block(){
    eventStream.listen((event) async {
      if(event == Track.track) {
        var tracks = await Tracks.getTracks();
        counterSink.add(tracks!);
      }
    });

  }
}