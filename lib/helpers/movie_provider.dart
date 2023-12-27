import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../classes/MoviesList.dart';
import '../classes/language.dart';
import '../helpers/Api.dart';

class MoviesProvider extends ChangeNotifier {
  MoviesProvider() {
    language();
  }
  List<MoviesList> _moviesList = [];
  int _totalPage = 0;
  int _currentPage = 1;
  bool _isLoading = true;
  Future<void> movieListAdder(bool pagination) async {
    Response? response;
    if (pagination) {
      response = await Api.sharedInstence.getMovieList(_currentPage);
    } else {
      _currentPage = 1;
      response = await Api.sharedInstence.getMovieList(_currentPage);
    }
    List<MoviesList> tempMoviesList = (response!.data['results'] as List).map(
      (data) {
        final user = MoviesList.fromJson(data);
        return user;
      },
    ).toList();

    (pagination)
        ? _moviesList.addAll(tempMoviesList)
        : (_moviesList = tempMoviesList);

    //print(_moviesList);
    _totalPage = response.data['total_pages'];
    _currentPage++;
    _isLoading = false;

    notifyListeners();
  }

  List get moviesList {
   // print(_moviesList);
    return _moviesList;
  }

  int get currentPage {
    //print(_currentPage);
    return _currentPage;
  }

  int get totalPages {
    //print(_totalPage);
    return _totalPage;
  }

  bool get isLoading {
    return _isLoading;
  }

  //Search
  List<MoviesList> _searchList = [];
  String _searchTitle = '';
  void movieSearch(String title) {
    _searchList.clear();
    _searchTitle = title;
    _searchList = _moviesList
        .where((e) => e.title.toLowerCase().contains(title.toLowerCase()))
        .toList();

    notifyListeners();
  }

  List get searchList {
    return _searchList;
  }

  String get searchTitle {
    return _searchTitle;
  }

  //Sorting
  int _sortCount = 0;
  bool _sortState = false;
  void ascendingSort() {
    _moviesList.sort(
      (a, b) => a.releaseDate.compareTo(
        b.releaseDate,
      ),
    );
    notifyListeners();
    _sortCount++;
  }

  void descendingSort() {
    _moviesList.sort(
      (a, b) => b.releaseDate.compareTo(
        a.releaseDate,
      ),
    );
    notifyListeners();
    _sortCount++;
  }

  void sortState() {
    _sortState = (sortCount != 0) ? ((_sortState) ? false : true) : false;
    notifyListeners();
  }

  bool get sortStatus {
    return _sortState;
  }

  int get sortCount {
    return _sortCount;
  }

//Filter
  List<MoviesList> _filteredMovieList = [];
  List<Languages> _languageList = [];
  final List<String> _selectedLanguage = [];

  void language() async {
    List<String> language = ['English', 'Hindi', 'Arabic', 'Japanese', 'Thai'];
    _languageList = language
        .map((e) => Languages(e, e.substring(0, 2).toLowerCase()))
        .toList();
  }

  void filterCheckBox(Languages language) {
    if (language.check == false) {
      _selectedLanguage.add(language.language);
      language.check = true;
    } else {
      (_selectedLanguage.contains(language.language))
          ? _selectedLanguage.remove(language.language)
          : null;
      language.check = false;
    }
    notifyListeners();
  }

  void filter() {
    _filteredMovieList.clear();
    _filteredMovieList = _moviesList
        .where((e) => _selectedLanguage.contains(e.language))
        .toList();

    notifyListeners();
  }

  List get filteredMovies {
    return _filteredMovieList;
  }

  List get languageList {
    return _languageList;
  }

  List get selectedLanguage {
    return _selectedLanguage;
  }
}
