import 'dart:io';
import 'package:fassty_resturents_app/helper/app_utilities/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import '../../model/category/modelCategory.dart';
import '../Item/ItemListScreen.dart';
import 'AddEditCategoryScreen.dart';
import 'cubit/category_cubit.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  late CategoryCubit _cubit;
  late List<DataCategory> categoryArr = [];

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<CategoryCubit>(context);
    _cubit.getCategories("View");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: primaryColor,
      ),

      /// ADD CATEGORY
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditCategoryScreen(),
            ),
          );

          /// REFRESH categories after coming back
          if (result == true) {
            _cubit.getCategories("View");
          }
        },
        child: const Icon(Icons.add),
      ),

      body: BlocConsumer<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Stack(
              children: [
                body(),
                const AppLoaderProgress(),
              ],
            );
          }
          return body();
        },
        listener: (context, state) {
          if (state is CategoryError && state.error.isNotEmpty) {
            MethodUtils.toast(state.error);
          } else if (state is CategoryLoaded) {
              categoryArr = (state.categoryDict.data ?? []).where((e) => e.isSelected == true)
                  .toList();
          }
        },
      ),
    );
  }

  Widget body(){
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: categoryArr.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final category = categoryArr[index];

        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ItemListScreen(
                  category: category,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [

                /// ORDER NUMBER
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.grey.shade200,
                  child: Text(
                    (index+1).toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// CATEGORY IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _buildCategoryImage(category.imageUrl ?? ""),
                ),

                const SizedBox(width: 12),

                /// NAME + STATUS
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        (category.isActive ?? true) ? 'Active' : 'Inactive',
                        style: TextStyle(
                          fontSize: 13,
                          color: (category.isActive ?? true)
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// IMAGE HANDLER
  Widget _buildCategoryImage(String imagePath) {
    if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
      return Image.file(
        File(imagePath),
        width: 48,
        height: 48,
        fit: BoxFit.cover,
      );
    }

    /// Placeholder
    return Container(
      width: 48,
      height: 48,
      color: Colors.grey.shade200,
      child: const Icon(
        Icons.fastfood,
        color: Colors.grey,
      ),
    );
  }
}

/// ================= MODEL =================

class MenuCategory {
  final int? id;
  final String name;
  final String image; // local path or network url
  final int order;
  bool isActive;

  MenuCategory({
    this.id,
    required this.name,
    required this.image,
    required this.order,
    required this.isActive,
  });
}
