import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/extension/app_constant.dart';
import '../../../common/widget/app_image.dart';
import 'bloc/album_detail_bloc.dart';

class AlbumDetailScreen extends StatelessWidget {
  const AlbumDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AlbumDetailBloc, AlbumDetailState>(
          builder: (context, state) {
            return Text(switch (state) {
              AlbumDetailLoaded() => state.data.title,
              _ => 'ไม่พบข้อมูล',
            });
          },
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return BlocBuilder<AlbumDetailBloc, AlbumDetailState>(
          builder: (context, state) {
            if (state is AlbumDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AlbumDetailLoaded) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    stretch: true,
                    expandedHeight: 300,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: AppUrlImage(state.data.image, width: 200, height: 200),
                      ),
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
            } else if (state is AlbumDetailError) {
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
