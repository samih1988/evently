class MyUser {
  static const String collectionName = "Users";
  String id;
  String name;
  String email;

  MyUser({required this.id, required this.name, required this.email});

  //todo: to json
  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "email": email};
  }

  //todo:  from json
  MyUser.formJson(Map<String, dynamic> user)
    : this(id: user["id"], name: user["name"], email: user["email"]);
}
