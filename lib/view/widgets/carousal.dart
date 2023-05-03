import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerc_app/models/home_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../colors.dart';

class ItemCardList extends StatefulWidget {
  ItemCardList({super.key, required this.title, required this.itemsList});

  String title;
  List itemsList;

  @override
  State<ItemCardList> createState() => _ItemCardListState();
}

class _ItemCardListState extends State<ItemCardList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Features products
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  '${widget.title}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('View More')));
                  },
                  icon: const Icon(
                    Icons.arrow_right,
                    size: 30,
                  ))
            ],
          ),
          CarouselSlider.builder(
            options: CarouselOptions(height: 200, autoPlay: true),
            itemCount: widget.itemsList.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    InkWell(
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('${itemIndex + 1}')));
              },
              child: Ink(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.itemsList[itemIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: MyColor.baseColor2,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
