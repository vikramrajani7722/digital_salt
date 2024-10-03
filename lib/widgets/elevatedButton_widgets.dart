import '../consts/imports.dart';

class ElevatedButtonWidgets {
  static Widget onBoardingElevatedButton(
      {required VoidCallback onTap,
      required Color buttonColor,
      required String text,
      Color? textColor,
      double? elevation}) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: buttonColor,
            shadowColor: buttonColor,
            elevation: elevation ?? 0,
            side: const BorderSide(color: XColors.themeColor)),
        child: Text(text,
            style: TextStyle(
              fontSize: 14,
              color: textColor ?? Colors.white,
              fontFamily: XFonts.poppinsMedium
            )));
  }

  static Widget filterElevatedButton(
      {required VoidCallback onTap,
        required Color buttonColor,
        required String text,
        Color? borderColor,
        Color? textColor}) {
    return  ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        surfaceTintColor: buttonColor,
        elevation: 2,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.all(12),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: borderColor ?? Colors.transparent
        )),
      ),
      onPressed: onTap,
      child:  Text(
        text,
        style: TextStyle(
            color: textColor ?? Colors.white, fontFamily: XFonts.poppinsMedium),
      )
    );
  }

}
