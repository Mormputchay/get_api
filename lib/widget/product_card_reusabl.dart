import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_api/product_details.dart';

import '../model/product_res_model.dart';

class ProductCardReusable extends StatelessWidget {
  final ProductReModel product;
  const ProductCardReusable({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                        product: product,
                      )));
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 3,
                        color: Colors.grey,
                        offset: Offset(0, 0)),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 13),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, progress) =>
                            const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                            strokeWidth: 2,
                          ),
                        ),
                        imageUrl: product.image.toString(),
                        height: media.width * 0.3,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            product.title.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product.description.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product.category.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RatingBar.builder(
                                initialRating: 4,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 10.5,
                                itemPadding: const EdgeInsets.symmetric(
                                    horizontal: 0.75),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.pinkAccent,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              const SizedBox(width: 8),
                              Text(
                                product.rating.rate.toString(),
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.pinkAccent,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "\$${product.price}".toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.pinkAccent,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 70,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Colors.pinkAccent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(13),
                                  bottomRight: Radius.circular(13))),
                          child: const Text(
                            "Add",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
