class Director {
  Director({
    required this.roster,
    required this.name,
    required this.documentId,
  });

  List<String> roster;
  String name;
  String documentId;

  Director copyWith({
    List<String>? roster,
    String? name,
    String? documentId,
  }) =>
      Director(
        documentId: documentId ?? this.documentId,
        roster: roster ?? this.roster,
        name: name ?? this.name,
      );

  factory Director.fromJson(Map<String, dynamic> json) {
    var list = <String>[];
    json['roster'].forEach((k, v) => v ? list.add(k) : null);
    return Director(
      documentId: json['documentId'],
      roster: list,
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "roster": {for (var e in roster) e: true},
        "name": name,
        "documentId": documentId,
      };
}
