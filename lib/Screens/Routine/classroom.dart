class Classroom{
  String courseName;
  String instructor;
  String batch;
  String startTime;
  String endTime;
  int day;

  Classroom({ required this.courseName, required this.instructor, required this.batch, required this.startTime, required this.endTime, required this.day});

  Map<String, dynamic> toJson() => {
    'courseName': courseName,
    'instructor': instructor,
    'batch' : batch,
    'startTime': startTime,
    'endTime': endTime,
    'day': day,
  };

  static Classroom fromJson(Map<String, dynamic> json) => Classroom(
    courseName: json['courseName'],
    instructor: json['instructor'],
    batch: json['batch'],
    startTime: json['startTime'],
    endTime: json['endTime'],
    day: json['day'],
  );
}