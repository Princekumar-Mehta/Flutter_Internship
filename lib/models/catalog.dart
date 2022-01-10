class Item{
  final int id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;

  // ignore: empty_constructor_bodies
  Item({required this.id, required this.name, required this.desc, required this.price, required this.color, required this.image});
}

class CatalogModel{
  static final items = [
    Item(
      id: 1,
      name: 'iphone 12 pro',
      desc: 'Apple iphone 12th generation',
      price: 999,
      color: '#33505a',
      image: 'assets/images/login_image.png',
    ),
    Item(
      id: 1,
      name: 'iphone 12 pro',
      desc: 'Apple iphone 12th generation',
      price: 999,
      color: '#33505a',
      image: 'assets/images/login_image.png',
    ),
    Item(
      id: 1,
      name: 'iphone 12 pro',
      desc: 'Apple iphone 12th generation',
      price: 999,
      color: '#33505a',
      image: 'assets/images/login_image.png',
    ),
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