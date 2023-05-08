import 'dart:io';
import 'package:intl/intl.dart';
import 'package:ecommerc_app/models/home_content.dart';
import 'package:ecommerc_app/view/screen/cart_screen.dart';
import 'package:ecommerc_app/view/screen/login_screen.dart';
import 'package:ecommerc_app/view/splash_screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/user.model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class Api {
 static final currencyFormat = NumberFormat("#,##0.00");
  static const String baseUrl = "http://10.0.2.2:3000/api/users";
  static Dio dio = Dio();
  static var currentUser = {};
  static List allUserList = [];

  static String email = "";
  static String password = "";

  static List products = [];
  static int myCartItemCount = 0;
  static List myCartProducts = [];
  static double totalAmount = 0;

  static Future<List> fetchProducts(var con) async {
    try {
      products = [];
      var res = await dio.get("http://10.0.2.2:3000/api/products");

      List list = await res.data['data'];

      if (res.statusCode == 200) {
        products = list;
        fetchCartItems();
      }
    } catch (error) {
      ScaffoldMessenger.of(con).showSnackBar(SnackBar(content: Text('$error')));
    }

    return products;
  }

  static void fetchUsers(var context) async {
    try {
      var res = await dio.get(baseUrl);

      List list = await res.data['data'];

      if (res.statusCode == 200) {
        allUserList = list;

        for (var e in list) {
          if (e['Email'] == email && e['Password'] == password) {
            currentUser = e;
            Navigator.push(context,
                MaterialPageRoute(builder: (content) => const SplashScreen()));
            HomeContent.isLoggedIn = true;
            fetchCartItems();
          }
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$error')));
    }
  }

  static void postUser(UserModel userModel, var context) async {
    try {
      var res = await dio.post(baseUrl, data: userModel.toMap());

      if (res.statusCode == 201) {
        Navigator.push(context,
            MaterialPageRoute(builder: (content) => const LoginScreen()));
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$error')));
    }
  }

  static Future addCartItem(productData, bool response) async {
    try {
      int qty = 0;
      if (response) {
        qty = 1;
      } else {
        qty = -1;
      }

      await dio.post('http://10.0.2.2:3000/api/carts', data: {
        'UserId': currentUser['_id'],
        'ProductId': productData['_id'],
        'Qty': qty
      });
      fetchCartItems();
    } catch (error) {
      print(error);
    }
  }

  static Future<void> fetchCartItems() async {
    try {
      var res = await dio.get('http://10.0.2.2:3000/api/carts');
      List list = res.data['data'];
      myCartItemCount = 0;
      totalAmount = 0;
      myCartProducts = [];
      for (var e in list) {
        if (currentUser['_id'] == e['UserId'] && e['Qty'] > 0) {
          myCartItemCount += 1;

          for (var p in products) {
            if (p['_id'] == e['ProductId']) {
              var cartProduct = {'Item': p, 'Qty': e['Qty']};

              if (e['Qty'] > 0) {
                myCartProducts.add(cartProduct);
                totalAmount = totalAmount + p['MRP'] * e['Qty'];
              }
            }
          }
        } else {
          await dio.delete('http://10.0.2.2:3000/api/carts/${e['_id']}');
        }
      }
    } catch (error) {
      print(error);
    }
  }

  static Future<void> deleteCartItem(id) async {
    try {
      var res = await dio.get('http://10.0.2.2:3000/api/carts');
      List list = res.data['data'];
      for (var cart in list) {
        if (cart['UserId'] == currentUser['_id'] && cart['ProductId'] == id) {
          await http.delete(
              Uri.parse('http://10.0.2.2:3000/api/carts/${cart['_id']}'));
          fetchCartItems();
        }
      }
    } catch (error) {
      print(error);
    }
  }
}
