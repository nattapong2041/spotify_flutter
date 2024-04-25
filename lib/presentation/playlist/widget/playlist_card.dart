
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/extension/app_constant.dart';
import '../../../common/widget/app_image.dart';

class PlaylistCard extends StatelessWidget {
  final String? image;
  final String title;
  final String? owner;
  final String? description;
  final VoidCallback? onTap;

  const PlaylistCard(
      {super.key, required this.image, required this.title, this.owner, this.description, this.onTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return InkWell(
        onTap: onTap,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image != null)
                AppUrlImage(
                  image!,
                  width: constraints.maxWidth.toInt(),
                  height: constraints.maxWidth.toInt(),
                )
              else
                SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxWidth,
                  child: const Icon(
                    CupertinoIcons.music_note_list,
                    size: 48,
                    color: Colors.grey,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstant.paddingSmall),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (owner != null) ...[
                        Text(
                          'โดย: $owner',
                          style: Theme.of(context).textTheme.labelSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (description != null) ...[
                        const SizedBox(height: AppConstant.paddingSmall),
                        Flexible(
                          child: Text(
                            description!,
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
