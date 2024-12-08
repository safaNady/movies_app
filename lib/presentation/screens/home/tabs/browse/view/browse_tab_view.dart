import 'package:flutter/material.dart';
import 'package:movies_app/config/theme/app_style.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/core/strings_manager.dart';
import 'package:movies_app/presentation/screens/home/tabs/browse/view_model/browse_tab_view_model.dart';
import 'package:movies_app/presentation/screens/home/tabs/browse/widgets/category_card.dart';
import 'package:provider/provider.dart';

class BrowseTabView extends StatelessWidget {
  const BrowseTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BrowseTabViewModel(),
      child: Scaffold(
        backgroundColor: ColorsManager.blackAccent,
        appBar: AppBar(
          title: Text(StringsManager.browseAppBarText,style: AppTextStyles.appBar,),
        ),
        body: Consumer<BrowseTabViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.errorMessage != null) {
              return Center(child: Text('Error: ${viewModel.errorMessage}'));
            }

            if (viewModel.categories.isEmpty) {
              return const Center(child: Text('No categories available.'));
            }

            final categories = viewModel.categories;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryCard(category: category);
              },
            );
          },
        ),
      ),
    );
  }
}
