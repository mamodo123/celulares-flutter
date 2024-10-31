class MyAppUser {
  final String name;

  MyAppUser(this.name);

  MyAppUser.fromJson(Map<String, dynamic> json) : name = json['name'];

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
