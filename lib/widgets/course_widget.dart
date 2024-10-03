import '../consts/imports.dart';

Widget courseWidget(Product data, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                    imageUrl: data.thumbnail,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.2),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 3.0, vertical: 3.0),
                  decoration: const BoxDecoration(
                    color: XColors.themeColor,
                  ),
                  child: GetBuilder<CourseController>(builder: (val) {
                    return Text(
                      textAlign: TextAlign.center,
                      "${val.convertDecimalToString(data.discountPercentage)}% OFF",
                      style: const TextStyle(
                        height: 1.1,
                        color: Colors.white,
                        fontSize: 9.0,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }),
                ),
              ],
            ),
            10.widthBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data.title}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontFamily: XFonts.poppinsSemiBold),
                  ),
                  Text(
                    "${data.description}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 11.0,
                        fontFamily: XFonts.poppinsRegular),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${XStrings.rupee} ${data.price} ",
                        style: const TextStyle(
                            color: XColors.themeColor,
                            fontSize: 14.0,
                            fontFamily: XFonts.poppinsSemiBold),
                      ),
                      data.brand != null && data.brand != ""
                          ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              data.brand,
                              style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 10.0,
                                  fontFamily: XFonts.poppinsSemiBold),
                            ),
                          )
                          : Container()
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
