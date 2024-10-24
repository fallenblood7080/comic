part of 'comic_bloc.dart';


sealed class ComicState {}

final class ComicInitial extends ComicState {}

class ComicSuccess extends ComicState {
  final List<ComicDataModel> comics;
  ComicSuccess({required this.comics});
}
class ComicFailure extends ComicState {
  final String message;
  ComicFailure({required this.message});
}



