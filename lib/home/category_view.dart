import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/category_view_model.dart';

class categoryViewClass extends StatefulWidget {
  const categoryViewClass({Key? key}) : super(key: key);

  @override
  State<categoryViewClass> createState() => _categoryViewClassState();
}

class _categoryViewClassState extends State<categoryViewClass> {
  late Future<List<CategoryViewModel>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  Future<List<CategoryViewModel>> fetchCategories() async {
    final response = await http
        .get(Uri.parse('https://742.pictures.com.pk/api/v1/category/view'));
    log('Status Code: ${response.statusCode}');
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => CategoryViewModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryViewModel>>(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final categories = snapshot.data!; // Access the list of categories
          if (categories.isEmpty) {
            return const Center(child: Text('No categories available.'));
          } else {
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Card(
                  child: ListTile(
                    title: Text(category.category!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: category.subCategories
                          .map((subCategory) => Text(subCategory))
                          .toList(),
                    ),
                  ),
                );
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
