import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'API_calls/CartController.dart';
import 'API_calls/kartDetailsService.dart';
import 'Model/FetchCartModel.dart';
import 'Widget/Badge.dart';
import 'Widget/Cart.dart';
import 'Widget/ProductShow.dart';

import 'Model/global.dart' as global;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'daily Fresh'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FetchCartModel? _productDataList;
  FetchCartModel? _productDetails;
  late List<bool> pressedAttentions =
      _productDataList!.productDetails.map((e) => false).toList();

  @override
  void initState() {
    getKartDetails().whenComplete(() {
      setState(() {
        if (_productDetails != null) {
          _productDataList = _productDetails;
        }
      });
    });

    super.initState();
  }

  getKartDetails() async {
    debugPrint('Enter getDashboard');
    try {
      _productDetails = (await KartDetailsService.getData());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final cartController = Get.put(CartController());
  int NotificationCount = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("daily Fresh"),
            actions: <Widget>[
              GetX<CartController>(builder: (controller) {
                return Badge(
                    top: 8,
                    right: 8,
                    value: cartController.count.toString(),
                    child: IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  CartPage(cartController.cartItems,cartController.cartItemsPrice),
                              ),
                            );

                          });
                        }));
              }),
            ],
            backgroundColor: Colors.green,
            elevation: 50.0,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              tooltip: 'Menu Icon',
              onPressed: () {},
            ),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          body: _productDataList?.productDetails != null
              ? GestureDetector(
                  child: Container(
                      padding:const  EdgeInsets.all(12.0),
                      child: GridView.builder(
                        itemCount: _productDataList!.productDetails.isNotEmpty
                            ? _productDataList!.productDetails.length
                            : 0,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20.0,
                                mainAxisSpacing: 20.0),
                        itemBuilder: (BuildContext context, int index) {
                          final pressAttention = pressedAttentions[index];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                global.productWeightType = _productDataList!
                                    .productDetails[index]
                                    .productList![0]
                                    .productWeightType;
                                global.imageUrl = _productDataList!
                                    .productDetails[index].productSmallImg;
                                global.productName = _productDataList!
                                    .productDetails[index].productname;

                                global.wishlist = _productDataList!
                                    .productDetails[index].wishlistFlag;

                                global.desc = _productDataList!
                                    .productDetails[index].productDescription;

                                global.productPrice = _productDataList!
                                    .productDetails[index]
                                    .productList![0]
                                    .productMrp;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProductShow(),
                                  ),
                                );
                              });
                            },
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    height: 85,
                                    width: 100,
                                    child: Stack(
                                      children: <Widget>[
                                        Image.network(_productDataList!
                                            .productDetails[index]
                                            .productSmallImg),
                                        Container(
                                          width: 80,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${_productDataList!.productDetails[index].discountValue}% Off",
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Text(_productDataList!
                                        .productDetails[index].productname),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "1" +
                                            _productDataList!
                                                .productDetails[index]
                                                .productList![0]
                                                .productWeightType,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Text("₹" +
                                            _productDataList!
                                                .productDetails[index]
                                                .productList![0]
                                                .productMrp),
                                      ),
                                      pressedAttentions[index] == false
                                          ? RaisedButton(
                                              onPressed: () {
                                                setState(() {
                                                  pressedAttentions[index] =
                                                      !pressAttention;
                                                  cartController.addToCart(
                                                      _productDataList!
                                                              .productDetails![
                                                          index]);

                                                  cartController.addToCartPriceDetails(
                                                      _productDataList!
                                                          .productDetails[index]
                                                          .productList![0]
                                                  );
                                                });
                                              },
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.black,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
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
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                )
              : Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.only(top: 20),
                  child: const CircularProgressIndicator(
                    value: 0.8,
                  ))),
    );
  }
}
