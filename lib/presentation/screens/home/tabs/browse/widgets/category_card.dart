import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/assets_manager.dart';
import 'package:movies_app/presentation/screens/home/tabs/movies_list/view/movies_list_view.dart';

class CategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoviesListView(category: category),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                AssetsManager.moviePoster,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: REdgeInsets.all(8),
              child: Text(
                category['name'],
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
