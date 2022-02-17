class Personnel {
  Personnel({
    required this.isAvailable,
    required this.cost,
    required this.name,
    required this.description,
    this.documentId,
  });

  bool isAvailable;
  double cost;
  String name;
  String description;
  String? documentId;

  Personnel copyWith({
    bool? isAvailable,
    double? cost,
    String? name,
    String? description,
    String? documentId,
  }) =>
      Personnel(
        isAvailable: isAvailable ?? this.isAvailable,
        cost: cost ?? this.cost,
        name: name ?? this.name,
        description: description ?? this.description,
        documentId: documentId ?? this.documentId,
      );

  factory Personnel.fromJson(Map<String, dynamic> json) => Personnel(
        isAvailable: json["isAvailable"],
        cost: json["cost"]?.toDouble(),
        name: json["name"],
        description: json["description"],
        documentId: json['documentId'],
      );

  Map<String, dynamic> toJson() => {
        "isAvailable": isAvailable,
        "cost": cost,
        "name": name,
        "description": description,
        "documentId": documentId,
      };
}
