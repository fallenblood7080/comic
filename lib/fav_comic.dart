import 'package:comic/Model/comic_data_model.dart';
import 'package:comic/bloc/comic_bloc.dart';
import 'package:comic/comic_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteComic extends StatelessWidget {
  FavouriteComic({super.key,required this.bloc});
  ComicBloc bloc;
  List<ComicDataModel> comicList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Comics'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: BlocProvider(create: (context) {
            bloc.add(FetchComicFavourite());
            return bloc;
          }, child: BlocBuilder<ComicBloc, ComicState>(
            builder: (context, state) {
              if (state is ComicSuccess) {
                comicList = state.comics;
                return SizedBox(
                  child: ComicPageView(
                      comicList: comicList,
                      isFavPage: true,),
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
        ),
    );
  }
}