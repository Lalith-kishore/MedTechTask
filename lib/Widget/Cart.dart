import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {

  var cartItems;
  var cartItemsPriceList;

  CartPage(this.cartItems,this.cartItemsPriceList);

  @override
  State<CartPage> createState() => CartState(this.cartItems,this.cartItemsPriceList);
}

class CartState extends State<CartPage> {

  var cartItems;
  var cartItemsPriceList;

  CartState(this.cartItems,this.cartItemsPriceList);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title:
                  Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Text(cartItems[index].productId.toString()),
                      ),
                      Container(
                        child: Text(cartItems[index].productname.toString()),
                      ),
                      Container(
                        child: Text(cartItemsPriceList[index].productMrp.toString()),
                      ),
                      SizedBox(height:40),

                    ],
                  )



                  /*Row(

                    children: [
                      Container(
                        child: Text(cartItems[index].productId.toString()),
                      ),

                    ],
                  )*/);

                 /* *//*Text(
                        cartItems[index].productId.toString(),*//*
                  *//* style: TextStyle(color: Colors.green, fontSize: 15),*//*
                )
                ,
                title: Text("List item $index"));*/
              }),

        ),
      ),
    );
  }
}
