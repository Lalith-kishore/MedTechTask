import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_tech/Model/global.dart' as global;

class ProductShow extends StatefulWidget {
  const ProductShow({Key? key}) : super(key: key);

  @override
  State<ProductShow> createState() => _ProductShowState();
}

class _ProductShowState extends State<ProductShow> {
  bool isEdit = true;
  bool  isWish=false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text("Product Detail"),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {

                          setState(() {
                            isWish=!isWish;
                          });
                        },
                        child: Container(
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.green,
                                )),
                            child: global.wishlist || isWish
                                ? const Icon(
                                    Icons.favorite,
                                    size: 35.0,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    size: 35.0,
                                    color: Colors.green,
                                  )),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isEdit = !isEdit;
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.red,
                                )),
                            child: const Icon(
                              Icons.edit,
                              size: 35.0,
                              color: Colors.red,
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 300,
                  height: 400,
                  child: Image.network(global.imageUrl),
                ),
                Container(child: Text(global.productName)),
                Container(
                  width: 40,
                  height: 25,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text("1"+
                      global.productWeightType,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                Container(
                  child: Row(
                    children: [
                      isEdit
                          ? RaisedButton(
                        onPressed: () {
                          setState(() {
                            isEdit = !isEdit;
                          });
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Text("Add"),
                      )
                          : Container(
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {});
                              },
                              color: Colors.green,
                            ),
                            Text("1"),
                            IconButton(
                              icon: Icon(Icons.add),
                              color: Colors.green,
                              onPressed: () {
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),

                      Container(
                        child: Text("₹" +global.productPrice),
                      ),
                    ],
                  ),
                ),

                Container(child: Text("About this Product")),
                Container(
                  child: Text(
                    global.desc,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
