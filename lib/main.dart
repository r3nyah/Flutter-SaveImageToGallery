import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://pbs.twimg.com/profile_images/1562762950523645953/AIac_rJO_400x400.jpg',
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            child: const Text(
              'Download',
              style: TextStyle(
                fontSize: 20,
                color: Colors.orangeAccent
              ),
            ),
            onPressed: ()async{
              String url = 'https://pbs.twimg.com/profile_images/1562762950523645953/AIac_rJO_400x400.jpg';
              final tempDir = await getTemporaryDirectory();
              final path = '${tempDir.path}/myfile.png';
              await Dio().download(url,path);
              await GallerySaver.saveImage(path,albumName: 'Flutter');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Succesfully downloaded to gallery'
                  ),
                )
              );
            },
          )
        ],
      ),
    );
  }
}
