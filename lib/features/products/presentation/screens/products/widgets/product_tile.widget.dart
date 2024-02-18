part of 'products_widgets.imports.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  const ProductTile({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title ?? ''),
      onTap: onTap,
      subtitle: Row(
        children: [
          Text( "Album Id : "),
          Text(product.albumId.toString() ?? '0'),
        ],
      ),
      leading:  CachedNetworkImage(
        imageUrl:product.thumbnailUrl ?? AppImages.failbackImage200,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),

    );
  }
}
