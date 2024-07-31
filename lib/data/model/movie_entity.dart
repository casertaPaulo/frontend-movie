class MovieEntity {
  final int? id;
  final String title;
  final String year;
  final String poster;

  MovieEntity({
    this.id,
    required this.title,
    required this.year,
    required this.poster,
  });

  // Creating method to convert a map response to object
  factory MovieEntity.fromJson(Map<String, dynamic> json) {
    return MovieEntity(
      id: json['id'],
      title: json['title'],
      year: json['year'],
      poster: json['poster'],
    );
  }

  @override
  String toString() {
    return "$id| $title| $year| $poster";
  }

  // Implementando o operador == para comparar objetos por título
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is MovieEntity && other.title == title;
  }

  // Implementando o método hashCode para garantir que objetos com o mesmo título tenham o mesmo hash code
  @override
  int get hashCode => title.hashCode;
}
