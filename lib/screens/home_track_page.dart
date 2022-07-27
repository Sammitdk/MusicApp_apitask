import 'package:flutter/material.dart';
import 'package:music_app/screens/track_details_screen.dart';
import 'package:provider/provider.dart';

import '../api_data/tracks.dart';
import '../api_data/bloc.dart';
import '../provider/internetConnection.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Block obj = Block();

  @override
    void initState() {
    Provider.of<Internet>(context,listen: false).listener();
    obj.eventSink.add(Track.track);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Trending",style: TextStyle(fontSize: 23)),
        backgroundColor: Colors.indigo[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<Internet>(builder: (context, model, child) {
          if (model.isOnline == false) {
            return const Center(child: Text("No Internet")
            );
          }
          return StreamBuilder<List<Tracks>>(
            stream: obj.counterStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => TrackScreen(
                                    trackId: snapshot.data![index].id,
                                    trackName: snapshot.data![index].name,
                                    trackArtist: snapshot.data![index].artist,
                                    explicit: snapshot.data![index].explicit,
                                    rating: snapshot.data![index].rating,
                                    albumName:
                                    snapshot.data![index].albumName,
                                  )));
                        },
                        child: ListTile(
                          title: Text(
                            snapshot.data![index].name,
                            style: const TextStyle(fontSize: 21),
                          ),
                          subtitle: Text(snapshot.data![index].albumName),
                          leading: const Icon(Icons.my_library_music_sharp),
                          trailing: Text(
                            snapshot.data![index].artist,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          );
        }),
      ),
    );
  }
}
