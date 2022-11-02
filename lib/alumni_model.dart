class AlumniModel {
  final String email;
  final String name;
  final int batch;
  final String bloodGroup;
  final String linkedin;

  AlumniModel(
      {required this.name,
      required this.batch,
      required this.linkedin,
      required this.bloodGroup,
      required this.email});

  Map<String, dynamic> toJson() => {
        'name': name,
        'batch': batch,
        'linkedin': linkedin,
        'bloodGroup': bloodGroup,
        'email': email,
      };
  static AlumniModel fromJson(Map<String, dynamic> json) => AlumniModel(
        name: json['name'],
        batch: json['batch'],
        linkedin: json['linkedin'],
        bloodGroup: json['bloodGroup'],
        email: json['email'],
      );
}
