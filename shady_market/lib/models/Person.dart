import 'dart:convert';

class Person {
  final int id;
  final String email;
  final String name;
  final String password;
  final String pictureUrl;
  final String location;
  final double credit;
  Person({
    this.id,
    this.email,
    this.name,
    this.password,
    this.pictureUrl,
    this.location,
    this.credit,
  });

  Person copyWith({
    int id,
    String email,
    String name,
    String password,
    String pictureUrl,
    String location,
    double credit,
  }) {
    return Person(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      location: location ?? this.location,
      credit: credit ?? this.credit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'password': password,
      'pictureUrl': pictureUrl,
      'location': location,
      'credit': credit,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Person(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      password: map['password'],
      pictureUrl: map['pictureUrl'],
      location: map['location'],
      credit: map['credit'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Person(id: $id, email: $email, name: $name, password: $password, pictureUrl: $pictureUrl, location: $location, credit: $credit)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Person &&
        o.id == id &&
        o.email == email &&
        o.name == name &&
        o.password == password &&
        o.pictureUrl == pictureUrl &&
        o.location == location &&
        o.credit == credit;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        password.hashCode ^
        pictureUrl.hashCode ^
        location.hashCode ^
        credit.hashCode;
  }
}
