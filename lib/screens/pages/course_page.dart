import '../../consts/imports.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
            TextFormFieldsWidgets.searchTextField(
                onTap: () {},
                hintText: "Search Course",
                controller: searchController),
          ],
        ),
      ),
    );
  }
}
