import 'package:flutter/material.dart';

import '../model/product_res_model.dart';

AppBar buildAppBar(ProductReModel product, BuildContext context) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: Text(
      product.title,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.white,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 28,
        color: Colors.black,
      ),
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopping_bag_outlined,
            color: Colors.black,
            size: 28,
          ))
    ],
  );
}
