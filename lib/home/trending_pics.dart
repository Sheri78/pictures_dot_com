import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/trending_pics_model.dart';

class TrendingPicsList extends StatefulWidget {
  const TrendingPicsList({Key? key}) : super(key: key);

  @override
  State<TrendingPicsList> createState() => _TrendingPicsListState();
}

class _TrendingPicsListState extends State<TrendingPicsList> {
  late Future<List<ImageImage>> futureTrendingPics;

  @override
  void initState() {
    super.initState();
    futureTrendingPics = fetchTrendingPics();
  }

  Future<List<ImageImage>> fetchTrendingPics() async {
    final response = await http.get(
      Uri.parse('https://742.pictures.com.pk/api/v1/images'),
    );
    log('Status Code: ${response.statusCode}');
    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      log('API Response: ${response.body}'); // Log the full API response for inspection
      TrendingPicsModel trendingPicsModel = TrendingPicsModel.fromJson(parsedJson);

      // Flatten the list of images
      List<ImageImage> allImages = [];
      for (var imageModel in trendingPicsModel.images) {
        allImages.addAll(imageModel.images);
      }

      return allImages;
    } else {
      throw Exception('Failed to load trending pictures');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ImageImage>>(
      future: futureTrendingPics,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final images = snapshot.data!;
          log('Total Images Received: ${images.length}'); // Log the total number of images received

          if (images.isEmpty) {
            return const Center(child: Text('No trending pictures available.'));
          } else {
            return ListView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                final imageUrl = images[index].url;

                log('Image URL at index $index: $imageUrl'); // Log each image URL being processed

                if (imageUrl != null && imageUrl.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        return progress == null
                            ? child
                            : Center(
                          child: CircularProgressIndicator(
                            value: progress.expectedTotalBytes != null
                                ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text('Image not available.'));
                }
              },
            );
          }
        } else {
          return const Center(child: Text('No data available.'));
        }
      },
    );
  }
}
