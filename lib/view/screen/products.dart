import 'package:ecommerc_app/colors.dart';
import 'package:ecommerc_app/view/screen/cart_screen.dart';
import 'package:ecommerc_app/view/screen/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:badges/badges.dart' as badges;
import '../../api/api.services.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List productList = [];

  int cartCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getProducts('RL');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopCart'),
        elevation: 2,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (content) => const CartScreen()));
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            height: 60,
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      showMenu(
                          context: context,
                          position: RelativeRect.fill,
                          items: [
                            PopupMenuItem(
                                onTap: () {
                                  getProducts('LH');
                                },
                                child: const Text('Low to high')),
                            PopupMenuItem(
                                onTap: () {
                                  getProducts('HL');
                                },
                                child: const Text('High to low')),
                            PopupMenuItem(
                                onTap: () {
                                  getProducts('RL');
                                },
                                child: const Text('Relevance'))
                          ]);
                    },
                    icon: const Icon(Icons.filter_alt)),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: MyColor.baseColor,
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: 'Search....', border: InputBorder.none),
                    ),
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ],
            ),
          ),
          Expanded(
            child: Scrollbar(
              thickness: 5,
              child: GridView.builder(
                  padding: const EdgeInsets.all(5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 300,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5),
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.network(
                                  productList[i]['Images'][0],
                                  fit: BoxFit.contain,
                                  height: 150,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  productList[i]['ProductName'],
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "₹ ${Api.currencyFormat.format(productList[i]['MRP'])}/-",
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: const EdgeInsets.all(5),
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: MyColor.baseColor4),
                                      width: 60,
                                      height: 35,
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
                            ]),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  void getProducts(String sort) async {
    List pList = await Api.fetchProducts(context);
    List pCopy = pList;
    await Api.fetchCartItems();
    setState(() {
      cartCount = Api.myCartItemCount;

      switch (sort) {
        case 'LH':
          pList.sort((a, b) => a["MRP"].compareTo(b["MRP"]));
          setState(() {
            productList = pList;
          });
          break;
        case 'HL':
          pList.sort((a, b) => b["MRP"].compareTo(a["MRP"]));
          setState(() {
            productList = pList;
          });
          break;
        default:
          setState(() {
            productList = pCopy;
          });
      }
    });
  }
}
