
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.borderRadius = 0,
  }) : super(key: key);
  final String? imageUrl;
  final BoxFit? fit;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
  
      return _cachedImage();
    
  }

  Widget _cachedImage() {
    return imageUrl != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius!),
            child: CachedNetworkImage(
              imageUrl:imageUrl!,
              fit: fit,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          )
        : const SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
          );
  }
}
