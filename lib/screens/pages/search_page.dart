import '../../consts/imports.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final CourseController controller = Get.find();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDetails();
    });
  }

  Future<void> getDetails() async {
    controller.isSearchingFunc(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            60.heightBox,
            const Text("Search Page",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: XFonts.poppinsBold)),
            15.heightBox,
            GetBuilder<CourseController>(builder: (val) {
              return TextFormFieldsWidgets.searchTextField(
                  onChanged: (String value) {
                    val.searchProduct(value);
                  },
                  showSuffixIcon: true,
                  isAbsorbing: false,
                  onTap: () {
                    Get.to(() => const FilterPage());
                  },
                  hintText: "Find Course",
                  controller: val.searchController);
            }),
            20.heightBox,
            GetBuilder<CourseController>(builder: (val) {
              return Visibility(
                visible: val.isSearching == false,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: val.categoryList
                          .map((e) => InkWell(
                                onTap: () {
                                  val.selectedCategoryFunc(e);
                                  val.filterProductList(e.slug);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: val.checkIsSelected(e)
                                          ? XColors.themeColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(e.name,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: val.checkIsSelected(e)
                                              ? Colors.white
                                              : Colors.grey.shade500,
                                          fontFamily: XFonts.poppinsMedium)),
                                ),
                              ))
                          .toList()),
                ),
              );
            }),
            GetBuilder<CourseController>(builder: (val) {
              return Visibility(
                visible: val.isSearching,
                child: const Text("Search Results",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: XFonts.poppinsSemiBold)),
              );
            }),
            12.heightBox,
            GetBuilder<CourseController>(builder: (val) {
              return Visibility(
                visible: val.isSearching == false,
                child: Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: val.filteredList.length,
                      itemBuilder: (context, index) {
                        final data = val.filteredList[index];
                        return courseWidget(data, context);
                      }),
                ),
              );
            }),
            GetBuilder<CourseController>(builder: (val) {
              return Visibility(
                visible: val.isSearching,
                child: Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: val.filteredSearchList.length,
                      itemBuilder: (context, index) {
                        final data = val.filteredSearchList[index];
                        return courseWidget(data, context);
                      }),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
