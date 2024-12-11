import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/assets_manager.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/presentation/screens/home/tabs/search/search_delegat.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.black,
      appBar: AppBar(
        backgroundColor: ColorsManager.black,
        toolbarHeight: 80,
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: ColorsManager.blackAccent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            style: TextStyle(color: ColorsManager.white),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: ColorsManager.white),
              prefixIcon: IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: Search());
                },
                icon: const Icon(Icons.search, color: ColorsManager.white),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            AssetsManager.search,
            width: 104.w,
            height: 114.h,
          ))
        ],
      ),
    );
  }
}
