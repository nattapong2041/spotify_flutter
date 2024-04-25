import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/playlist_bloc.dart';
import 'widget/playlist_card.dart';


class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.7) {
        context.read<PlaylistBloc>().add(const GetPlaylistFeatureListEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<PlaylistBloc, PlaylistState>(
          builder: (context, state) {
            return Text(switch (state) {
              PlaylistLoaded() => state.message,
              _ => 'Featured Playlist',
            });
          },
        ),
      ),
      // floatingActionButton: Visibility(
      //   visible: _scrollController.hasClients && _scrollController.offset > 100,
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       _scrollController.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.linear);
      //     },
      //     child: const Icon(Icons.arrow_upward),
      //   ),
      // ),
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          if (state is PlaylistInitial || state is PlaylistLoading) {
            if (state is PlaylistInitial) {
              context
                  .read<PlaylistBloc>()
                  .add(const GetPlaylistFeatureListEvent(shouldRefresh: true));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PlaylistLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<PlaylistBloc>()
                    .add(const GetPlaylistFeatureListEvent(shouldRefresh: true));
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
                      );
                    },
                  ),
                  if (state.hasNextPage)
                    const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
                ],
              ),
            );
          } else if (state is PlaylistError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<PlaylistBloc>()
                          .add(const GetPlaylistFeatureListEvent(shouldRefresh: true));
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
