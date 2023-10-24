enum MovieGenre {
  action,
  comedy,
  drama,
  horror,
  romance,
  scifi,
  fantasy,
  thriller
}

extension GenreStringRepresentation on MovieGenre {
  String get value {
    switch (this) {
      case MovieGenre.action:
        return 'Action';
      case MovieGenre.comedy:
        return 'Comedy';
      case MovieGenre.drama:
        return 'Drama';
      case MovieGenre.horror:
        return 'Horror';
      case MovieGenre.romance:
        return 'Romance';
      case MovieGenre.scifi:
        return 'Sci-Fi';
      case MovieGenre.fantasy:
        return 'Fantasy';
      case MovieGenre.thriller:
        return 'Thriller';
    }
  }
}
