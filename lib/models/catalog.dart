class Item{
  final int id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;

  // ignore: empty_constructor_bodies
  Item({required this.id, required this.name, required this.desc, required this.price, required this.color, required this.image});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'desc': this.desc,
      'price': this.price,
      'color': this.color,
      'image': this.image,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
      name: map['name'] as String,
      desc: map['desc'] as String,
      price: map['price'] as num,
      color: map['color'] as String,
      image: map['image'] as String,
    );
  }
}

class CatalogModel{
  static  List<Item> items = [
    Item(
      id: 1,
      name: 'iphone 12 pro',
      desc: 'Apple iphone 12th generation',
      price: 999,
      color: '#33505a',
      image: 'assets/images/login_image.png',
    ),
  ];

}