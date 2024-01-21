import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_pro/product_store/models/app_state_model.dart';
import 'package:store_pro/product_store/widgets/mysearch_bar.dart';
import 'package:store_pro/product_store/widgets/product_item.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String query = '';
  late final TextEditingController controller;
  late final FocusNode focusNode;

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: MySearchBar(
        controller: controller,
        focusNode: focusNode,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: query)
      ..addListener(() {
        setState(() {
          query = controller.text;
        });
      });
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateModel>(context);
    final filterredProducts = model.search(query);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: SafeArea(
        child: DecoratedBox(
          decoration: const BoxDecoration(
              // color: Colors.white,
              ),
          child: Column(
            children: [
              _buildSearchBar(),
              Expanded(
                child: ListView.builder(
                  itemCount: filterredProducts.length,
                  itemBuilder: (context, index) => ProductItem(
                    icecreams: filterredProducts[index],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
