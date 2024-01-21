import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_pro/product_store/models/app_state_model.dart';
import 'package:store_pro/product_store/models/icecream.dart';
import 'package:store_pro/themes/styles.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.icecreams,
  });

  final Icecreams icecreams;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(icecreams.image!),
      ),
      title: Text(
        icecreams.name!,
        style: Styles.productRowItemName,
      ),
      subtitle: Text(
        '₹ ${icecreams.price}',
        style: Styles.productRowItemPrice,
      ),
      trailing: IconButton(
        onPressed: () {
          Provider.of<AppStateModel>(context, listen: false)
              .addProductToCart(icecreams.productId!);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product added to the cart!'),
            ),
          );
        },
        icon: const Icon(Icons.shopping_bag),
      ),
    );
  }
}
