import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:comic/Model/comic_data_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

part 'comic_event.dart';
part 'comic_state.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  ComicBloc() : super(ComicInitial()) {
    on<GetComicInitialEvent>((event, emit) async {
      final dio = Dio();
      try {
        final response = await dio.get('https://xkcd.com/info.0.json');
        if (response.statusCode != 200) {
          throw Exception('Failed to load comic, Status:${response.statusCode}');
        } else {
          final comicDataModel = ComicDataModel.fromJson(response.data);
          add(FetchComicFromInternet(List.generate(5, (i) => comicDataModel.num! - i)));
        }
      } catch (e) {
        log(e.toString());
        emit(ComicFailure(message: e.toString()));
      }
    });
    on<FetchComicFromInternet>((event, emit) async {
      final dio = Dio();
      try {
        final futures = event.comicNums.map((index) => dio.get('https://xkcd.com/$index/info.0.json')).toList();
        final responses = await Future.wait(futures);
        List<ComicDataModel> comics = [];
        for (var response in responses) {
          if (response.statusCode != 200) {
            throw Exception('Failed to load comic, Status:${response.statusCode}');
          } else {
            final comicDataModel = ComicDataModel.fromJson(response.data);
            comics.add(comicDataModel);
          }
        }
        emit(ComicSuccess(comics: comics));
        // Process the responses
      } catch (e) {
        log(e.toString());
        emit(ComicFailure(message: e.toString()));
      }
    });

    on<FetchComicFavourite>((event, emit) async {
      var box = Hive.box('favBox');
      List<ComicDataModel> comics = [];
      if(box.isNotEmpty){
        for (var k in box.keys) {
          comics.add(ComicDataModel.fromJson(box.get(k)));
        }
        emit(ComicSuccess(comics: comics));
      }
      else{
        emit(ComicFailure(message: "No Favourite comic found"));
      }
    });

    on<AddComicFavourite>((event, emit) async {
      var box = Hive.box('favBox');
      box.put(event.comicDataModel.num, event.comicDataModel.toJson());
      emit(FavExist());
    });
    on<RemoveComicFavourite>((event, emit) async {
      var box = Hive.box('favBox');
      box.delete(event.comicNum);
      emit(FavNotExist());
    });
    on<CheckComicFavourite>((event, emit) async {
      var box = Hive.box('favBox');
      if(box.containsKey(event.comicNum)){
        emit(FavExist());
      }
      else{
        emit(FavNotExist());
      }
    });
  }
}
