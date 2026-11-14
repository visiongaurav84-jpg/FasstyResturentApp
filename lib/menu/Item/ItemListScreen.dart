import 'dart:ffi';
import 'dart:io';
import 'package:fassty_resturents_app/helper/app_utilities/app_theme.dart';
import 'package:fassty_resturents_app/model/item/modelIteamList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import '../../model/category/modelCategory.dart';
import 'AddEditItemScreen.dart';
import 'cubit/item_cubit.dart';

class ItemListScreen extends StatefulWidget {
  final DataCategory category;

  const ItemListScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {

  late ItemCubit _cubit;
  late List<DataItemList> itemArr = [];

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ItemCubit>(context);
    _cubit.getItems(widget.category.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(widget.category.name ?? ""),
      ),

      /// ADD ITEM
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddEditItemScreen(
                category: widget.category,
              ),
            ),
          );

          /// REFRESH categories after coming back
          if (result == true) {
            _cubit.getItems(widget.category.id.toString());
          }

        },
        child: const Icon(Icons.add),
      ),

      body: BlocConsumer<ItemCubit, ItemState>(
        builder: (context, state) {
          if (state is ItemLoading) {
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
          if (state is ItemError && state.error.isNotEmpty) {
            MethodUtils.toast(state.error);
          } else if (state is ItemLoaded) {
            itemArr = state.itemDict.data ?? [];
          } else if (state is ItemDeleteLoaded) {
            _cubit.getItems(widget.category.id.toString());
          }
        },
      ),
    );
  }

  Widget body(){
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: itemArr.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = itemArr[index];

        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddEditItemScreen(
                  category: widget.category,
                  item: item,
                ),
              ),
            );

            /// REFRESH categories after coming back
            if (result == true) {
              _cubit.getItems(widget.category.id.toString());
            }

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
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _buildItemImage(item.imageUrl ?? ""),
                ),

                const SizedBox(width: 12),

                /// DETAILS
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// NAME + VEG/NON-VEG
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.name ?? "",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          _foodTypeIcon(item.foodType ?? 0),
                        ],
                      ),

                      const SizedBox(height: 4),

                      /// DESCRIPTION
                      Text(
                        item.description ?? "",
                        maxLines: 30,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// PRICE + VARIANTS
                      Text(
                        'From ₹${item.price} • ${item.variants?.length ?? 0} variant(s)',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                /// AVAILABLE TOGGLE
                SizedBox(
                  width: 48, // prevents layout squeeze
                  child: Switch(
                    value: item.isAvailable ?? true,
                    onChanged: (value) {
                      setState(() {
                        item.isAvailable = value;
                      });
                      _cubit.deleteMenuItem(id: item.id.toString());
                      // TODO: API call
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// IMAGE BUILDER
  /// IMAGE BUILDER
  Widget _buildItemImage(String path) {
    // 1️⃣ Local file image
    if (path.isNotEmpty && File(path).existsSync()) {
      return Image.file(
        File(path),
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      );
    }

    // 2️⃣ Network image
    if (path.isNotEmpty && path.startsWith('http')) {
      return Image.network(
        path,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _placeholderImage();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const SizedBox(
            width: 60,
            height: 60,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        },
      );
    }

    // 3️⃣ Placeholder
    return _placeholderImage();
  }

  /// Placeholder widget
  Widget _placeholderImage() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.image_not_supported,
        color: Colors.grey,
      ),
    );
  }

  /// VEG / NON-VEG ICON
  Widget _foodTypeIcon(int type) {
    return Icon(
      Icons.circle,
      size: 10,
      color: type == true ? Colors.green : Colors.red,
    );
  }
}
