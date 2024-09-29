import 'package:form_field_validator/form_field_validator.dart';

import '../consts/imports.dart';

class TextFormFieldsWidgets {
  static Widget emailTextField({
    required String text,
    required String hintText,
    required TextEditingController controller,
    String? errorText,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12,
              fontFamily: XFonts.poppinsMedium,
              color: Colors.grey.shade700)),
      5.heightBox,
      TextFormField(
        textCapitalization: TextCapitalization.words,
        controller: controller,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: XFonts.poppinsMedium,
        ),
        decoration: InputDecoration(
          counterText: '',
          focusedBorder: textFieldBorder(),
          hintStyle: const TextStyle(
            fontSize: 14,
            fontFamily: XFonts.poppinsMedium,
          ),
          hintText: hintText,
          contentPadding: const EdgeInsets.all(16),
          border: textFieldBorder(),
        ),
        keyboardType: TextInputType.text,
        validator: RequiredValidator(errorText: errorText ?? "Required").call,
      ),
    ]);
  }

  static Widget searchTextField({
    required String hintText,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      controller: controller,
      style: const TextStyle(
        fontSize: 14,
        fontFamily: XFonts.poppinsMedium,
      ),
      decoration: InputDecoration(
        prefixIcon: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: Colors.grey.shade500,
            size: 22,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: onTap,
          icon: Icon(
            Icons.filter,
            color: Colors.grey.shade500,
            size: 22,
          ),
        ),
        counterText: '',
        focusedBorder: textFieldBorder(),
        hintStyle: const TextStyle(
          fontSize: 14,
          fontFamily: XFonts.poppinsMedium,
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.all(16),
        border: textFieldBorder(),
      ),
      keyboardType: TextInputType.text,
    );
  }

  static Widget passwordTextField(
      {required String text,
      required String hintText,
      required TextEditingController controller,
      String? errorText,
      required RxBool isShowPass,
      required VoidCallback suffixOnTap}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12,
              fontFamily: XFonts.poppinsMedium,
              color: Colors.grey.shade700)),
      5.heightBox,
      Obx(() => TextFormField(
            controller: controller,
            obscureText: isShowPass.value,
            style:
                const TextStyle(fontSize: 14, fontFamily: XFonts.poppinsMedium),
            decoration: InputDecoration(
              counterText: '',
              focusedBorder: textFieldBorder(),
              hintStyle: const TextStyle(
                fontSize: 14,
                fontFamily: XFonts.poppinsMedium,
              ),
              hintText: hintText,
              contentPadding: const EdgeInsets.all(16),
              border: textFieldBorder(),
              suffixIcon: GestureDetector(
                  onTap: suffixOnTap,
                  child: Icon(
                    isShowPass.value ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                  )),
            ),
            onChanged: (text) {
              controller.text = text.toLowerCase();
            },
            validator: XValidator.validatePassword.call,
          )),
    ]);
  }

  static InputBorder textFieldBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade600));
  }
}
