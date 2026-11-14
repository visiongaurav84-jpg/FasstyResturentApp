import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../helper/app_utilities/method_utils.dart';
import '../../../../helper/constant/appMessages.dart';
import '../../../../network_configs/networkRequest.dart';
import '../../../model/category/modelAddCategory.dart';
import '../../../model/category/modelCategory.dart';
import '../repo/categoryRepo.dart';
part 'category_state.dart';


class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  final CategoryRepo categoryRepo =
  CategoryRepo(networkRequest: NetworkRequest());

  void getCategories(String comeFrom) async {
    try {
      emit(CategoryLoading());

      if (await MethodUtils.isInternetPresent()) {
        final response = await categoryRepo.categoryList(comeFrom);

        if (response.isSuccess) {
          if (response.resObject == null) {
            emit(CategoryError(error: 'Category data not found'));
            return;
          }

          emit(CategoryLoaded(
            msg: response.resObject!.message ?? "",
            categoryDict: response.resObject!,
          ));

        } else {
          emit(CategoryError(error: response.errorCause));
        }
      } else {
        emit(CategoryError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      MethodUtils.toast("Something went wrong!");
      emit(CategoryError(error: ""));
    }
  }

  void addSelectedCategories({
    required Set<int> selectedCategoryIds,
  }) async {
    try {
      emit(CategoryLoading());

      if (!await MethodUtils.isInternetPresent()) {
        emit(CategoryError(error: AppMessages.getNoInternetMsg));
        return;
      }

      final response = await categoryRepo.addSelectedCategories(categoryIds: selectedCategoryIds.toList());

      if (response.isSuccess) {
        if (response.resObject == null) {
          emit(CategoryError(error: 'Category data not found'));
          return;
        }

        emit(CategoryAddLoaded(
          msg: response.resObject!.message ?? "Categories added successfully",
          categoryDict: response.resObject!,
        ));
      } else {
        emit(CategoryError(error: response.errorCause));
      }
    } catch (e) {
      MethodUtils.toast("Something went wrong!");
      emit(CategoryError(error: ""));
    }
  }


  void refresh() {
    emit(CategoryInitial());
  }
}
