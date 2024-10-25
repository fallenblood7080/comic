part of 'comic_bloc.dart';


sealed class ComicEvent {}

class GetComicInitialEvent extends ComicEvent {}

class FetchComicFromInternet extends ComicEvent {
  List<int> comicNums;
  FetchComicFromInternet(this.comicNums);
}
class FetchComicFavourite extends ComicEvent {}

class AddComicFavourite extends ComicEvent {
  ComicDataModel comicDataModel;
  AddComicFavourite(this.comicDataModel);
}
class RemoveComicFavourite extends ComicEvent {
  int comicNum;
  RemoveComicFavourite(this.comicNum);
}
class CheckComicFavourite extends ComicEvent {
  int comicNum;
  CheckComicFavourite(this.comicNum);
}