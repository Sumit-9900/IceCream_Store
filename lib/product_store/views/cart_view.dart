import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:store_pro/product_store/models/app_state_model.dart';
import 'package:store_pro/product_store/widgets/cart_item.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? mobile;
  String? address;
  DateTime? dateTime = DateTime.now();

  Future<void> _showDialog() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      initialDate: now,
      lastDate: lastDate,
    );
    setState(() {
      if (pickedDate != null) {
        dateTime = pickedDate;
      } else {
        return;
      }
    });
  }

  String formattedDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Consumer<AppStateModel>(
        builder: (context, value, child) {
          final formattedtotalPrice = NumberFormat.currency(
            locale: 'en_IN',
            symbol: '',
          ).format(value.totalCost);

          final formattedshippingPrice = NumberFormat.currency(
            locale: 'en_IN',
            symbol: '',
          ).format(value.shippingCost);

          final formattedtaxPrice = NumberFormat.currency(
            locale: 'en_IN',
            symbol: '',
          ).format(value.tax);

          return ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 8,
                  bottom: 4,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Chip(
                    label: Row(
                      children: [
                        Icon(Ionicons.bulb_outline),
                        SizedBox(width: 5),
                        Text(
                          'Make sure to add the address details.',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ExpansionTile(
                title: const Text('Address Details'),
                children: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 22, right: 22, top: 22),
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter a valid Name';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              name = newValue;
                            },
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person_outline),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 32),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter a valid Email-address';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              email = newValue;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 32),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter a valid Phone number';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              mobile = newValue;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                              prefixIcon: Icon(Icons.phone_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 32),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter a valid Address';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              address = newValue;
                            },
                            keyboardType: TextInputType.streetAddress,
                            decoration: const InputDecoration(
                              labelText: 'Address',
                              prefixIcon: Icon(Ionicons.location_outline),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              IconButton(
                                onPressed: _showDialog,
                                icon: const Icon(Icons.calendar_month_outlined),
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: formattedDate(dateTime!),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 5,
                                    ),
                                    border: const UnderlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              if (value.productsInCart.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.productsInCart.length,
                  itemBuilder: (ctx, index) {
                    final productId = value.productsInCart.keys.toList()[index];
                    return CartItem(
                      icecreams: value.getProductById(productId),
                      quantity: value.productsInCart.values.toList()[index],
                      onPressedDelete: () {
                        value.removeItemFromCart(productId);
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Item has been deleted!'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                value.addProductToCart(productId);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              else
                const SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Uh...oh! No item added in your cart.\n Try to add some!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 8,
                ),
                child: value.productsInCart.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Shipping + Tax',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '₹ $formattedshippingPrice + $formattedtaxPrice',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 8,
                ),
                child: value.productsInCart.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '₹ $formattedtotalPrice',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
              if (value.productsInCart.isNotEmpty) const Divider(),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 125),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState != null &&
                        formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (value.productsInCart.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Order Placed Succesfully!'),
                          ),
                        );
                        value.clearCart();
                      } else {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Try to add the product!'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Place Order'),
                ),
              ),
              const SizedBox(height: 25),
            ],
          );
        },
      ),
    );
  }
}
