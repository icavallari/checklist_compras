import 'package:rxdart/rxdart.dart';

// https://medium.com/codechai/architecting-your-flutter-project-bd04e144a8f1

// bloc sqlite
// https://vaygeth.medium.com/reactive-flutter-todo-app-using-bloc-design-pattern-b71e2434f692

class MoviesBloc {
  //final _repository = Repository();
  final _moviesFetcher = PublishSubject<String>();

  //Observable<String> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    //ItemModel itemModel = await _repository.fetchAllMovies();
    //_moviesFetcher.sink.add("itemModel");
  }

  dispose() {
    _moviesFetcher.close();
  }
}

// This way we are giving access to a single instance
// of the MoviesBloc class to the UI screen
final bloc = MoviesBloc();
