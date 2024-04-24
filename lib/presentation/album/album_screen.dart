import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../common/routes/app_router.dart';
import '../../common/widget/app_image.dart';
import 'bloc/album_bloc.dart';

part 'widget/_album_list_tile.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final _scrollController = ScrollController();
  final _textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.7) {
        context.read<AlbumBloc>().add(const SearchAlbumEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AlbumBloc>().add(const SearchAlbumEvent(shouldRefresh: true));
        },
        child: CustomScrollView(controller: _scrollController, slivers: [
          SliverAppBar(
            title: TextField(
              controller: _textController,
              decoration: InputDecoration(
                  hintText: 'ค้นหาอัลบั๊ม',
                  suffixIcon: IconButton(
                      onPressed: () {
                        _textController.clear();
                        context.read<AlbumBloc>().add(const SearchAlbumEvent(query: ''));
                      },
                      icon: const Icon(Icons.clear))),
              onChanged: (value) {
                context.read<AlbumBloc>().add(SearchAlbumEvent(query: value, shouldRefresh: true));
              },
            ),
            floating: true,
            snap: true,
            pinned: true,
          ),
          BlocBuilder<AlbumBloc, AlbumState>(
            builder: (context, state) {
              if (state is AlbumInitial) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height -
                        kToolbarHeight -
                        kBottomNavigationBarHeight -
                        100,
                    child: const Center(
                      child: Text("ค้นหาอัลบั๊มที่ต้องการ..."),
                    ),
                  ),
                );
              } else if (state is AlbumLoading) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height -
                        kToolbarHeight -
                        kBottomNavigationBarHeight -
                        100,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              } else if (state is AlbumLoaded) {
                return SliverList.builder(
                  itemCount: state.data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.data.length) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return _AlbumListTile(
                      image: state.data[index].coverImage,
                      title: state.data[index].title,
                      owner: state.data[index].owner,
                      description: state.data[index].description,
                      onTap: () {
                        context.goNamed(ScreenPaths.albumDetail, pathParameters: {
                          'id': state.data[index].id,
                        });
                      },
                    );
                  },
                );
              } else if (state is AlbumError) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height -
                        kToolbarHeight -
                        kBottomNavigationBarHeight -
                        100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.message),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<AlbumBloc>()
                                  .add(const SearchAlbumEvent(shouldRefresh: true));
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ]),
      ),
    );
  }
}
