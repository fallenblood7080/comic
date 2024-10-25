import 'dart:developer';

import 'package:comic/Model/comic_data_model.dart';
import 'package:comic/bloc/comic_bloc.dart';
import 'package:comic/comic_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ComicPageView extends StatefulWidget {
  ComicPageView({super.key, required this.comicList, this.isFavPage = false});
  List<ComicDataModel> comicList;
  bool isFavPage;

  @override
  State<ComicPageView> createState() => _ComicPageViewState();
}

class _ComicPageViewState extends State<ComicPageView> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.comicList.length,
      onPageChanged: (value) {
        if (value == widget.comicList.length - 1 && !widget.isFavPage) {
          BlocProvider.of<ComicBloc>(context).add(FetchComicFromInternet(List.generate(10, (i) => widget.comicList[widget.comicList.length - 1].num! - i - 1)));
        }
      },
      itemBuilder: (context, index) {
        if (index == widget.comicList[0].num!) {
          return const Center(child: Text("Comic Ends!!"));
        }
        return Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
                flex: 2,
                child: Center(
                  child: Text(
                    widget.comicList[index].title ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                )),
            const Divider(),
            Expanded(
              flex: 25,
              child: Image.network(widget.comicList[index].img ?? '', fit: BoxFit.contain),
            ),
            const Divider(),
            Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        "Comic number: ${widget.comicList[index].num}",
                        overflow: TextOverflow.clip,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    BlocProvider<ComicBloc>(create: (context) {
                      ComicBloc comicBloc = ComicBloc();
                      comicBloc.add(CheckComicFavourite(widget.comicList[index].num!));
                      return comicBloc;
                    }, child: BlocBuilder<ComicBloc, ComicState>(
                      builder: (context, state) {
                        if (state is FavExist) {
                          return IconButton(
                              onPressed: () {
                                BlocProvider.of<ComicBloc>(context).add(RemoveComicFavourite(widget.comicList[index].num!));
                                log("comic Remove!");
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ));
                        } else {
                          return IconButton(
                              onPressed: () {
                                BlocProvider.of<ComicBloc>(context).add(AddComicFavourite(widget.comicList[index]));
                                log("comic Added!");
                              },
                              icon: const Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.red,
                              ));
                        }
                      },
                    ))
                  ],
                )),
            Flexible(
                flex: 1,
                child: SizedBox(
                  child: Text(
                    "Date: ${widget.comicList[index].year ?? ''}/${widget.comicList[index].month ?? ''}/${widget.comicList[index].day ?? ''}",
                    overflow: TextOverflow.clip,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                )),
            Flexible(
                flex: 5,
                child: SizedBox(
                  child: Text(
                    "${widget.comicList[index].alt!.length > 100 ? '${widget.comicList[index].alt!.substring(0, 100)}...' : widget.comicList[index].alt}",
                    overflow: TextOverflow.fade,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                )),
          ],
        );
      },
    );
  }
}
