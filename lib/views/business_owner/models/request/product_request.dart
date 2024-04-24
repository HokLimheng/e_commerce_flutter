// To parse this JSON data, do
//
//     final productRequest = productRequestFromJson(jsonString);

import 'dart:convert';

ProductRequest productRequestFromJson(String str) => ProductRequest.fromJson(json.decode(str));

String productRequestToJson(ProductRequest data) => json.encode(data.toJson());

class ProductRequest {
  DataRequest? data;

  ProductRequest({
    this.data,
  });

  factory ProductRequest.fromJson(Map<String, dynamic> json) => ProductRequest(
    data: json["data"] == null ? null : DataRequest.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class DataRequest {
  String? title;
  String? rating;
  String? description;
  String? quantity;
  String? thumbnail;
  String? price;

  DataRequest({
    this.title,
    this.rating,
    this.description,
    this.quantity,
    this.thumbnail,
    this.price,
  });

  factory DataRequest.fromJson(Map<String, dynamic> json) => DataRequest(
    title: json["title"],
    rating: json["rating"],
    description: json["description"],
    quantity: json["quantity"],
    thumbnail: json["thumbnail"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "rating": rating,
    "description": description,
    "quantity": quantity,
    "thumbnail": thumbnail,
    "price": price,
  };
}
