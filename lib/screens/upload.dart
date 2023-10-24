import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:upload_movie/color.dart';
import 'package:upload_movie/enums/moviegener.dart';
import 'package:upload_movie/widgets/FormInput.dart';
import 'package:upload_movie/widgets/category.dart';
import 'package:upload_movie/widgets/drop_down.dart';
import 'package:upload_movie/widgets/image.dart';

class UploadMovies extends StatefulWidget {
  const UploadMovies({super.key});
  String? validateMovieName(String value) {
    if (value.isEmpty) {
      return 'Movie name cannot be empty';
    }
    // You can add more validation logic here if needed
    return null;
  }

  @override
  State<UploadMovies> createState() => _UploadMoviesState();
}

class _UploadMoviesState extends State<UploadMovies> {
  var _imageUrl = '';
  final List<String> _category = [];
  final List<String> _quality = ['Theatre', '1080p', '720p', '480p', '360p'];
  String _print = '720p';
  final _formKey = GlobalKey<FormState>();

  String _movieName = '',
      _url = '',
      _hours = '',
      _minutes = '',
      _story = '',
      _year = '',
      _streamingUrl = '',
      _rating = '',
      _language = 'Telugu';

  String? validateMovie(String value) {
    if (value.trim().isEmpty) {
      return "Please enter a movie name";
    }
    return null;
  }

  void toggleQuality(String value) {
    setState(() {
      _print = value;
    });
  }

  void toggleBelong(String value) {
    final flag = _category.contains(value);
    if (flag) {
      setState(() {
        _category.remove(value);
      });
    } else {
      setState(() {
        _category.add(value);
      });
    }
  }

  void toggleLanguage(String value) {
    _language = value;
  }

  void submit() async {
    final valid = _formKey.currentState!.validate();

    if (valid) {
      setState(() {
        isUploading = true;
      });
      _formKey.currentState!.save();
      _formKey.currentState!.reset();

      final msgObj = await FirebaseFirestore.instance
          .collection('movies')
          .doc('${_movieName.toString()} ${_year.toString()}')
          .set({
        'category': _category,
        'hours': _hours,
        'minutes': _minutes,
        'story': _story,
        'quality': _print,
        'imageUrl': _url,
        'movieName': _movieName,
        'streamingUrl': _streamingUrl,
        "rating": _rating,
        "language": _language,
        "year":_year,
      });

      setState(() {
        isUploading = false;
      });
      _streamingUrl = '';
      _rating = '';
      _print = '720p';
      _category.clear();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added a movie'),
        ),
      );
    }
  }

  bool isUploading = false;
  @override
  Widget build(BuildContext context) {
    Widget content = ListView(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_imageUrl.trim().length != 0)
                MyImageWidget(
                  imageUrl: _imageUrl,
                ),
              Input(
                placeholder: 'Enter movie Name',
                validator: validateMovie,
                onSaved: (value) {
                  _movieName = value;
                },
              ),
              Input(
                placeholder: 'Paste Image URL',
                onChanged: (url) {
                  setState(() {
                    _imageUrl = url;
                  });
                },
                onSaved: (value) {
                  _url = value;
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "paste a valid url";
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Input(
                    placeholder: 'Hours',
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return "Enter no.of hours";
                      }

                      if (int.tryParse(value) == null ||
                          int.tryParse(value)! <= 0) {
                        return "Must be a valid,Positive number";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value.length == 1) {
                        _hours = '0${value}';
                      } else {
                        _hours = value;
                      }
                    },
                  )),
                  Expanded(
                      child: Input(
                    placeholder: 'minutes',
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return "please enter minutes";
                      }
                      if (int.tryParse(value) == null ||
                          int.tryParse(value)! <= 0) {
                        return "Must be a valid,Positive number";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value.length == 1) {
                        _minutes = '0${value}';
                      } else {
                        _minutes = value;
                      }
                    },
                  ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Input(
                      placeholder: 'Year',
                      validator: (value) {
                        if (value.trim().length != 4) {
                          return "length must be 4 charachters";
                        }
                        if (int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return "Must be a valid,Positive number";
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _year = value;
                      },
                    ),
                  ),
                  Expanded(
                      child: DropDown(
                    toggleLang: toggleLanguage,
                  ))
                ],
              ),
              Input(
                placeholder: 'Enter Story of movie',
                noOfLines: 3,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "please enter cinema story";
                  }
                  return null;
                },
                onSaved: (value) {
                  _story = value;
                },
              ),
              Input(
                  placeholder: 'Paste Streaming Url',
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Value can't be empty";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _streamingUrl = value;
                  }),
              Input(
                  placeholder: 'Rating',
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "rating can't be empty";
                    }
                    if (double.tryParse(value) == null ||
                        double.tryParse(value)! < 0) {
                      return "provide valid positive rating";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _rating = value;
                  }),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Print Type',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: [
                    for (var item in _quality)
                      Category(
                          onTap: () {
                            toggleQuality(item);
                          },
                          belongs: (_print == item),
                          cat: item)
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Select Categories',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: [
                    for (var genre in MovieGenre.values)
                      Category(
                          onTap: () {
                            toggleBelong(genre.value);
                          },
                          belongs: _category.contains(genre.value),
                          cat: genre.value)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: appColors.primary,
                  ),
                  child: TextButton.icon(
                      onPressed: submit,
                      icon: Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'Add Movie',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      )),
                ),
              )
            ],
          ),
        ),
      ],
    );

    if (isUploading) {
      content = Center(
        child: CircularProgressIndicator(color: appColors.primary),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Add Movie')),
      body: content,
    );
  }
}
