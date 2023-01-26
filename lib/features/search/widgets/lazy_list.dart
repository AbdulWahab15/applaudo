import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:applaudo_second_round/features/issues/data/datamodels/issues/issues_repo.dart';
import 'package:applaudo_second_round/features/search/data/datamodels/searchrepo/search_repo.dart';

class ReposLazyListWidget extends StatelessWidget {
  final List<dynamic> data;
  final ScrollController _scrollController = ScrollController();
  final Function loadMoreCallBack;
  final Function(String) onTapCallBack;
  final Type childType;
  final bool hasMore;
  ReposLazyListWidget(
      {Key? key,
      required this.data,
      required this.loadMoreCallBack,
      required this.onTapCallBack,
      required this.childType,
      required this.hasMore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
        child: Text('No Data found'),
      );
    }

    return ListView.builder(
        controller: _scrollController
          ..addListener(() {
            if (_scrollController.offset ==
                _scrollController.position.maxScrollExtent) {
              log("Racehd at max");
              loadMoreCallBack();
            }
          }),
        itemCount: data.length,
        itemBuilder: (cnt, i) {
          if (data.length - 1 == i && hasMore) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (childType == Repos) {
            var obj = data;

            return InkWell(
              onTap: () {
                onTapCallBack(obj[i].fullName!);
              },
              child: Card(
                child: ListTile(
                  title: Row(
                    children: [
                      const Text('Name:'),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(child: Text(obj[i].name!)),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      const Text('Language:'),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(obj[i].language ?? '--'),
                    ],
                  ),
                ),
              ),
            );
          }
          if (childType == Issues) {
            var obj = data;

            return Card(
                child: ListTile(
              // leading:
              //     CircleAvatar(child: Image.network(obj[i].user!.avatarURL)),
              title: Row(
                children: [
                  const Text('Title:'),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Text(obj[i].title!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                        )),
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  const Text('URL:'),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Text(
                      obj[i].user!.avatarURL ?? '--',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ));
          }
          return Container();
        });
  }
}
