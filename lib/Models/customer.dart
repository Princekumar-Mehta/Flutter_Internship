class Customer {
  String? code;
  String? party_Name;
  String? nick_Name;
  String? doc_Type;
  String? grp;
  String? sub_Group;
  int? map_Cn;
  String? sub_Area;
  String? area;
  int? branch_Cn;
  String? email;
  String? phone_1;
  String? phone_2;
  int? crd_Day;
  int? crd_Amt;
  int? gL_Acc;
  String? active;
  Customer(
      {this.code,
      this.party_Name,
      this.nick_Name,
      this.doc_Type,
      this.grp,
      this.sub_Group,
      this.map_Cn,
      this.branch_Cn,
      this.sub_Area,
      this.area,
      this.email,
      this.phone_1,
      this.phone_2,
      this.crd_Amt,
      this.crd_Day,
      this.gL_Acc,
      this.active});

  Map<String, dynamic> toMap() {
    return {
      'code': this.code,
      'party_Name': this.party_Name,
      'nick_Name': this.nick_Name,
      'doc_Type': this.doc_Type,
      'grp': this.grp,
      'sub_Group': this.sub_Group,
      'map_Cn': this.map_Cn,
      'branch_Cn': this.branch_Cn,
      'sub_Area': this.sub_Area,
      'area': this.area,
      'email': this.email,
      'phone_1': this.phone_1,
      'phone_2': this.phone_2,
      'crd_Day': this.crd_Day,
      'crd_Amt': this.crd_Amt,
      'gL_Acc': this.gL_Acc,
      'active': this.active,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      code: map['code'] as String,
      party_Name: map['party_Name'] as String,
      nick_Name: map['nick_Name'] as String,
      doc_Type: map['doc_Type'] as String,
      grp: map['grp'] as String,
      sub_Group: map['sub_Group'] as String,
      map_Cn: map['map_Cn'] as int,
      branch_Cn: map['branch_Cn'] as int,
      sub_Area: map['sub_Area'] as String,
      area: map['area'] as String,
      email: map['email'] as String,
      phone_1: map['phone_1'] as String,
      phone_2: map['phone_2'] as String,
      crd_Day: map['crd_Day'] as int,
      crd_Amt: map['crd_Amt'] as int,
      gL_Acc: map['gL_Acc'] as int,
      active: map['active'] as String,
    );
  }
}
