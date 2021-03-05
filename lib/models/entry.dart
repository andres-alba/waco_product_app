class Product {
  String id;
  String price;
  String name;
  String description;
  String stock;

  Product({this.id, this.price, this.name, this.description, this.stock});

  Product.fromMap(Map snapshot, String id)
      : id = id ?? '',
        price = snapshot['price'] ?? '',
        name = snapshot['name'] ?? '',
        description = snapshot['description'] ?? '',
        stock = snapshot['stock' ?? ''];

  toJson() {
    return {
      "price": price,
      "name": name,
      "description": description,
      "stock": stock
    };
  }
}
