class UserModel {
  final String name;
  final int batch;
  final String bloodGroup;
  final String linkedin;
  final bool? showData;

  UserModel({
    required this.name,
    required this.batch,
    required this.linkedin,
    required this.bloodGroup,
    required this.showData,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'batch': batch,
        'linkedin': linkedin,
        'bloodGroup': bloodGroup,
        'showData': showData,
      };
  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        batch: json['batch'],
        linkedin: json['linkedin'],
        bloodGroup: json['bloodGroup'],
        showData: json['showData'],
      );
}
