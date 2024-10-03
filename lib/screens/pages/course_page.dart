import '../../consts/imports.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvoked: (val) {
          final BottomNavController controller = Get.find();
          controller.tappedIndexFunc(0);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              65.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Course",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: XFonts.poppinsBold)),
                  Image.asset(XImages.user_image, height: 40, width: 40)
                ],
              ),
              15.heightBox,
              GetBuilder<CourseController>(builder: (val) {
                return InkWell(
                  onTap: () {
                    Get.to(() => const SearchPage());
                  },
                  child: TextFormFieldsWidgets.searchTextField(
                    onChanged: (String val) {},
                    showSuffixIcon: false,
                      isAbsorbing: true,
                      onTap: () {
                        Get.to(() => const FilterPage());
                      },
                      hintText: "Find Course",
                      controller: val.searchController),
                );
              }),
              15.heightBox,
              const Text("Choice your course",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: XFonts.poppinsSemiBold)),
              6.heightBox,
              GetBuilder<CourseController>(builder: (val) {
                return SingleChildScrollView(
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
                );
              }),
              12.heightBox,
              GetBuilder<CourseController>(builder: (val) {
                return Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: val.filteredList.length,
                      itemBuilder: (context, index) {
                        final data = val.filteredList[index];
                        return courseWidget(data, context);
                      }),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
