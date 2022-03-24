class Item {
  String? code;
  int? hsn_Code;
  String? item_Name;
  String? grp;
  String? sub_Group;
  String? item_Type;
  int? unit_Item;
  int? barcode;
  String? pur_Item;
  String? sell_Item;
  int? price;
  int? net_Weight;
  Item({
    this.code,
    this.hsn_Code,
    this.item_Name,
    this.grp,
    this.sub_Group,
    this.item_Type,
    this.unit_Item,
    this.barcode,
    this.pur_Item,
    this.sell_Item,
    this.price,
    this.net_Weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': this.code,
      'hsn_Code': this.hsn_Code,
      'item_Name': this.item_Name,
      'grp': this.grp,
      'sub_Group': this.sub_Group,
      'item_Type': this.item_Type,
      'unit_Item': this.unit_Item,
      'barcode': this.barcode,
      'pur_Item': this.pur_Item,
      'sell_Item': this.sell_Item,
      'price': this.price,
      'net_Weight': this.net_Weight,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      code: map['code'] as String,
      hsn_Code: map['hsn_Code'] as int,
      item_Name: map['item_Name'] as String,
      grp: map['grp'] as String,
      sub_Group: map['sub_Group'] as String,
      item_Type: map['item_Type'] as String,
      unit_Item: map['unit_Item'] as int,
      barcode: map['barcode'] as int,
      pur_Item: map['pur_Item'] as String,
      sell_Item: map['sell_Item'] as String,
      price: map['price'] as int,
      net_Weight: map['net_Weight'] as int,
    );
  }
}
