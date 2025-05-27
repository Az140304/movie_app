import 'package:flutter/material.dart';
import 'package:movie_app/network/base_network.dart';

class MovieDetailCharacter extends StatefulWidget {
  final String id;
  final String endpoint;
  const MovieDetailCharacter({
    super.key,
    required this.id,
    required this.endpoint,
  });

  @override
  State<MovieDetailCharacter> createState() => _MovieDetailCharacterState();
}

class _MovieDetailCharacterState extends State<MovieDetailCharacter> {
  bool _isLoading = true;
  Map<String, dynamic>? _detailData;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchDetailData();
  }

  Future<void> _fetchDetailData() async {
    try {
      final data = await BaseNetwork.getDetailData(widget.endpoint, widget.id);
      setState(() {
        _detailData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movie Detail")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text("Error: $errorMessage"))
          : _detailData != null
          ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Movie Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    _detailData!['imgUrl'] ?? 'https://via.placeholder.com/300x400',
                    height: 300,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 300,
                        width: 200,
                        color: Colors.grey[300],
                        child: Icon(Icons.movie, size: 50),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Movie Title
              Text(
                _detailData!['title'] ?? 'Unknown Title',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
              ),
              SizedBox(height: 16),

              // Rating
              if (_detailData!['rating'] != null)
                _buildInfoCard('Rating', _detailData!['rating'].toString()),
              SizedBox(height: 8),
              // Release Date
              if (_detailData!['release_date'] != null)
                _buildInfoCard('Release Date', _detailData!['release_date']),
              SizedBox(height: 8),
              // Duration
              if (_detailData!['duration'] != null)
                _buildInfoCard('Duration', _detailData!['duration']),
              SizedBox(height: 8),
              // Director
              if (_detailData!['director'] != null)
                _buildInfoCard('Director', _detailData!['director']),
              SizedBox(height: 8),
              // Language
              if (_detailData!['language'] != null)
                _buildInfoCard('Language', _detailData!['language']),
              SizedBox(height: 8),
              // Genres
              if (_detailData!['genre'] != null && _detailData!['genre'] is List)
                _buildGenreCard(),
              SizedBox(height: 8),
              // Cast
              if (_detailData!['cast'] != null && _detailData!['cast'] is List)
                _buildCastCard(),
              SizedBox(height: 8),
              // Description
              if (_detailData!['description'] != null)
                _buildDescriptionCard(),
            ],
          ),
        ),
      )
          : Center(child: Text("No Data Available")),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreCard() {
    List<String> genres = List<String>.from(_detailData!['genre']);
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Genres:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: genres.map((genre) =>
                  Chip(
                    label: Text(genre),
                    backgroundColor: Colors.blue.shade100,
                  )
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCastCard() {
    List<String> cast = List<String>.from(_detailData!['cast']);
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cast:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              cast.join(', '),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              _detailData!['description'],
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}