// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../core/ui_state.dart';
import '../models/category_model.dart';
import '../provider/search_provider.dart';
import '../repositories/category_repositories.dart';
import '../styles/colors.dart';
import '../styles/text_style.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchKeywordController = TextEditingController();
  int selectedIndex = 0;
  SearchProductProvider searchProductProvider =
      SearchProductProvider(categoryRepository: CategoryRepository());
  var category;
  final optionItems = <CategoryModel>[];

  @override
  void initState() {
    super.initState();
    searchProductProvider.getSearchedProducts('', '');
    optionItems.add(CategoryModel('ALL'));
    optionItems.add(CategoryModel('MOUNTAIN'));
    optionItems.add(CategoryModel('BIRDS'));
    optionItems.add(CategoryModel('NATURE'));
    optionItems.add(CategoryModel('ANIMALS'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
        child: Column(
          children: [
            TextField(
              style: keywordText,
              cursorColor: blackColor,
              controller: searchKeywordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 15, top: 10, bottom: 5),
                fillColor: whiteColor,
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.black),
                  onPressed: () {
                    if (searchKeywordController.text.isNotEmpty) {
                      searchProductProvider.getSearchedProducts(
                          category, searchKeywordController.text);
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                hintText: 'Search keywords...',
                hintStyle: hintTextStyle,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: hintColor, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: hintColor, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: hintColor, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: hintColor, width: 1),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            searchByCategory()
          ],
        ),
      ),
    ));
  }

  Widget searchByCategory() {
    return ChangeNotifierProvider<SearchProductProvider>(create: (ctx) {
      return searchProductProvider;
    }, child: Consumer<SearchProductProvider>(builder: (ctx, data, _) {
      var state = data.getSearchLiveData().getValue();
      if (state is IsLoading) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.3,
          child: Center(
            child: CircularProgressIndicator(
              color: blueButtonColor,
            ),
          ),
        );
      } else if (state is Success) {
        return Column(
          children: [
            searchKeywordController.text == ''
                ? SizedBox(
                    height: 40,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: optionItems.length,
                        separatorBuilder: (context, _) =>
                            const SizedBox(width: 3),
                        itemBuilder: (context, index) {
                          return Container(
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  border: Border.all(color: whiteColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4))),
                              height: 14,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedIndex = index;
                                      category = optionItems[index].text;
                                      category == 'ALL'
                                          ? searchProductProvider
                                              .getSearchedProducts('', '')
                                          : searchProductProvider
                                              .getSearchedProducts(category,
                                                  searchKeywordController.text);
                                      print(category);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(3),
                                    elevation: 0,
                                    primary: whiteColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          4), // <-- Radius
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        optionItems[index].text,
                                        style: categoryText,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      selectedIndex == index
                                          ? Container(
                                              height: 2,
                                              color: selectedIndex == index
                                                  ? blueButtonColor
                                                  : whiteColor,
                                              child: Text(
                                                optionItems[index].text,
                                                style: TextStyle(
                                                    color:
                                                        selectedIndex == index
                                                            ? blueButtonColor
                                                            : whiteColor),
                                              ),
                                            )
                                          : SizedBox()
                                    ],
                                  )));
                        }),
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Search result for "${searchKeywordController.text}"',
                      style: categoryText,
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.getSearchResult.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            '${data.getSearchResult.data![index].imageUrl}',
                            fit: BoxFit.fill,
                            height: 17,
                          )),
                    )),
          ],
        );
      } else if (state is IsEmpty) {
        return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Center(
              child: Text('This List Is Empty'),
            ));
      } else if (state is Failure) {
        return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Center(
              child: Text('No search Item Found'),
            ));
      } else {
        return Container();
      }
    }));
  }
}
