class UserModel {
  String? name;
  String? phone;
  String? uid;
  String? email;
  String? image;
  String? bio;
  String? cover;

  bool? emailVerified;
  UserModel(
      {this.email,
      this.name,
      this.phone,
      this.uid,
      this.emailVerified,
      this.bio,
      this.cover,
      this.image});
  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    image = json['image'];
    bio = json['bio'];

    phone = json['phone'];
    uid = json['uid'];
    email = json['email'];
    emailVerified = json['emailVerified'];
    cover = json['cover'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name!,
      'phone': phone!,
      'uid': uid!,
      'email': email,
      'emailVerified': emailVerified!,
      ' image': image,
      'bio': bio,
      'cover': cover,
    };
  }
}
