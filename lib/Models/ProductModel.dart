

class ProductModel {
  String name;
  String imgUrl;
  String price;

  ProductModel({this.name, this.imgUrl, this.price});
  factory ProductModel.formFactory(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      price: map['price'] as String,
      imgUrl: map['imgUrl'] as String
    );
  }
}
