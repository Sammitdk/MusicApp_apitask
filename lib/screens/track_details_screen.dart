import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../api_data/tracks.dart';
import '../api_data/bloc.dart';
import '../provider/internetConnection.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen(
      {Key? key,
      required this.trackId,
      required this.trackName,
      required this.trackArtist,
      required this.albumName,
      required this.rating,
      required this.explicit})
      : super(key: key);
  final int trackId;
  final String trackName;
  final String trackArtist;
  final String albumName;
  final int explicit;
  final int rating;

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  Block obj = Block();

  @override
  void initState(){

    Provider.of<Internet>(context,listen: false).listener();
    lyricsToSink();
    obj.eventSink.add(Track.lyrics);
    super.initState();
  }

  Future<void> lyricsToSink() async {
    obj.eventStream.listen((event) async {
      if (event == Track.lyrics) {
        var lyrics = await getLyrics();
        obj.counterSinkLyrics.add(lyrics);
      }
    });
  }

  Future<List<Lyrics>> getLyrics() async {
    String myApi = "78883b7f8337895104bf7e244ddcf872";
    var url = Uri.parse(
        "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${widget.trackId}&apikey=$myApi");
    var response = await http.get(url);
    final List<Lyrics> lyrics = [];
    final data = json.decode(response.body) as Map<String, dynamic>;
    lyrics.add(
      Lyrics(
          id: data['message']['body']['lyrics']['lyrics_id'],
          body: data['message']['body']['lyrics']['lyrics_body']),
    );
    return lyrics;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Track Details",style: TextStyle(fontSize: 23)),
          backgroundColor: Colors.indigo[300],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<Internet>(
            builder: (context,model,child){
              if(model.isOnline == false){
                return const Center(child: Text("No Internet"));
              }
              return StreamBuilder<List<Lyrics>>(
                stream: obj.counterStreamLyrics,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              title: const Text("Name"),
                              subtitle: Text(widget.trackName,style: const TextStyle(fontSize: 18),),
                            ),
                            ListTile(
                              title: const Text("Artist"),
                              subtitle: Text(widget.trackArtist,style: const TextStyle(fontSize: 18),),
                            ),
                            ListTile(
                              title: const Text("AlbumName"),
                              subtitle: Text(widget.albumName,style: const TextStyle(fontSize: 18),),
                            ),
                            ListTile(
                              title: const Text("Explicit"),
                              subtitle: Text("${widget.explicit.isOdd}",style: const TextStyle(fontSize: 18),),
                            ),
                            ListTile(
                              title: const Text("Rating"),
                              subtitle: Text("${widget.rating}",style: const TextStyle(fontSize: 18),),
                            ),
                            ListTile(
                              title: const Text("Lyrics"),
                              subtitle: Text(snapshot.data![index].body.substring(0,snapshot.data![index].body.length- 70),style: const TextStyle(fontSize: 18),),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              );
            },
          )

        )
    );
  }
}
