import 'package:bloc/bloc.dart';
import 'package:fassty_resturents_app/model/category/modelAddCategory.dart';
import 'package:fassty_resturents_app/model/category/modelCategory.dart';
import 'package:meta/meta.dart';
import '../../../../helper/app_utilities/method_utils.dart';
import '../../../../helper/constant/appMessages.dart';
import '../../../../network_configs/networkRequest.dart';
import '../../../model/item/modelAddItems.dart';
import '../../../model/item/modelIteamList.dart';
import '../AddEditItemScreen.dart';
import '../repo/itemRepo.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit() : super(ItemInitial());

  final ItemRepo itemRepo =
  ItemRepo(networkRequest: NetworkRequest());

  /// Get Item List
  void getItems(String categoryId) async {
    try {
      emit(ItemLoading());

      if (await MethodUtils.isInternetPresent()) {
        final response = await itemRepo.itemList(categoryId);

        if (response.isSuccess) {
          if (response.resObject == null) {
            emit(ItemError(error: 'Item data not found'));
            return;
          }

          emit(ItemLoaded(
            msg: response.resObject!.message ?? "",
            itemDict: response.resObject!,
          ));
        } else {
          emit(ItemError(error: response.errorCause));
        }
      } else {
        emit(ItemError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      MethodUtils.toast("Something went wrong!");
      emit(ItemError(error: ""));
    }
  }

  /// Add Selected Items
  void addMenuItem({required DataItemList item,}) async {
    try {
      emit(ItemLoading());

      if (!await MethodUtils.isInternetPresent()) {
        emit(ItemError(error: AppMessages.getNoInternetMsg));
        return;
      }

      final response = await itemRepo.addMenuItem(
        item: item, // convert to Map
      );

      if (response.isSuccess) {
        emit(ItemAddLoaded(
          msg: response.resObject?.message ?? "Item added successfully",
          itemDict: response.resObject!,
        ));
      } else {
        emit(ItemError(error: response.errorCause));
      }
    } catch (e) {
      MethodUtils.toast("Something went wrong!");
      emit(ItemError(error: ""));
    }
  }

  /// Upload Items
  void uploadPhoto(String imageFile, String comeFrom) async {
    try {
      emit(ItemLoading());
      if (await MethodUtils.isInternetPresent()) {
        final response = await itemRepo.uploadImage(imageFile, "ItemImages");
        if (response.isSuccess) {
          if(comeFrom == "item"){
            emit(ItemImageLoaded(imagePath: response.resObject?["cloudinaryUrl"]));
          }else{
            emit(VarientImageLoaded(imagePath: response.resObject?["cloudinaryUrl"]));
          }
        } else {
          emit(ItemError(error: response.errorCause));
        }
      } else {
        emit(ItemError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(ItemError(error: e.toString()));
    }
  }

  /// Delete Selected Items
  void deleteMenuItem({required String id,}) async {
    try {
      emit(ItemLoading());

      if (!await MethodUtils.isInternetPresent()) {
        emit(ItemError(error: AppMessages.getNoInternetMsg));
        return;
      }

      final response = await itemRepo.deleteMenuItem(
        itemId: id, // convert to Map
      );

      if (response.isSuccess) {
        emit(ItemDeleteLoaded(
          msg: response.resObject?.message ?? "Item Deleted successfully",
        ));
      } else {
        emit(ItemError(error: response.errorCause));
      }
    } catch (e) {
      MethodUtils.toast("Something went wrong!");
      emit(ItemError(error: ""));
    }
  }


  /// Reset State
  void refresh() {
    emit(ItemInitial());
  }
}
