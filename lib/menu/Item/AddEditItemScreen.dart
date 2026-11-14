import 'dart:io';
import 'package:fassty_resturents_app/helper/app_utilities/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import '../../helper/localStorage/preference_handler.dart';
import '../../model/category/modelCategory.dart';
import '../../model/item/modelIteamList.dart';
import 'AddEditVariantDialog.dart';
import 'cubit/item_cubit.dart';

class AddEditItemScreen extends StatefulWidget {
  final DataItemList? item;
  final DataCategory? category;

  const AddEditItemScreen({
    Key? key,
     this.item,
     this.category
  }) : super(key: key);

  @override
  State<AddEditItemScreen> createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends State<AddEditItemScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameCtrl;
  late TextEditingController _priceCtrl;
  late TextEditingController _priceDiscountCtrl;
  late TextEditingController _descCtrl;

  bool _isAvailable = true;
  int _foodType = 0;
  File? _image;
  List<Variants> variants = [];
  late ItemCubit _cubit;
  String? uploadedImagePath;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ItemCubit>(context);

    _nameCtrl = TextEditingController(text: widget.item?.name ?? '');
    _priceCtrl = TextEditingController(text: (widget.item?.price ?? "").toString());
    _priceDiscountCtrl = TextEditingController(text: (widget.item?.discountedPrice ?? "").toString());
    _descCtrl =
        TextEditingController(text: widget.item?.description ?? '');

    _isAvailable = widget.item?.isAvailable ?? true;
    _foodType = widget.item?.foodType ?? 0;
    variants = widget.item?.variants ?? [];
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }

    _cubit.uploadPhoto(picked!.path, "item");

  }


  Future<void> _saveItem() async {
    if (!_formKey.currentState!.validate()) return;

    if (variants.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one variant')),
      );
      return;
    }

    String? userId = await PreferenceHandler.getUserId();


    final item = DataItemList(
      id: widget.item?.id ?? 0,
      restaurantId: int.tryParse(userId ?? "") ?? 0,
      categoryId: widget.category?.id ?? 0,
      name: _nameCtrl.text.trim(),
      price: double.tryParse(_priceCtrl.text.trim()) ?? 0.0,
      discountedPrice: double.tryParse(_priceDiscountCtrl.text.trim()) ?? 0.0,
      description: _descCtrl.text.trim(),
      imageUrl: uploadedImagePath ?? '',
      foodType: _foodType,
      isActive: true,
      isAvailable: _isAvailable,
      variants: variants,
    );

    _cubit.addMenuItem(item: item);

  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.item != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(isEdit ? 'Edit Item' : 'Add Item'),
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
          } else if (state is ItemAddLoaded) {
            Navigator.pop(context, true);
          }else if (state is ItemImageLoaded) {
            uploadedImagePath = state.imagePath ?? "";
            print(uploadedImagePath);
          }
        },
      ),
    );
  }

  Widget body(){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [

            /// IMAGE
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => _imagePickerSheet(),
                );
              },
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  image: _image != null
                      ? DecorationImage(
                    image: FileImage(_image!), // local image
                    fit: BoxFit.cover,
                  )
                      : (widget.item?.imageUrl != null &&
                      widget.item!.imageUrl!.isNotEmpty)
                      ? DecorationImage(
                    image: NetworkImage(widget.item!.imageUrl!), // backend image
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: _image == null
                    ? const Icon(Icons.camera_alt, size: 40)
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            /// ITEM NAME
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
              v!.isEmpty ? 'Required' : null,
            ),

            const SizedBox(height: 20),

            /// ITEM PRICE
            TextFormField(
              controller: _priceCtrl,
              decoration: const InputDecoration(
                labelText: 'Item Price',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
              v!.isEmpty ? 'Required' : null,
            ),

            const SizedBox(height: 16),

            /// ITEM DISCOUNT PRICE
            TextFormField(
              controller: _priceDiscountCtrl,
              decoration: const InputDecoration(
                labelText: 'Item Discount Price',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
              v!.isEmpty ? 'Required' : null,
            ),

            const SizedBox(height: 16),

            /// DESCRIPTION
            TextFormField(
              controller: _descCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              validator: (v) =>
              v!.isEmpty ? 'Required' : null,
            ),

            const SizedBox(height: 16),

            /// VEG / NON VEG
            Text(
              'Food Type',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              children: [
                Radio<int>(
                  value: FoodType.veg.index,
                  groupValue: _foodType,
                  onChanged: (v) {
                    setState(() => _foodType = v!);
                  },
                ),
                const Text('Veg 🟢'),
                const SizedBox(width: 20),
                Radio<int>(
                  value: FoodType.nonVeg.index,
                  groupValue: _foodType,
                  onChanged: (v) {
                    setState(() => _foodType = v!);
                  },
                ),
                const Text('Non-Veg 🔴'),
              ],
            ),

            const SizedBox(height: 16),

            /// VARIANTS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Variants',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () => _openVariantDialog(),
                  child: const Text('+ Add Variant'),
                ),
              ],
            ),

            if (variants.isEmpty)
              const Text(
                'No variants added',
                style: TextStyle(color: Colors.grey),
              ),

            ...variants.asMap().entries.map(
                  (entry) {
                final index = entry.key;
                final variant = entry.value;

                return Card(
                  elevation: 1,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: variant.imageUrl != null &&
                          variant.imageUrl!.isNotEmpty
                          ? Image.network(
                        variant.imageUrl!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _imagePlaceholder();
                        },
                      )
                          : _imagePlaceholder(),
                    ),

                    title: Text(
                      variant.variantName ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),

                        /// Price
                        Text('₹ ${variant.price}'),

                        /// Description
                        if (variant.description != null &&
                            variant.description!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              variant.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                      ],
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// EDIT
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () {
                            _openVariantDialog(
                              variant: variant,
                              index: index,
                            );
                          },
                        ),

                        /// DELETE
                        IconButton(
                          icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                          onPressed: () {
                            _deleteVariant(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );

                  },
            ),


            const SizedBox(height: 16),

            /// AVAILABILITY
            SwitchListTile(
              title: const Text('Available'),
              value: _isAvailable,
              onChanged: (v) {
                setState(() {
                  _isAvailable = v;
                });
              },
            ),

            const SizedBox(height: 30),

            /// SAVE
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _saveItem,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, // your purple theme
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:
                Text(widget.item != null ? 'Update Item' : 'Add Item'),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _imagePlaceholder() {
    return Container(
      width: 50,
      height: 50,
      color: Colors.grey.shade200,
      child: const Icon(
        Icons.image,
        color: Colors.grey,
        size: 24,
      ),
    );
  }


  Widget _imagePickerSheet() {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  void _openVariantDialog({Variants? variant, int? index}) {
    showDialog(
      context: context,
      builder: (_) => AddEditVariantDialog(
        variant: variant,
        onSave: (updatedVariant) {
          setState(() {
            if (index == null) {
              variants.add(updatedVariant);
              print("Length of Variants ${variants.length}");
              if(variants.length>0){
                print("variant Array ${variants}");
                print("Description ${variants[0].description}");
                print("variant image ${variants[0].imageUrl}");
              }
            } else {
              variants[index] = updatedVariant;
            }
          });
        },
      ),
    );
  }

  void _deleteVariant(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Variant'),
        content: const Text('Are you sure you want to delete this variant?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                variants.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

}

//========= Model

enum FoodType { veg, nonVeg, both }
//
// class MenuItem {
//   final int? id;
//   final int restaurantId;
//   final int categoryId;
//   final String name;
//   final String description;
//   final double price;
//   final double discountPrice;
//   final String imageUrl;
//   final int foodType;
//   final bool isActive;
//   final bool isAvailable;
//   final List<ItemVariant> variants;
//
//   MenuItem({
//     this.id,
//     required this.restaurantId,
//     required this.categoryId,
//     required this.name,
//     required this.price,
//     required this.discountPrice,
//     required this.description,
//     required this.imageUrl,
//     required this.foodType,
//     required this.isActive,
//     required this.isAvailable,
//     required this.variants,
//   });
//
//   /// ✅ REQUIRED FOR API
//   Map<String, dynamic> toJson() {
//     return {
//       "id": id ?? 0,
//       "restaurantId": restaurantId,
//       "categoryId": categoryId,
//       "name": name,
//       "description": description,
//       "price": price,
//       "discountedPrice": discountPrice, // backend key
//       "imageUrl": imageUrl,
//       "foodType": foodType,
//       "isAvailable": isAvailable,
//       "isActive": isActive,
//       "variants": variants.map((e) => e.toJson()).toList(),
//     };
//   }
// }
//
// class ItemVariant {
//   final int? id;
//   final String variantName;
//   final double price;
//   final bool isDefault;
//
//   ItemVariant({
//     this.id,
//     required this.variantName,
//     required this.price,
//     required this.isDefault,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       "id": id ?? 0,
//       "variantName": variantName,
//       "price": price,
//       "isDefault": isDefault,
//     };
//   }
// }




