import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/const_file.dart';


class PetCategories extends StatefulWidget {
  int selectedCategory=0;

  PetCategories(this.selectedCategory);

  @override
  _PetCategoriesState createState() => _PetCategoriesState();
}

class _PetCategoriesState extends State<PetCategories> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedCategory = index;
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: customShadowBox,
                      border: widget.selectedCategory == index
                          ? Border.all(
                        color: secondaryGreen,
                        width: 2,
                      )
                          : null,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      categories[index]['iconPath'],
                      scale: 1.8,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  categories[index]['name'],
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}