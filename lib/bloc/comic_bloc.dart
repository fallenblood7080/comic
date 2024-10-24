import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:comic/Model/comic_data_model.dart';
import 'package:dio/dio.dart';
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
          add(GetComicEvent(List.generate(5, (i) => comicDataModel.num! - i)));
        }
      } catch (e) {
        log(e.toString());
        emit(ComicFailure(message: e.toString()));
      }
    });
    on<GetComicEvent>((event, emit) async {
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
  }
}
