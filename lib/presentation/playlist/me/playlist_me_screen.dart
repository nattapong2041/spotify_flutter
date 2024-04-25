import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/extension/app_constant.dart';
import '../../../common/routes/app_router.dart';
import '../widget/playlist_card.dart';
import 'bloc/playlist_me_bloc.dart';

part 'widget/_create_playlist_bottomsheet.dart';

class PlaylistMeScren extends StatefulWidget {
  const PlaylistMeScren({super.key});

  @override
  State<PlaylistMeScren> createState() => _PlaylistMeScrenState();
}

class _PlaylistMeScrenState extends State<PlaylistMeScren> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.7) {
        context.read<PlaylistMeBloc>().add(const PlaylistMeFetch());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'คอลเลกชันของฉัน',
      )),
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              isScrollControlled: true,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.6,
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              showDragHandle: true,
              builder: (_) {
                return Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: _CreatePlayListBottomSheet(
                    onCreated: (name) {
                      context.read<PlaylistMeBloc>().add(PlaylistMeCreate(name: name));
                      context.pop();
                    },
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<PlaylistMeBloc, PlaylistMeState>(
        builder: (context, state) {
          if (state is PlaylistMeInitial || state is PlaylistMeLoading) {
            if (state is PlaylistMeInitial) {
              context.read<PlaylistMeBloc>().add(const PlaylistMeFetch(refresh: true));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PlaylistMeLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<PlaylistMeBloc>().add(const PlaylistMeFetch(refresh: true));
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverGrid.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: 0.65, maxCrossAxisExtent: 250),
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return PlaylistCard(
                        image: state.data[index].coverImage,
                        title: state.data[index].title,
                        owner: state.data[index].owner,
                        description: state.data[index].description,
                        onTap: () => {
                          context.goNamed(ScreenPaths.mePlaylistDetail, pathParameters: {
                            'id': state.data[index].id,
                          }),
                        },
                      );
                    },
                  ),
                  if (state.hasNextPage)
                    const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
                ],
              ),
            );
          } else if (state is PlaylistMeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PlaylistMeBloc>().add(const PlaylistMeFetch(refresh: true));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
