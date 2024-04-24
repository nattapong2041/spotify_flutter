part of '../album_screen.dart';

class _AlbumListTile extends StatelessWidget {
  final String? image;
  final String title;
  final String? owner;
  final String? description;
  final VoidCallback? onTap;

  const _AlbumListTile(
      {super.key,
      required this.image,
      required this.title,
      this.owner,
      this.description,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AppUrlImage(
        image!,
        width: 50,
        height: 50,
      ),
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: owner != null ? Text(owner!) : null,
      onTap: onTap,
    );
  }
}
