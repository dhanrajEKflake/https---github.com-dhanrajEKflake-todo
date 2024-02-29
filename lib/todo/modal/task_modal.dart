// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

// Temperatures temperaturesFromJson(String str) => Temperatures.fromJson(json.decode(str));

// String temperaturesToJson(Temperatures data) => json.encode(data.toJson());

class Task {
  final int id;
  final String title;
  bool status;

  Task({
    required this.id,
    required this.title,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["Id"],
        title: json["Title"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "status": status,
      };
}
