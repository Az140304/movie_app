import 'package:flutter/material.dart';
import 'package:movie_app/controller/movie_presenter.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/view/detail_screen.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> implements MovieView {
  late MoviePresenter _presenter;
  bool _isLoading = false;
  List<Movie> _movieList = [];
  String? _errorMessage;
  String _currentEndpoint = "movie";
  //Map<String, dynamic> debut = _movieList!["genre"];

  int yes = 0;
  @override
  void initState(){
    super.initState();
    _presenter = MoviePresenter(this);
    _presenter.loadMovieData(_currentEndpoint);
  }

  void _fetchData(String endpoint){
    _currentEndpoint = endpoint;
    _presenter.loadMovieData(_currentEndpoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movie List"),),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _errorMessage != null
                ? Center(child: Text(_errorMessage.toString()))
                : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75, // Adjust for image + text
              ),
              itemCount: _movieList.length,
              itemBuilder: (context, index) {
                final movie = _movieList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailCharacter(id: movie.id, endpoint: _currentEndpoint),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              movie.imgUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network('https://placehold.co/600x400', fit: BoxFit.cover);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(movie.title, style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(movie.rating),
                              //Text(movie.genre, style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(movie.duration),
                              SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )

        ],
      ),
    );
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
    setState(() {
      _isLoading = false;
    });

  }

  @override
  void showError(String message) {
    // TODO: implement showError
    setState(() {
      _errorMessage = message;
    });

  }

  @override
  void showLoading() {
    // TODO: implement showLoading
    _isLoading = true;
  }

  @override
  void showMovieList(List<Movie> movieList) {
    // TODO: implement showMovieList
    print(movieList);
    setState(() {
      _movieList = movieList;
    });

  }
  
}
