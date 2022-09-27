class User {
  // String id = '';
  final String name;
  final int batch;
  final String blood_group;
  final String linkedin_profile;

  User({
    // this.id = '',
    required this.name,
    required this.batch,
    required this.linkedin_profile,
    required this.blood_group,
  });

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'name': name,
        'batch': batch,
        'linkedin_profile': linkedin_profile,
        'blood_group': blood_group,
      };
  static User fromJson(Map<String, dynamic> json) => User(
        // id: json['id'],
        name: json['name'],
        batch: json['batch'],
        linkedin_profile: json['linkedin_profile'],
        blood_group: json['blood_group'],
      );
}
