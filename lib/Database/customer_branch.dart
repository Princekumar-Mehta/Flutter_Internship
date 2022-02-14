class Customer_Branch {
  String? code;
  String? branch_code;
  String? branch_Type;
  String? branch_Name;
  String? address1;
  String? address2;
  String? location;
  String? city;
  String? state;
  String? country;
  int? post_Code;
  String? contact_Person;
  String? branch_Email;
  String? branch_Phone;
  String? gstin;
  String? pan;
  String? composite_Scheme;
  String? isDefault;
  String? active;

  Customer_Branch({
    this.code,
    this.branch_code,
    this.branch_Type,
    this.branch_Name,
    this.address1,
    this.address2,
    this.location,
    this.city,
    this.state,
    this.country,
    this.post_Code,
    this.contact_Person,
    this.branch_Email,
    this.branch_Phone,
    this.gstin,
    this.pan,
    this.composite_Scheme,
    this.isDefault,
    this.active,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': this.code,
      'branch_code': this.branch_code,
      'branch_Type': this.branch_Type,
      'branch_Name': this.branch_Name,
      'address1': this.address1,
      'address2': this.address2,
      'location': this.location,
      'city': this.city,
      'state': this.state,
      'country': this.country,
      'post_Code': this.post_Code,
      'contact_Person': this.contact_Person,
      'branch_Email': this.branch_Email,
      'branch_Phone': this.branch_Phone,
      'gstin': this.gstin,
      'pan': this.pan,
      'composite_Scheme': this.composite_Scheme,
      'isDefault': this.isDefault,
      'active': this.active,
    };
  }

  factory Customer_Branch.fromMap(Map<String, dynamic> map) {
    return Customer_Branch(
      code: map['code'] as String,
      branch_code: map['branch_code'] as String,
      branch_Type: map['branch_Type'] as String,
      branch_Name: map['branch_Name'] as String,
      address1: map['address1'] as String,
      address2: map['address2'] as String,
      location: map['location'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      post_Code: map['post_Code'] as int,
      contact_Person: map['contact_Person'] as String,
      branch_Email: map['branch_Email'] as String,
      branch_Phone: map['branch_Phone'] as String,
      gstin: map['gstin'] as String,
      pan: map['pan'] as String,
      composite_Scheme: map['composite_Scheme'] as String,
      isDefault: map['isDefault'] as String,
      active: map['active'] as String,
    );
  }
}
