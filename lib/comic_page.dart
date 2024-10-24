import 'package:comic/Model/comic_data_model.dart';
import 'package:comic/bloc/comic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Comic extends StatelessWidget {
  const Comic({
    super.key,
    required this.comicBloc,
    required this.comicList,
  });

  final ComicBloc comicBloc;
  final List<ComicDataModel> comicList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: BlocProvider(create: (context) {
        comicBloc.add(GetComicInitialEvent());
        return comicBloc;
      }, child: BlocBuilder<ComicBloc, ComicState>(
        builder: (context, state) {
          if (state is ComicSuccess) {
            comicList.addAll(state.comics);
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: comicList.length,
              itemBuilder: (context, index) {
                if (index == comicList[0].num!) {
                  return const Center(child: Text("Comic Ends!!"));
                }
                return Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Flexible(
                      flex: 1,
                      child: SizedBox(
                        height: 32,
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        child: Center(
                          child: Text(
                            comicList[index].title ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        )),
                    const Divider(),
                    Expanded(
                      flex: 20,
                      child: Image.network(comicList[index].img ?? '', fit: BoxFit.contain),
                    ),
                    const Divider(),
                    Flexible(
                        flex: 1,
                        child: SizedBox(
                          child: Text(
                            "Comic number: ${comicList[index].num}",
                            overflow: TextOverflow.clip,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: SizedBox(
                          child: Text(
                            "Date: ${comicList[index].year ?? ''}/${comicList[index].month ?? ''}/${comicList[index].day ?? ''}",
                            overflow: TextOverflow.clip,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        )),
                    Flexible(
                        flex: 3,
                        child: SizedBox(
                          child: Text(
                            "${comicList[index].alt!.length > 150 ? '${comicList[index].alt!.substring(0, 150)}...' : comicList[index].alt}",
                            overflow: TextOverflow.fade,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        )),
                  ],
                );
              },
              onPageChanged: (value) {
                if (value == comicList.length - 1) {
                  comicBloc.add(GetComicEvent(List.generate(10, (i) => state.comics[state.comics.length - 1].num! - i - 1)));
                }
              },
            );
          } else if (state is ComicFailure) {
            return const Center(
              child: Text("Something went Wrong",style: TextStyle(fontSize: 18),),
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
