import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/extension/app_constant.dart';
import '../../../common/widget/app_image.dart';
import 'bloc/playlist_detail_bloc.dart';

part 'widget/_add_track_bottomsheet.dart';

class PlaylistDetailScreen extends StatelessWidget {
  final String id;
  final String userId;
  const PlaylistDetailScreen({super.key, required this.id, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<PlaylistDetailBloc, PlaylistDetailState>(
          builder: (context, state) {
            return Text(switch (state) {
              PlaylistDetailLoaded() => state.data.title,
              _ => 'ไม่พบข้อมูล',
            });
          },
        ),
      ),
      floatingActionButton: userId == 'me' ? FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              showDragHandle: true,
              builder: (_) {
                return _AddTrackBottomsheet(
                  onAddTrack: (uri) {
                    context.read<PlaylistDetailBloc>().add(AddTrackToPlaylist(
                          playlistId: id,
                          uri: uri,
                        ));
                    context.read<PlaylistDetailBloc>().add(GetPlaylistDetail(id));
                  },
                );
              });
        },
        child: const Icon(Icons.add),
      ) : null,
      body: LayoutBuilder(builder: (context, constraints) {
        return BlocBuilder<PlaylistDetailBloc, PlaylistDetailState>(
          builder: (context, state) {
            if (state is PlaylistDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PlaylistDetailLoaded) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    stretch: true,
                    expandedHeight: state.data.image != null ? 300 : 0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: state.data.image != null
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: AppUrlImage(state.data.image!, width: 200, height: 200),
                            )
                          : null,
                      expandedTitleScale: 1,
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (state.data.owner != null)
                            Text(
                              state.data.owner!,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          if (state.data.genres.isNotEmpty)
                            Text(
                              state.data.genres.join(', '),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                        ],
                      ),
                    ),
                  ),
                  SliverList.separated(
                    itemCount: state.data.tracks.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: AppConstant.paddingMedium,
                    ),
                    itemBuilder: (context, index) {
                      final track = state.data.tracks[index];
                      return ListTile(
                        title: Text(track.name),
                        subtitle: Text(
                          '${track.duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${track.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                        ),
                      );
                    },
                  ),
                ],
              );
            } else if (state is PlaylistDetailError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('ไม่พบข้อมูล'));
            }
          },
        );
      }),
    );
  }
}
