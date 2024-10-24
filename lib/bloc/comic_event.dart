part of 'comic_bloc.dart';


sealed class ComicEvent {}

class GetComicInitialEvent extends ComicEvent {}

class GetComicEvent extends ComicEvent {
  List<int> comicNums;
  GetComicEvent(this.comicNums);
}