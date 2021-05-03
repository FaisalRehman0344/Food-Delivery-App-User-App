class User {
  String username;
  String firstname;
  String lastname;
  String address;
  String contact;

  User({this.firstname, this.lastname, this.address, this.contact,this.username});

  factory User.formFactory(Map<String, dynamic> data) {
    return User(
        username: data['username'] as String,
        firstname: data['firstname'] as String,
        lastname: data['lastname'] as String,
        address: data['address'] as String,
        contact: data['contact'] as String);
  }
}
