class Region_Salesperson {
  String? sub_Area;
  String? area;
  int? emp_Id;

  Region_Salesperson({
    this.sub_Area,
    this.area,
    this.emp_Id,
  });

  Map<String, dynamic> toMap() {
    return {
      'sub_Area': this.sub_Area,
      'area': this.area,
      'emp_Id ': this.emp_Id,
    };
  }

  factory Region_Salesperson.fromMap(Map<String, dynamic> map) {
    return Region_Salesperson(
      sub_Area: map['sub_Area'] as String,
      area: map['area'] as String,
      emp_Id: map['emp_Id'] as int,
    );
  }
}
