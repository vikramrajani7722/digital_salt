import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../consts/imports.dart';

class DioWebService {
  static const baseUrl = XStrings.webserviceUrl;
  static final dio = Dio();
  static Future<RxList<Product>> getAllProducts() async {
    RxList<Product> list = <Product>[].obs;
    try {
      final rs = await dio.get(
        baseUrl,
        options: Options(responseType: ResponseType.json),
      );
      if (rs.statusCode == 200) {
        CoursesModel data = CoursesModel.fromJson(rs.data);
        list.value = data.products ?? [];
        if (kDebugMode) {
          print("Length : ${list.length}");
        }
        return list;
      } else {
        toast(msg: 'Something went wrong!');
      }
    } catch (ex) {
      toast(msg: 'Check Internet Connection!');
      if (kDebugMode) {
        print('Error: $ex');
      }
    }
    return list;
  }

  static Future<RxList<CategoryModel>> getAllCategories() async {
    RxList<CategoryModel> list = <CategoryModel>[].obs;
    try {
      final rs = await dio.get(
        "$baseUrl/categories",
        options: Options(responseType: ResponseType.json),
      );
      if (rs.statusCode == 200) {
        list.value = List<CategoryModel>.from(rs.data.map((x) => CategoryModel.fromJson(x)));
        if (kDebugMode) {
          print("Length : ${list.length}");
        }
        return list;
      } else {
        toast(msg: 'Something went wrong!');
      }
    } catch (ex) {
      toast(msg: 'Check Internet Connection!');
      if (kDebugMode) {
        print('Error: $ex');
      }
    }
    return list;
  }
}
