import 'package:flutter/material.dart';
import 'package:store_pro/themes/styles.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.search),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              style: Styles.searchtext,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: controller.clear,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
