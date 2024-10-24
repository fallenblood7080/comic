import 'package:comic/Model/comic_data_model.dart';
import 'package:comic/bloc/comic_bloc.dart';
import 'package:comic/comic_page.dart';
import 'package:comic/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  List<ComicDataModel> comicList = List.empty(growable: true);
  ComicBloc comicBloc = ComicBloc();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Comic(comicBloc: comicBloc, comicList: comicList),
      theme: AppThemes.lightTheme,
    );
  }
}

