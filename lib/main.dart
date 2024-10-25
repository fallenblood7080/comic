import 'package:comic/bloc/comic_bloc.dart';
import 'package:comic/comic_page.dart';
import 'package:comic/fav_comic.dart';
import 'package:comic/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox("favBox");

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int navIndex = 0;

  ComicBloc comicInternet = ComicBloc();
  ComicBloc comicFav = ComicBloc();

  List<Widget> pages = [];
  
  @override
  void initState() {
    pages.add(Comic(comicBloc: comicInternet,));
    pages.add(FavouriteComic(bloc: comicFav));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite")
        ],
        onTap: (index){
          setState(() {
            navIndex = index;
            if(index == 1){
              comicFav.add(FetchComicFavourite());
            }
          });
        },
        currentIndex: navIndex,
        ),
        
        body: IndexedStack(
          index: navIndex,
          children: pages,
        )
      ),
      theme: AppThemes.lightTheme,
    );
  }
}
