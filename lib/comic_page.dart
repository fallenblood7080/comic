import 'package:comic/Model/comic_data_model.dart';
import 'package:comic/bloc/comic_bloc.dart';
import 'package:comic/comic_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Comic extends StatelessWidget {
  Comic({
    super.key,
    required this.comicBloc,
  });

  List<ComicDataModel> comicList = List.empty(growable: true);
  ComicBloc comicBloc;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("xkcd Comics"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: BlocProvider(create: (context) {
            comicBloc = ComicBloc();
            comicBloc.add(GetComicInitialEvent());
            return comicBloc;
          }, child: BlocBuilder<ComicBloc, ComicState>(
            builder: (context, state) {
              if (state is ComicSuccess) {
                comicList.addAll(state.comics);
                return SizedBox(
                  child: ComicPageView(
                      comicList: comicList,),
                );
              } else if (state is ComicFailure) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
        ));
  }
}
