import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import '../../model/item/modelIteamList.dart';
import 'cubit/item_cubit.dart';

class AddEditVariantDialog extends StatefulWidget {
  final Variants? variant;
  final Function(Variants) onSave;

  const AddEditVariantDialog({
    Key? key,
    this.variant,
    required this.onSave,
  }) : super(key: key);

  @override
  State<AddEditVariantDialog> createState() =>
      _AddEditVariantDialogState();
}

class _AddEditVariantDialogState extends State<AddEditVariantDialog> {
  late TextEditingController _nameCtrl;
  late TextEditingController _priceCtrl;
  late TextEditingController _descCtrl;

  File? _variantImage;
  final ImagePicker _picker = ImagePicker();
  String? uploadedVarientImagePath;
  late ItemCubit _cubit;

  String? _nameError;
  String? _priceError;
  String? _descError;
  String? _imageError;


  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ItemCubit>(context);

    _nameCtrl =
        TextEditingController(text: widget.variant?.variantName ?? '');
    _priceCtrl =
        TextEditingController(text: widget.variant?.price.toString() ?? '');
    _descCtrl =
        TextEditingController(text: widget.variant?.description ?? '');

    if (widget.variant?.imageUrl != null) {
      _variantImage = File(widget.variant!.imageUrl!);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image =
    await _picker.pickImage(source: source, imageQuality: 70);

    if (image != null) {
      setState(() {
        _variantImage = File(image.path);
      });
    }

    _cubit.uploadPhoto(image!.path, "varient");
  }

  void _save() {
    setState(() {
      _nameError = null;
      _priceError = null;
      _descError = null;
      _imageError = null;
    });

    bool isValid = true;

    if (_nameCtrl.text.trim().isEmpty) {
      _nameError = 'Variant name is required';
      isValid = false;
    }

    if (_priceCtrl.text.trim().isEmpty) {
      _priceError = 'Price is required';
      isValid = false;
    } else if (double.tryParse(_priceCtrl.text) == null) {
      _priceError = 'Enter a valid price';
      isValid = false;
    }

    if (_descCtrl.text.trim().isEmpty) {
      _descError = 'Description is required';
      isValid = false;
    } else if (_descCtrl.text.trim().length < 10) {
      _descError = 'Description must be at least 10 characters';
      isValid = false;
    }

    if (uploadedVarientImagePath == null ||
        uploadedVarientImagePath!.isEmpty) {
      _imageError = 'Variant image is required';
      isValid = false;
    }

    if (!isValid) {
      setState(() {});
      return;
    }

    widget.onSave(
      Variants(
        id: widget.variant?.id ?? 0,
        variantName: _nameCtrl.text.trim(),
        price: double.parse(_priceCtrl.text),
        description: _descCtrl.text.trim(),
        imageUrl: uploadedVarientImagePath,
        isDefault: false,
      ),
    );

    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    final isEdit = widget.variant != null;

    return BlocConsumer<ItemCubit, ItemState>(
      builder: (context, state) {
        if (state is ItemLoading) {
          return Stack(
            children: [
              body(isEdit),
              const AppLoaderProgress(),
            ],
          );
        }
        return body(isEdit);
      },
      listener: (context, state) {
        if (state is ItemError && state.error.isNotEmpty) {
          MethodUtils.toast(state.error);
        } else if (state is ItemAddLoaded) {
          Navigator.pop(context, true);
        }else if (state is VarientImageLoaded) {
          uploadedVarientImagePath = state.imagePath ?? "";
          print("Uploaded Variant Image Path: ${uploadedVarientImagePath}");
        }
      },
    );
  }

  Widget body(bool isEdit){
    return AlertDialog(
      title: Text(isEdit ? 'Edit Variant' : 'Add Variant'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Variant Name
            TextField(
              controller: _nameCtrl,
              decoration: InputDecoration(
                labelText: 'Variant Name (Half / Full)',
                errorText: _nameError,
              ),
            ),

            /// Price
            TextField(
              controller: _priceCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price',
                errorText: _priceError,
              ),
            ),

            /// Description (Multiline)
            TextField(
              controller: _descCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                errorText: _descError,
              ),
            ),

            const SizedBox(height: 12),

            /// Image Preview
            GestureDetector(
              onTap: () => _showImagePickerOptions(context),
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _variantImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _variantImage!,
                    fit: BoxFit.cover,
                  ),
                )
                    : const Center(
                  child: Text(
                    'Tap to select image',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _save,
          child: const Text('Save'),
        ),
      ],
    );
  }

  /// Bottom Sheet for Camera / Gallery
  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
