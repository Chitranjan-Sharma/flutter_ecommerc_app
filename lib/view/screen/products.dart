import 'package:ecommerc_app/colors.dart';
import 'package:ecommerc_app/view/screen/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../api/api.services.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List productList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
        elevation: 2,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: 60,
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.filter_alt)),
                Container(
                  decoration: BoxDecoration(
                      color: MyColor.baseColor,
                      borderRadius: BorderRadius.circular(15)),
                  width: 250,
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: const TextField(
                    decoration: InputDecoration(
                        hintText: 'Search....', border: InputBorder.none),
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: productList.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => ProductDetails(
                                    productData: productList[i],
                                  )));
                    },
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      height: 200,
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.network(
                            productList[i]['Images'][0],
                            fit: BoxFit.contain,
                            width: 180,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productList[i]['ProductName'],
                                  maxLines: 2,
                                ),
                                Text(
                                  "₹ ${productList[i]['MRP']}/-",
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: MyColor.baseColor4),
                                        width: 80,
                                        height: 40,
                                        child: const Center(
                                            child: Text(
                                          'BUY',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            await Api.addCartItem(
                                                productList[i], true);
                                          },
                                          icon: const Icon(
                                            Icons.add_shopping_cart,
                                            color: Colors.red,
                                          ))
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
        ],
      ),
    );
  }

  void getProducts() async {
    List pList = await Api.fetchProducts(context);
    setState(() {
      productList = pList;
    });
  }
}
