import 'package:flutter/material.dart';
import 'package:music_app/provider/internetConnection.dart';
import 'package:music_app/screens/home_track_page.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Internet(),
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: "Muli"
        ),
        color: Colors.transparent,
        debugShowCheckedModeBanner: false,
        initialRoute: 'home_page',
        routes: {
          'home_page' :(context) => const HomePage(),
        }
      ),
    );
  }
}
