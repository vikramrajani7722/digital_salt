import '../consts/imports.dart';

void showLoader(SimpleFontelicoProgressDialog? _dialog) {
  _dialog?.show(
      message: 'Loading...',
      type: SimpleFontelicoProgressDialogType.multiHurricane,
      hideText: true,
      backgroundColor: Colors.white,
      indicatorColor: XColors.themeColor);
}
