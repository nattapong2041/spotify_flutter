import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppUrlImage extends StatelessWidget {
  const AppUrlImage(
    this.imagePath, {
    super.key,
    this.height,
    this.width,
    this.fit,
    this.radius,
  });

  final String imagePath;
  final int? height;
  final int? width;
  final BoxFit? fit;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius == null
            ? null
            : BorderRadius.all(
                Radius.circular(radius!),
              ),
      ),
      child: CachedNetworkImage(
        imageUrl: imagePath,
        fit: fit ?? BoxFit.fitHeight,
        height: height?.toDouble(),
        width: width?.toDouble(),
        memCacheHeight: height,
        memCacheWidth: width,
        fadeInDuration: const Duration(milliseconds: 100),
        placeholder: (context, url) => Container(
          height: height?.toDouble(),
          width: width?.toDouble(),
          color: Theme.of(context).colorScheme.primary,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

class AppAssetImage extends StatelessWidget {
  const AppAssetImage(
    this.imagePath, {
    super.key,
    this.height,
    this.width,
    this.fit,
    this.radius,
  });

  final String imagePath;
  final int? height;
  final int? width;
  final BoxFit? fit;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: fit ?? BoxFit.cover,
        ),
        color: Theme.of(context).colorScheme.primary,
        borderRadius: radius == null
            ? null
            : BorderRadius.all(
                Radius.circular(radius!),
              ),
      ),
    );
  }
}
