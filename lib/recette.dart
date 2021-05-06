class Recette {
  String title;
  String user;
  String imageUrl;
  String description;
  bool isfavorite;
  int favoriteCount;
  Recette(this.title, this.user, this.imageUrl, this.description,
      this.isfavorite, this.favoriteCount);

// creation de la methode toMap
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'user': user,
      'imageUrl': imageUrl,
      'description': description,
      'isfavorite': isfavorite,
      'favoriteCount': favoriteCount
    };
  }

// creation de la methode fromMap
  factory Recette.fromMap(Map<String, dynamic> map) => new Recette(
        map['title'],
        map['user'],
        map['imageUrl'],
        map['description'],
        map['isfavorite'] == 1,
        map['favoriteCount'],
      );
}
