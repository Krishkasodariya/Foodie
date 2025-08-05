class
UserModel {
  String? name;
  String? dialcode;
  String? phonenumber;
  String? email;
  String? image;
  String? uid;
  String isocode;

  UserModel(
      {required this.name,
      required this.phonenumber,
      required this.email,
      required this.image,
      required this.uid,
      required this.dialcode,
      required this.isocode});

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Email": email,
      "Phone": phonenumber,
      "Image": image,
      "Uid": uid,
      "Dc": dialcode,
      "Iso": isocode
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
        name: data["Name"],
        phonenumber: data["Phone"],
        email: data["Email"],
        image: data["Image"],
        uid: data["Uid"],
        dialcode: data["Dc"],
        isocode: data["Iso"]);
  }
}
