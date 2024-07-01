import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:team_between_leaf/core_services/authentication_dio.dart';

const storage = FlutterSecureStorage();

// 사용자 알림 설정 api
Future<bool> sendNotificationSettings(String alertType, bool settingValue,
    {int retry = 0}) async {
  Dio dio = Dio();
  String url = '${dotenv.env['API_URL']}/alert/notify';

  try {
    var response = await dio.put(
      url,
      data: {
        "alertType": alertType,
        "setting": settingValue,
      },
      options: Options(
        headers: {
          "Authorization": await storage.read(key: 'accessToken'),
        },
      ),
    );

    if (response.statusCode == 200) {
      print('성공');
      print(response.data);
      return true;
    } else {
      print('실패');
      return false;
    }
  } catch (e) {
    print('토큰 재발급 실행 중');
    if (retry < 1) {
      bool result = await sendrefreshToken();
      if (result) {
        return await sendNotificationSettings(alertType, settingValue,
            retry: 1);
      } else {
        return false;
      }
    } else {
      print('예기치 않은 오류가 발생했습니다 ㅜ.ㅜ');
      return false;
    }
  }
}

//알림 메세지 보내기

// 알림 메시지 받기

// 위시리스트 추가 api
Future<bool> addToWishList(int userId, int productId, int amount) async {
  Dio dio = Dio();
  String url = '${dotenv.env['API_URL']}/product/wish';
  try {
    var response = await dio.post(
      url,
      data: {'userId': userId, 'productId': productId, 'amount': amount},
    );
    return response.statusCode == 200 && response.data == true;
  } on DioException {
    rethrow;
  }
}

// 위시리스트 조회 api
Future<List<Map<String, dynamic>>> getWishList() async {
  Dio dio = Dio();
  dio.interceptors.add(LogInterceptor()); // LogInterceptor 추가, 콘솔로 내용 확인 가능
  String url = '${dotenv.env['API_URL']}/product/wish';

  try {
    var response = await dio.get(
      url,
      options: Options(
        headers: {"accessToken": await storage.read(key: 'accessToken')},
      ),
    );
    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data;
      List<Map<String, dynamic>> wishList =
          List<Map<String, dynamic>>.from(responseData);
      // 위시리스트 출력
      return wishList;
    } else {
      return [];
    }
  } on DioError catch (e) {
    throw e;
  }
}

// 위시리스트 삭제 api
Future<bool> removeFromWishList(int userId, int productId) async {
  Dio dio = Dio();
  String url = '${dotenv.env['API_URL']}/product/wish';
  try {
    var response = await dio.delete(
      url,
      data: {'userId': userId, 'productId': productId},
    );
    return response.statusCode == 200 && response.data == true;
  } on DioException {
    rethrow;
  }
}
