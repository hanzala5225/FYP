import 'package:cached_network_image/cached_network_image.dart';
import 'package:rental_app/utils/loading.dart';

import '../common_imports/common_libs.dart';

class CachedRectangularNetworkImageWidget extends StatelessWidget {
  const CachedRectangularNetworkImageWidget({
    super.key,
    required this.image,
    required this.width,
    required this.height, this.fit,
  });

  final String image;
  final int width;
  final int height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.r),
            image: DecorationImage(image: imageProvider, fit:fit?? BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => const Center(child: LoadingWidget()),
        errorWidget: (context, url, error) => Center(
            child: SizedBox(
                width: 20.w, height: 20.h, child: const Icon(Icons.error))),
      ),
    );
  }
}
