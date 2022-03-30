class Route {
  int salesperson_Id;
  String day;
  String route;

  Route({
    required this.salesperson_Id,
    required this.day,
    required this.route,
  });

  Map<String, dynamic> toMap() {
    return {
      'salesperson_Id': this.salesperson_Id,
      'day': this.day,
      'route': this.route,
    };
  }

  factory Route.fromMap(Map<String, dynamic> map) {
    return Route(
      salesperson_Id: map['salesperson_Id'] as int,
      day: map['day'] as String,
      route: map['route'] as String,
    );
  }
}
