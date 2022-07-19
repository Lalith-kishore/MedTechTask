import 'package:flutter/cupertino.dart';



class FetchCartModel {
  List<ProductModel> _productDetails = [];
  List<ProductModel> get productDetails => _productDetails;


  FetchCartModel.fromJson(dynamic json) {
    debugPrint(json.toString());
    if (json["Data"] != null) {
      _productDetails = [];
      json["Data"].forEach((v) {
      /*  debugPrint('Data in Model ' + v.toString());*/
        _productDetails.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {

  int? _productId;
  String? _productname;
  bool? _wishlistFlag;
  String? _productDescription;
  String? _discountValue;
  String? _offerType;
  String? _productSmallImg;
  List<PriceListModel>? _productList=[];


  int get productId => _productId!;
  String get productname => _productname!;
  bool get wishlistFlag => _wishlistFlag!;
  String get productDescription => _productDescription!;
  String get discountValue => _discountValue!;
  String get offerType => _offerType!;
  String get productSmallImg => _productSmallImg!;
  List<PriceListModel>? get productList=>_productList;




  ProductModel.fromJson(dynamic json) {
    debugPrint("Entering into toJson Method");
    _productId=json["product_id"];
    _productname=json["product_name"];
    _wishlistFlag=json["Wishlist_Flag"];
    _productDescription=json["ProductDescription"];
    _discountValue=json["DiscountValue"];
    _offerType=json["OfferType"];
    _productSmallImg=json["product_small_img"];
    if (json["PriceList"] != null) {
      debugPrint("Hiiiiiiiiiiiiiiiiiii");

      json["PriceList"].forEach((v) {
        debugPrint("Hiiiiiiiiiiiiiiiiiii"+v.toString());
        _productList=[];
        _productList?.add(PriceListModel.fromJson(v));
      });
    }



    debugPrint("_productId:"+_productId.toString());
    debugPrint("_productname:"+_productname.toString());
    debugPrint("_wishlistFlag:"+_wishlistFlag.toString());
    debugPrint("_discountValue:"+_discountValue.toString());
    debugPrint("OfferType:"+_offerType.toString());
    debugPrint("product_small_img:"+_productSmallImg.toString());
    debugPrint("_productDescription:"+_productDescription.toString());
    debugPrint("_productList:"+_productList.toString());
  }

}

class PriceListModel {

 String?  _productMrp;

 String?  _productweight;
 String?  _productWeightType;


 String get productMrp => _productMrp!;
 String get productweight => _productweight!;
 String get productWeightType => _productWeightType!;



  PriceListModel.fromJson(dynamic json) {
    print("Entering into toJson List Model Method");

    _productMrp=json["product_MRP"];
    _productweight=json["product_weight"];
    _productWeightType=json["product_weight_type"];
    print("_productMrp:"+_productMrp.toString());

  }


}
