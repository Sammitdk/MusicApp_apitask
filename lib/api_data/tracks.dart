import 'dart:convert';
import 'package:http/http.dart' as http;


class Lyrics {
  final int id;
  final String body;
  Lyrics({required this.id,required this.body});
}



class Tracks{
  static List<Tracks> tracks = [];
  final int id;
  final String name;
  final String artist;
  final String albumName;
  final int explicit;
  final int rating;
  Tracks({required this.id,required this.name,required this.albumName,required this.artist,required this.explicit,required this.rating});

  static Future<List<Tracks>?> getTracks() async{
    String myApi = "78883b7f8337895104bf7e244ddcf872";
    var url = Uri.parse("https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=$myApi");
    try {
      var response = await http.get(url);
      final data = json.decode(response.body) as Map<String,dynamic>;
      for(int length = 0;length<data['message']['body']['track_list'].length;length++){
        tracks.add(
          Tracks(
            id:data['message']['body']['track_list'][length]['track']['track_id'],
            name: data['message']['body']['track_list'][length]['track']['track_name'],
            albumName: data['message']['body']['track_list'][length]['track']['album_name'],
            artist: data['message']['body']['track_list'][length]['track']['artist_name'],
            explicit: data['message']['body']['track_list'][length]['track']['explicit'],
            rating: data['message']['body']['track_list'][length]['track']['track_rating'],
          ),
        );
      }
      return tracks;
    }
    catch(e){
      print(e.toString());
    }
    return null;
  }
}





