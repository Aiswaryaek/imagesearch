// ignore_for_file: prefer_typing_uninitialized_variables

import '../services/category_services.dart';
import '../services/web_service.dart';

class CategoryRepository {
  var webService;

  CategoryRepository() {
    this.webService = Webservice();
  }

  Future getSearchCategoryData(dynamic category, dynamic keyword) =>
      webService?.get(getSearchApi(category, keyword));
}
