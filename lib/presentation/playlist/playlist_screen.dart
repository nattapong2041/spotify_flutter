import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'bloc/playlist_bloc.dart';

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
        title: const Text('Playlist'),
      ),
      floatingActionButton: Visibility(
        visible: _scrollController.hasClients && _scrollController.offset > 100,
        child: FloatingActionButton(
          onPressed: () {
            _scrollController.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.linear);
          },
          child: const Icon(Icons.arrow_upward),
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          if (state is PlaylistInitial) {
            context
                .read<PlaylistBloc>()
                .add(const GetPlaylistFeatureListEvent(shouldRefresh: true));
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PlaylistLoading) {
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
                  SliverToBoxAdapter(child: Text(state.message, style: Theme.of(context).textTheme.headlineMedium,)),
                  SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return Text(state.data[index].title);
                    },
                  ),
                  if (state.hasNextPage) const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
                ],
              ),
            );
          } else if (state is PlaylistError) {
            return Column(
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
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
