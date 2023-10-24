enum language {
  telugu,
  english,
  malayalam,
  japanese,
  kannada,
  hindi,
}

extension GenreStringRepresentation on language {
  String get value {
    switch (this) {
      case language.telugu:
        return 'Telugu';
      case language.english:
        return 'English';
      case language.hindi:
        return 'Hindi';
      case language.japanese:
        return 'Japanese';
      case language.kannada:
        return 'Kannada';
      case language.malayalam:
        return 'Malayalam';
    }
  }
}
