// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../models/search_category_model.dart';
import '../repositories/category_repositories.dart';

class SearchProductProvider extends ChangeNotifier {
  CategoryRepository categoryRepository;

  SearchProductProvider({required this.categoryRepository});

  var getSearchResult = SearchCategoryModel();
  LiveData<UIState<SearchCategoryModel>> getSearchedData =
      LiveData<UIState<SearchCategoryModel>>();

  LiveData<UIState<SearchCategoryModel>> getSearchLiveData() {
    return this.getSearchedData;
  }

  void initialState() {
    getSearchedData.setValue(Initial());
    notifyListeners();
  }

  getSearchedProducts(dynamic category, dynamic keyword) async {
    try {
      getSearchedData.setValue(IsLoading());
      getSearchResult =
          await categoryRepository.getSearchCategoryData(category, keyword);
      if (getSearchResult.status == "success") {
        getSearchedData.setValue(Success(SearchCategoryModel()));
      } else {
        getSearchedData.setValue(IsEmpty());
      }
    } catch (ex) {
      getSearchedData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
    // return true;
  }
}
