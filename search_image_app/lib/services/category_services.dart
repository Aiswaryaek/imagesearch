import 'dart:convert';
import '../models/search_category_model.dart';
import '../utilities/api_helpers.dart';

Resource<SearchCategoryModel> getSearchApi(dynamic category, dynamic keyword) {
  return Resource(
      url: '?category=$category&keyword=$keyword',
      parse: (response) {
        print(response.body);
        Map<String, dynamic> getSearchCategoryMap = json.decode(response.body);
        SearchCategoryModel searchCategoryResult =
            SearchCategoryModel.fromJson(getSearchCategoryMap);
        return searchCategoryResult;
      });
}
