import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerc_app/api/api.services.dart';
import 'package:ecommerc_app/colors.dart';
import 'package:ecommerc_app/view/screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetails extends StatefulWidget {
  var productData;

  ProductDetails({super.key, this.productData});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int cartCount = 0;
  String selectedImg = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartCount = Api.myCartItemCount;
    selectedImg = "";
  }

  @override
  Widget build(BuildContext context) {
    fetchCartCount();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (content) => const CartScreen()));
              setState(() {
                selectedImg = "";
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 15, left: 15),
              child: Center(
                child: badges.Badge(
                  badgeAnimation: const badges.BadgeAnimation.scale(),
                  badgeContent: Text(
                    cartCount.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  child: const Icon(Icons.shopping_cart),
                ),
              ),
            ),
          )
        ],
      ),
      body: Scrollbar(
        thickness: 5,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            selectedImg.trim() == ""
                ? CarouselSlider.builder(
                    itemCount: widget.productData['Images'].length,
                    itemBuilder: (BuildContext context, itemIndex, pageIndex) {
                      return Container(
                          margin: const EdgeInsets.all(20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              widget.productData['Images'][itemIndex],
                              fit: BoxFit.contain,
                            ),
                          ));
                    },
                    options: CarouselOptions(
                        height: 300,
                        autoPlay: true,
                        enableInfiniteScroll: true))
                : Container(
                    height: 260,
                    margin: const EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        selectedImg,
                        fit: BoxFit.contain,
                      ),
                    )),
            Container(
                height: 80,
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.productData['Images'].length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 60,
                      mainAxisExtent: 60,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: MyColor.baseColor2, blurRadius: 5)
                          ],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: MyColor.baseColor3,
                              width: 1.0,
                              style: BorderStyle.solid)),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedImg = widget.productData['Images'][index];
                          });
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            widget.productData['Images'][index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                )),
            Container(
              margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
              child: const Text(
                'Colors',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
            ),
            Container(
              height: 35,
              margin: const EdgeInsets.only(bottom: 10, left: 25),
              child: Row(
                children: [
                  InkWell(
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Colors.red,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Colors.blue,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Colors.green,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Colors.orange,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: MyColor.baseColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productData['ProductName'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '₹ ${Api.currencyFormat.format(widget.productData['MRP'])}/-',
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Free Delivery Available',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue),
                              child: const Center(
                                child: Text(
                                  'Buy Now',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            addToCart();
                          },
                          child: Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.orange),
                              child: const Center(
                                child: Text(
                                  'ADD TO CART',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'About Product:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${widget.productData['Details']}')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void addToCart() async {
    await Api.addCartItem(widget.productData, true);
  }

  void fetchCartCount() async {
    await Api.fetchCartItems();
    setState(() {
      cartCount = Api.myCartItemCount;
    });
  }
}
