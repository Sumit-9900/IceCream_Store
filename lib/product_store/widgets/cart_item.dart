import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store_pro/product_store/models/icecream.dart';
import 'package:store_pro/themes/styles.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.icecreams,
    required this.quantity,
    required this.onPressedDelete,
  });

  final Icecreams icecreams;
  final int quantity;
  final void Function() onPressedDelete;

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
      subtitle: Row(
        children: [
          Text(
            quantity > 1 ? '$quantity * ' : '',
            style: Styles.productRowItemPrice,
          ),
          Text(
            '₹ ${icecreams.price}',
            style: Styles.productRowItemPrice,
          ),
        ],
      ),
      trailing: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '₹ ${icecreams.price! * quantity}',
              style: Styles.productRowItemName,
            ),
            IconButton(
              onPressed: onPressedDelete,
              icon: Icon(
                Icons.delete,
                color: Colors.red.withOpacity(0.90),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
