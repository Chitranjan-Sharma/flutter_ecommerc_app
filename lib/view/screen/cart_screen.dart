import 'dart:ffi';

import 'package:ecommerc_app/api/api.services.dart';
import 'package:ecommerc_app/colors.dart';
import 'package:ecommerc_app/view/screen/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:dio/dio.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    cartProducts = [];
    getProductsList();
    totalAmount = 0;
  }

  List cartProducts = [];
  double totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    getProductsList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
              child: Api.myCartProducts.isNotEmpty
                  ? Scrollbar(
                      thickness: 5,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: cartProducts.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (content) => ProductDetails(
                                //               productData: cartProducts[i],
                                //             )));
                              },
                              child: Container(
                                color: Colors.white,
                                margin:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                height: 200,
                                child: Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.network(
                                      cartProducts[i]['Item']['Images'][0],
                                      fit: BoxFit.contain,
                                      width: 180,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartProducts[i]['Item']
                                                ['ProductName'],
                                            maxLines: 2,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "₹ ${Api.currencyFormat.format(cartProducts[i]['Item']['MRP'])}/-",
                                            style: const TextStyle(
                                                fontSize: 25,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${cartProducts[i]['Qty']} : Qty',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    getCartProductList(
                                                        i,
                                                        cartProducts[i]['Item'],
                                                        false);
                                                  },
                                                  child: const Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    getCartProductList(
                                                        i,
                                                        cartProducts[i]['Item'],
                                                        true);
                                                  },
                                                  child: const Icon(
                                                    Icons.add_circle,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () async {
                                                            removeProductFromCart(
                                                                cartProducts[i]
                                                                        ['Item']
                                                                    ['_id']);
                                                          },
                                                          icon: const Icon(
                                                            Icons.close_rounded,
                                                            color: Colors.red,
                                                          ))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            );
                          }),
                    )
                  : Center(
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                getProductsList();
                              },
                              icon: const Icon(Icons.refresh)),
                          const Text(
                            'Press button to refresh',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    )),
          Container(
            padding: const EdgeInsets.all(5),
            color: MyColor.baseColor,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Text(
                      'Total : ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "₹ ${Api.currencyFormat.format(totalAmount)}/-",
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 0, 0)),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'CHECK OUT',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.red),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  getCartProductList(int index, productData, bool response) async {
    await Api.addCartItem(productData, response);
    getProductsList();
  }

  getProductsList() {
    setState(() {
      cartProducts = Api.myCartProducts;
      totalAmount = Api.totalAmount;
    });
  }

  void removeProductFromCart(id) async {
    await Api.deleteCartItem(id);
    getProductsList();
  }
}
