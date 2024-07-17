class MovieEntity {
  String title;
  String year;
  String poster;

  MovieEntity(this.title, this.year, this.poster);

  factory MovieEntity.fromJson(Map<String, dynamic> json) {
    return (MovieEntity(
      json['title'] as String,
      json['year'] as String,
      json['poster'] as String,
    ));
  }

  @override
  String toString() {
    return "$title| $year| $poster";
  }
}
