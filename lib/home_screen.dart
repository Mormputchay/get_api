import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_api/model/product_res_model.dart';
import 'package:get_api/server/api_helper.dart';
import 'package:get_api/widget/product_card_reusabl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ProductReModel>> _productFuture;
  late Future<List<String>> _futureCategory;
  late List<ProductReModel> _listSearchProduct = [];
  late List<ProductReModel> listAllProducts = [];
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  String _searchKeyword = "";
  final TextEditingController searchController = TextEditingController();
  bool _isSearch = false;
  @override
  void initState() {
    _productFuture = APIHelper.getProduct(context);
    _futureCategory = APIHelper.getProductCategory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            elevation: 1,
            title: const Text(
              'Get X Build',
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Signatra'),
            ),
            centerTitle: true,
          ),
          body: _isSearch ? listSearchProducts() : listProducts()),
    );
  }

  Widget listProducts() {
    focusNode1.requestFocus();
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([_productFuture, _futureCategory]),
      builder: (context, snanshot) {
        if (snanshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SpinKitFadingCircle(
              size: 75,
              itemBuilder: (context, index) {
                final colors = [
                  Colors.pinkAccent,
                  Colors.redAccent,
                  Colors.blueAccent
                ];
                final color = colors[index % colors.length];
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: color,
                  ),
                );
              },
            ),
          );
        }
        if (snanshot.data == null) {
          return const Center(child: Text("No data"));
        }
        if (snanshot.data!.isEmpty) {
          return const Center(child: Text("Data Empty"));
        }
        listAllProducts = snanshot.data![0];
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        focusNode: focusNode1,
                        onChanged: (keyword) {
                          if (keyword.isEmpty) {
                            _isSearch = false;
                            setState(() {});
                          }
                          if (keyword.isNotEmpty) {
                            _searchKeyword = keyword;
                            _isSearch = true;
                            setState(() {});
                          }
                          _listSearchProduct = listAllProducts
                              .where((product) =>
                                  product.title.toLowerCase().contains(keyword))
                              .toList();
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.grey),
                            filled: true,
                            hintText: "Search product",
                            fillColor: Colors.grey[200],
                            hintStyle: TextStyle(color: Colors.grey[800])),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      _show(context, snanshot.data![1]);
                    },
                    child: Container(
                      height: 56,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: GridView.builder(
                      itemCount: snanshot.data![0].length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 360,
                              mainAxisExtent: 360),
                      itemBuilder: (context, index) {
                        final product = snanshot.data![0][index];
                        return ProductCardReusable(product: product);
                      }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget listSearchProducts() {
    //searchController.text = _searchKeyword;
    searchController.value = TextEditingValue(
        text: _searchKeyword,
        selection: TextSelection.collapsed(offset: _searchKeyword.length));
    focusNode2.requestFocus();

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    focusNode: focusNode2,
                    controller: searchController,
                    onChanged: (keyword) {
                      if (keyword.isEmpty) {
                        _isSearch = false;
                        setState(() {});
                      }
                      _searchKeyword = keyword;
                      _listSearchProduct = listAllProducts
                          .where((product) =>
                              product.title.toLowerCase().contains(keyword))
                          .toList();
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        filled: true,
                        hintText: "Search product",
                        fillColor: Colors.grey[200],
                        hintStyle: TextStyle(color: Colors.grey[800])),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _listSearchProduct.isNotEmpty
              ? Expanded(
                  child: SingleChildScrollView(
                    child: GridView.builder(
                        itemCount: _listSearchProduct.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 360,
                                mainAxisExtent: 360),
                        itemBuilder: (context, index) {
                          final product = _listSearchProduct[index];
                          return ProductCardReusable(product: product);
                        }),
                  ),
                )
              : const Center(
                  child: Text("No data"),
                )
        ],
      ),
    );
  }

  void _show(BuildContext context, List<String> lstCategory) {
    showModalBottomSheet(
        elevation: 4,
        backgroundColor: Colors.white,
        context: context,
        builder: (context) => Container(
              height: 300,
              color: Colors.white,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: lstCategory.length,
                      itemBuilder: (context, index) {
                        String categoryName = lstCategory[index];
                        return ListTile(
                          onTap: () async {
                            _productFuture = APIHelper.getProductByCategory(
                                context, categoryName);
                            setState(() {});
                            Navigator.pop(context);
                          },
                          leading: const Icon(Icons.category),
                          title: Text(lstCategory[index]),
                        );
                      },
                    ),
                    ListTile(
                      onTap: () async {
                        _productFuture = APIHelper.getProduct(context);
                        setState(() {});
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.category),
                      title: const Text('All'),
                    ),
                  ],
                ),
              ),
            ));
  }
}
