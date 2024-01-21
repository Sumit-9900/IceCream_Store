import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_pro/product_store/models/app_state_model.dart';
import 'package:store_pro/product_store/widgets/product_item.dart';

class IceCreamView extends StatelessWidget {
  const IceCreamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IceCreams'),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // Provider.of<AppStateModel>(context)
        //     },
        //     icon: const Icon(Icons.dark_mode),
        //   ),
        //   const SizedBox(width: 25),
        // ],
      ),
      body: Consumer<AppStateModel>(
        builder: (context, value, child) {
          final products = value.getProducts();
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) => ProductItem(
              icecreams: products[index],
            ),
          );
        },
      ),
    );
  }
}
