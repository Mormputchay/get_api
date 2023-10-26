import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../model/product_res_model.dart';

class APIHelper {
  static Future<List<ProductReModel>> getProduct(BuildContext context) async {
    try {
      final response =
          await http.get(Uri.parse("https://fakestoreapi.com/products"));
      final data = jsonDecode(response.body);
      log("data : $data");
      return data
          .map<ProductReModel>((e) => ProductReModel.fromJson(e))
          .toList();
    } catch (e) {
      print("error: $e");
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'error : $e',
      );
      rethrow;
    }
  }

  static Future<List<ProductReModel>> getProductByCategory(
      BuildContext context, String categoryName) async {
    try {
      String url = "https://fakestoreapi.com/products/category/$categoryName";
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      log("data : $data");
      return data
          .map<ProductReModel>((e) => ProductReModel.fromJson(e))
          .toList();
    } catch (e) {
      print("error: $e");
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'error : $e',
      );
      rethrow;
    }
  }

  static Future<List<String>> getProductCategory(BuildContext context) async {
    try {
      String url = "https://fakestoreapi.com/products/categories";
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      print("dataCategory:  $data");
      return data.map<String>((e) => e.toString()).toList();
    } catch (e) {
      print("error: $e");
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'error : $e',
      );
      rethrow;
    }
  }
}
