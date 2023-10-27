import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_api/model/product_res_model.dart';
import 'package:get_api/widget/BuildAppBar.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductReModel product;
  const ProductDetailScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: buildAppBar(product, context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) =>
                  const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                  strokeWidth: 2,
                ),
              ),
              imageUrl: product.image.toString(),
              width: media.width,
              fit: BoxFit.fill,
              height: 235,
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Container(
              width: double.maxFinite,
              height: media.height * 0.5,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 20),
                          Expanded(
                            child: Text(
                              product.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  letterSpacing: 3),
                            ),
                          ),
                          Text(
                            "\$${product.price.toString()}",
                            style: const TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 17,
                                fontFamily: "Metropolis",
                                fontWeight: FontWeight.w800,
                                letterSpacing: 3),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ReadMoreText(
                              "${product.description} ",
                              trimLines: 6,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 2),
                              colorClickableText: Colors.pink,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: 'Show less',
                              lessStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.redAccent),
                              moreStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.redAccent),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
