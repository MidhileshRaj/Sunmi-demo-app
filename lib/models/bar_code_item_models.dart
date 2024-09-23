import 'dart:convert';

class BarCodeData {
  final Product product;

  BarCodeData({
    required this.product,
  });

  factory BarCodeData.fromRawJson(String str) => BarCodeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BarCodeData.fromJson(Map<String, dynamic> json) => BarCodeData(
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "product": product.toJson(),
  };
}

class Product {
  final String arabicDescription;
  final String barcCode;
  final int id;
  final String itemCode;
  final String itemDescription;
  final double salesPrice;
  final String unitCode;

  Product({
    required this.arabicDescription,
    required this.barcCode,
    required this.id,
    required this.itemCode,
    required this.itemDescription,
    required this.salesPrice,
    required this.unitCode,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    arabicDescription: json["arabicDescription"],
    barcCode: json["barcCode"],
    id: json["id"],
    itemCode: json["itemCode"],
    itemDescription: json["itemDescription"],
    salesPrice: json["salesPrice"],
    unitCode: json["unitCode"],
  );

  Map<String, dynamic> toJson() => {
    "arabicDescription": arabicDescription,
    "barcCode": barcCode,
    "id": id,
    "itemCode": itemCode,
    "itemDescription": itemDescription,
    "salesPrice": salesPrice,
    "unitCode": unitCode,
  };
}
