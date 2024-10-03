import 'package:digital_salt/consts/imports.dart';

class CourseController extends GetxController {
  TextEditingController searchControllerNew = TextEditingController();
  TextEditingController get searchController => searchControllerNew;

  void searchControllerFunc(String val) {
    searchControllerNew.text = val;
    update();
  }

  List<CoursesModel> coursesListNew = [];
  List<CoursesModel> get coursesList => coursesListNew;

  void coursesListFunc(List<CoursesModel> val) {
    coursesListNew = val;
    update();
  }

  List<Product> listNew = [];
  List<Product> get list => listNew;

  void listFunc(List<Product> val) {
    listNew = val;
    update();
  }

  List<Product> filteredListNew = [];
  List<Product> get filteredList => filteredListNew;

  void filteredListFunc(List<Product> val) {
    filteredListNew = val;
    update();
  }

  List<Product> filteredSearchListNew = [];
  List<Product> get filteredSearchList => filteredSearchListNew;

  void filteredSearchListFunc(List<Product> val) {
    filteredSearchListNew = val;
    update();
  }

  bool isSearchingNew = false;
  bool get isSearching => isSearchingNew;

  void isSearchingFunc(bool val) {
    isSearchingNew = val;
    update();
  }

  void searchProduct(String text) {
    if (text.isEmpty) {
      if (isSearchingNew == true) {
        isSearchingFunc(false);
      }
      filteredSearchListFunc(list);
    } else {
      if (isSearchingNew == false) {
        isSearchingFunc(true);
      }
      List<Product> newList = list
          .where((val) =>
              val.title.toLowerCase().contains(text.toLowerCase()) ||
              val.description.toLowerCase().contains(text.toLowerCase()))
          .toList();
      filteredSearchListFunc(newList);
    }
  }

  void filterProduct() {
    List<Product> newList = [];

    if (selectedCategoryIndex.any((element) => element == true)) {
      List<String> selectedCatElements = getFilteredBrandCat("Categories");
      print("Selected Elements : ${selectedCatElements.toString()}");

      newList = list.where((product) {
        return selectedCatElements.contains(product.category);
      }).toList();

      if (selectedBrandIndex.any((element) => element == true)) {
        List<String> selectedElements = getFilteredBrandCat("Brands");
        newList = list.where((product) {
          return selectedElements.contains(product.brand) &&
              selectedCatElements.contains(product.category);
        }).toList();
      }
    } else {
      if (selectedBrandIndex.any((element) => element == true)) {
        List<String> selectedElements = getFilteredBrandCat("Brands");
        newList = list.where((product) {
          return selectedElements.contains(product.brand);
        }).toList();
      }
    }

    filteredSearchListFunc(newList);
    isSearchingFunc(true);
  }

  void clearFilter() {
    selectedCategoryIndexAddAllFunc();
    getAllBrands();
    isSearchingFunc(false);
  }

  List<String> getFilteredBrandCat(String type) {
    if (type == "Brands") {
      List<String> selectedElements = [];

      for (int i = 0; i < selectedBrandIndex.length; i++) {
        if (selectedBrandIndex[i]) {
          selectedElements.add(brands[i]);
        }
      }
      return selectedElements;
    } else {
      List<String> selectedElements = [];

      for (int i = 0; i < selectedCategoryIndex.length; i++) {
        if (selectedCategoryIndex[i]) {
          selectedElements.add(categoryListWithoutAll[i].slug);
        }
      }
      return selectedElements;
    }
  }

  Future<void> getProductsData() async {
    List<Product> newList = await DioWebService.getAllProducts();
    if (newList.isNotEmpty) {
      listFunc(newList);
      filteredListFunc(newList);
      filteredSearchListFunc(newList);
    }
  }

  List<CategoryModel> categoryListNew = [];
  List<CategoryModel> get categoryList => categoryListNew;

  void categoryListFunc(List<CategoryModel> val) {
    categoryListNew = val;
    update();
  }

  List<CategoryModel> categoryListWithoutAllNew = [];
  List<CategoryModel> get categoryListWithoutAll => categoryListWithoutAllNew;

  void categoryListWithoutAllFunc(List<CategoryModel> val) {
    categoryListWithoutAllNew = val;
    update();
  }

  CategoryModel? selectedCategoryNew;
  CategoryModel? get selectedCategory => selectedCategoryNew;

  void selectedCategoryFunc(CategoryModel? val) {
    selectedCategoryNew = val;
    update();
  }

  void filterProductList(String slug) {
    if (slug == "All") {
      filteredListFunc(listNew);
    } else {
      List<Product> newList =
          list.where((element) => element.category == slug).toList();
      filteredListFunc(newList);
    }
  }

  Future<void> getCategoryData() async {
    List<CategoryModel> newList = await DioWebService.getAllCategories();
    if (newList.isNotEmpty) {
      categoryListWithoutAllFunc(newList.toList());
      newList.insert(0, CategoryModel(name: "All", slug: "All", url: ""));
      categoryListFunc(newList);
      selectedCategoryFunc(newList[0]);
      selectedCategoryIndexAddAllFunc();
    }
  }

  bool checkIsSelected(CategoryModel cat) {
    if (selectedCategoryNew?.name == cat.name) {
      return true;
    }
    return false;
  }

  String convertDecimalToString(double val) {
    int valInInt = val.toInt();
    return valInInt.toString();
  }

  List<String> filtersNew = ["Categories", "Brands"];
  List<String> get filters => filtersNew;

  int selectedFilterIndexNew = 0;
  int get selectedFilterIndex => selectedFilterIndexNew;

  void selectedFilterIndexFunc(int val) {
    selectedFilterIndexNew = val;
    update();
  }

  List<bool> selectedCategoryIndexNew = [];
  List<bool> get selectedCategoryIndex => selectedCategoryIndexNew;

  void selectedCategoryIndexFunc(List<bool> val) {
    selectedCategoryIndexNew = val;
    update();
  }

  void selectedCategoryIndexAddAllFunc() {
    List<bool> newList =
        List.generate(categoryListWithoutAll.length, (index) => false);
    selectedCategoryIndexFunc(newList);
  }

  void updateSelectedCategoryIndexFunc(int index, bool val) {
    selectedCategoryIndexNew[index] = val;
    update();
  }

  List<String> brandsNew = [];
  List<String> get brands => brandsNew;

  void brandsFunc(List<String> val) {
    brandsNew = val;
    update();
  }

  void getAllBrands() {
    List<String> newList = [];
    Set<String> brandsName = {};

    for (int index = 0; index < list.length; index++) {
      if (list[index].brand != null) {
        String brand = list[index].brand;
        brandsName.add(brand);
      }
    }

    newList = brandsName.toList();
    brandsFunc(newList);

    print("Length : ${newList.length}");

    List<bool> newBoolList = List.generate(newList.length, (index) => false);
    selectedBrandIndexFunc(newBoolList);
  }

  List<bool> selectedBrandIndexNew = [];
  List<bool> get selectedBrandIndex => selectedBrandIndexNew;

  void selectedBrandIndexFunc(List<bool> val) {
    selectedBrandIndexNew = val;
    update();
  }

  void updateSelectedBrandIndexFunc(int index, bool val) {
    selectedBrandIndexNew[index] = val;
    update();
  }
}
