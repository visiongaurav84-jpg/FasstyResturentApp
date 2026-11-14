import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helper/app_utilities/app_theme.dart';
import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import '../../model/category/modelCategory.dart';
import 'CategoryScreen.dart';
import 'cubit/category_cubit.dart';

class AddEditCategoryScreen extends StatefulWidget {
  final MenuCategory? category;

  const AddEditCategoryScreen({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  State<AddEditCategoryScreen> createState() =>
      _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  late CategoryCubit _cubit;
  List<DataCategory> categoryArr = [];

  /// Selected category IDs
  final Set<int> selectedCategoryIds = {};


  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<CategoryCubit>(context);
    _cubit.getCategories("Add");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false; // prevent default pop since we already handled it
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true); // or just Navigator.pop(context);
            },
          ),
          title: const Text('Categories'),
          backgroundColor: primaryColor,
          actions: [
            TextButton(
              onPressed: selectedCategoryIds.isEmpty ? null : _onAddPressed,
              child: Text(
                'ADD',
                style: TextStyle(
                  color: selectedCategoryIds.isEmpty
                      ? Colors.white54
                      : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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
            if (state is CategoryError) {
              MethodUtils.toast(state.error);
            } else if (state is CategoryAddLoaded) {
              print("Categories added successfully>>>");
              Navigator.pop(context, true); // 👈 important
          } else if (state is CategoryLoaded) {
              categoryArr = state.categoryDict.data ?? [];
            }
          },
        ),
      ),
    );
  }

  /// MAIN LIST
  Widget body() {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: categoryArr.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final category = categoryArr[index];
        final isSelected =
        selectedCategoryIds.contains(category.id);

        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _toggleSelection(category.id),
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
                    (index + 1).toString(),
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
                  child: _buildCategoryImage(
                      category.imageUrl ?? ""),
                ),

                const SizedBox(width: 12),

                /// NAME + STATUS
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
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
                        (category.isActive ?? true)
                            ? 'Active'
                            : 'Inactive',
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

                /// CHECKBOX
                Checkbox(
                  value: isSelected,
                  activeColor: primaryColor,
                  onChanged: (_) =>
                      _toggleSelection(category.id),
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
    if (imagePath.isNotEmpty &&
        File(imagePath).existsSync()) {
      return Image.file(
        File(imagePath),
        width: 48,
        height: 48,
        fit: BoxFit.cover,
      );
    }

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

  /// TOGGLE SELECTION
  void _toggleSelection(int? id) {
    if (id == null) return;

    setState(() {
      if (selectedCategoryIds.contains(id)) {
        selectedCategoryIds.remove(id);
      } else {
        selectedCategoryIds.add(id);
      }
    });
  }

  /// ADD BUTTON ACTION
  void _onAddPressed() {
    final selectedCategories = categoryArr
        .where((e) => selectedCategoryIds.contains(e.id))
        .toList();

    /// Use this list wherever needed
    print(selectedCategoryIds);
    debugPrint(
        'Selected Categories: ${selectedCategories.map((e) => e.name).toList()}');

    _cubit.addSelectedCategories(
      selectedCategoryIds: selectedCategoryIds,
    );


    MethodUtils.toast(
        '${selectedCategories.length} categories selected');
  }
}
