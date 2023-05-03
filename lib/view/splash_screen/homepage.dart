import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:ecommerc_app/colors.dart';
import 'package:ecommerc_app/models/home_content.dart';
import 'package:ecommerc_app/view/widgets/carousal.dart';
import 'package:ecommerc_app/view/widgets/suggested.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../root.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List list = [];

  var colors = Color.fromARGB(255, 255, 179, 173);

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    list = [];
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'My Cart',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        unselectedItemColor: MyColor.baseColor3,
        selectedItemColor: MyColor.baseColor4,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              height: 60,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: MyColor.baseColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('App Bar')));
                      },
                      child: const CircleAvatar(
                        child: Icon(Icons.person_2_rounded),
                      ),
                    ),
                  ),
                  const Expanded(
                      child: Text(
                    'ShopCart',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                  IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Search View')));
                      },
                      icon: const Icon(Icons.search)),
                  IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('View More')));
                      },
                      icon: const Icon(Icons.more_vert))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'All Categories',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                      itemCount: HomeContent.categoryList.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(5),
                      itemBuilder: (context, i) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          width: 100,
                          height: 100,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  HomeContent.categoryList[i]['ImageUrl'],
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    HomeContent.categoryList[i]['cName'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          ItemCardList(
            title: '✨ Deals On The Way',
            itemsList: HomeContent.dealList,
          ),
          ItemCardList(
            title: '🌟 Top Rated Products',
            itemsList: HomeContent.topRatedList,
          ),
          SuggestedItem(
            title: '📌 Top Selection For You',
            list: HomeContent.topSelection,
          ),
          SuggestedItem(
            title: '🏠 Best Deals On Furniture',
            list: HomeContent.bestDeals,
          ),
        ],
      ),
    );
  }

  Future<void> fetchProducts() async {
    try {
      const String url = 'http://10.0.2.2:5062/api/ProductItems';
      // const String url = 'http://localhost:5062/api/ProductItems';
      Uri uri = Uri.parse(url);

      Dio dio = Dio();
      var json = await dio.get(url);
      List items = json.data;
      setState(() {
        list = items;
      });
    } catch (err) {
      print(err.toString());
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

/*
Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            child: Image.network(
                              "${list[i]['ImageUrl']}",
                              fit: BoxFit.contain,
                              height: 200,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            child: Center(
                              child: Container(
                                height: 100,
                                color: const Color.fromARGB(179, 230, 230, 230),
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      list[i]['ProductName'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    Text(
                                      '₹ ${list[i]['Price']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.red),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                foregroundColor: Colors.white),
                                            onPressed: () {},
                                            child: const Text(
                                              'Buy Now',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.shopping_cart,
                                              color: Colors.red,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
*/
