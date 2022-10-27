class UserModel {
  final String uid;
  final String email;
  final String name;
  final int roll;
  final int batch;
  final String bloodGroup;
  final String linkedin;
  final bool? showData;

  UserModel(
      {required this.uid,
      required this.name,
      required this.roll,
      required this.batch,
      required this.linkedin,
      required this.bloodGroup,
      required this.showData,
      required this.email});

  Map<String, dynamic> toJson() => {
        'name': name,
        'batch': batch,
        'linkedin': linkedin,
        'bloodGroup': bloodGroup,
        'showData': showData,
        'uid': uid,
        'email': email,
        'roll': roll,
      };
  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'],
      batch: json['batch'],
      linkedin: json['linkedin'],
      bloodGroup: json['bloodGroup'],
      showData: json['showData'],
      uid: json['uid'],
      email: json['email'],
      roll: json['roll']);
}
