import 'package:flutter/cupertino.dart';

import '../../consts/imports.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final CourseController controller = Get.find();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDetails();
    });
  }

  Future<void> getDetails() async {
    controller.selectedFilterIndexFunc(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: XColors.themeColor),
        ),
        title: const Text("Search Filter",
            style: TextStyle(
                fontSize: 16,
                fontFamily: XFonts.poppinsSemiBold,
                color: XColors.themeColor)),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<CourseController>(builder: (val) {
            return Flexible(
              flex: 1,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemCount: val.filters.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: val.selectedFilterIndex == index
                          ? XColors.themeColorLight
                          : Colors.transparent,
                      border: Border.all(
                        color: val.selectedFilterIndex == index
                            ? XColors.themeColorLight
                            : Colors.grey.shade100,
                        width: val.selectedFilterIndex == index ? 1.0 : 0.0,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        val.filters[index],
                        style: TextStyle(
                          fontFamily: XFonts.poppinsMedium,
                          fontSize: val.selectedFilterIndex == index ? 13 : 11,
                          color: val.selectedFilterIndex == index
                              ? Colors.black
                              : Colors.grey.shade700,
                        ),
                      ),
                      onTap: () {
                        val.selectedFilterIndexFunc(index);
                      },
                    ),
                  );
                },
              ),
            );
          }),
          GetBuilder<CourseController>(builder: (val) {
            return Visibility(
              visible: val.selectedFilterIndex == 0,
              child: Flexible(
                  flex: 2,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: val.categoryListWithoutAll.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(val.categoryListWithoutAll[index].name),
                        leading: Checkbox(
                          value: val.selectedCategoryIndex[index],
                          onChanged: (value) {
                            val.updateSelectedCategoryIndexFunc(
                                index, value ?? false);
                          },
                        ),
                      );
                    },
                  )),
            );
          }),
          GetBuilder<CourseController>(builder: (val) {
            return Visibility(
              visible: val.selectedFilterIndex == 1,
              child: Flexible(
                  flex: 2,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: val.brands.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(val.brands[index]),
                        leading: Checkbox(
                          value: val.selectedBrandIndex[index],
                          onChanged: (value) {
                            val.updateSelectedBrandIndexFunc(
                                index, value ?? false);
                          },
                        ),
                      );
                    },
                  )),
            );
          }),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            GetBuilder<CourseController>(builder: (val) {
              return ElevatedButtonWidgets.filterElevatedButton(
                  onTap: () {
                    val.clearFilter();
                    Get.back();
                  },
                  buttonColor: Colors.white,
                  borderColor: XColors.themeColor,
                  text: "Clear Filter",
                  textColor: XColors.themeColor);
            }),
            10.widthBox,
            GetBuilder<CourseController>(builder: (val) {
              return Expanded(
                child: ElevatedButtonWidgets.filterElevatedButton(
                    onTap: () {
                      if (val.selectedBrandIndex
                              .any((element) => element == true) ||
                          val.selectedCategoryIndex
                              .any((element) => element == true)) {
                        val.filterProduct();

                        Get.back();
                      } else {
                        toast(msg: "Please select at least one filter");
                      }
                    },
                    buttonColor: XColors.themeColor,
                    text: "Apply Filter"),
              );
            })
          ],
        ),
      ),
    );
  }
}
