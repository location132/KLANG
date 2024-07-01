import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

// 로그인 로직 변경: 반환 타입을 Future<Map<String, dynamic>?>로 변경
Future<bool> loginToServer(String joinemail, String joinpassword) async {
  Dio dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  Map<String, String> data = {
    'email': joinemail,
    'password': joinpassword,
    'platform': 'FLUTTER'
  };
  String serverUrl = '${dotenv.env['API_URL']}/account/login';

  try {
    Response response = await dio.post(serverUrl, data: data);
    if (response.statusCode == 200) {
      // 토큰 정보 추출
      var responseData = response.data;

      String accessToken = responseData['result']['accessToken'];
      String refreshToken = responseData['result']['refreshToken'];
      // 토큰 저장
      await storage.delete(key: 'accessToken');
      await storage.delete(key: 'refreshToken');
      await storage.write(key: 'accessToken', value: accessToken);
      await storage.write(key: 'refreshToken', value: refreshToken);
      return true;
    } else {
      return false; // 로그인 실패 표시
    }
  } catch (e) {
    return false; // 요청 실패 시
  }
}

// sns로 로그인
Future<bool> SNSLoginToServer(String accessToken, String type) async {
  Dio dio = Dio();
  String url = '${dotenv.env['API_URL']}/account/oauth2/app/login';
  Map<String, dynamic> naverLogin = {
    'platform': 'FLUTTER',
    'type': type,
    'accessToken': accessToken,
  };
  try {
    var response = await dio.post(url, queryParameters: naverLogin);

    if (response.statusCode == 200) {
      // 요청 성공 처리 => 토큰 받아오기
      String? accessToken = response.headers.value('authorization');
      String? refreshToken = response.headers.value('refresh_Token');
      //  토큰 스토리지에 저장하기
      await storage.delete(key: 'accessToken');
      await storage.write(key: 'accessToken', value: accessToken);

      await storage.delete(key: 'refreshToken');
      await storage.write(key: 'refreshToken', value: refreshToken);

      return true;
    } else {
      // 오류 처리
      print('Error: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    if (e is DioError) {
      // DioError 처리
      print('DioError: ${e.response?.data}');
    } else {
      // 그 외 에러 처리
      print('Unknown error: $e');
    }
    return false;
  }
}

// 리프레쉬 토큰
Future<bool> sendrefreshToken() async {
  Dio dio = Dio();
  String url = '${dotenv.env['API_URL']}/account/issue/token';
  Map<String, dynamic> data = {"platform": 'FLUTTER'};
  String? rToken = await storage.read(key: 'refreshToken');

  try {
    if (rToken != null) {
      var response = await dio.post(
        url,
        options: Options(
          headers: {"refresh_Token": await storage.read(key: 'refreshToken')},
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        String newaccessToken = response.data['accessToken'];
        await storage.delete(key: 'accessToken');
        await storage.write(key: 'accessToken', value: newaccessToken);
        return true;
      } else {
        return false;
      }
    }
    return false;
  } catch (e) {
    if (e is DioError) {
      print('DioError왜 뜨는데 진짜: ${e.response?.data}');
    } else {
      print('Unknown error: $e');
    }
    return false;
  }
}

// 자동 로그인 bool타입으로 변경하기
Future<bool> checkAndSetLoginStatus() async {
  bool success = await sendrefreshToken();
  if (success) {
    return true;
  } else {
    return false;
  }
}

// 회원가입 이메일 중복 로직
Future<bool> checkEmailAvailability(String email) async {
  Dio dio = Dio(BaseOptions(
    validateStatus: (status) {
      return status != null;
    },
  ));
  String url = '${dotenv.env['API_URL']}/account/email';

  Map<String, dynamic> clangEmail = {
    "email": email,
  };

  try {
    var response = await dio.post(url, data: clangEmail);
    if (response.statusCode == 200)
      return true;
    else {
      print('이메일 중복확인 실패');
      return false;
    }
  } catch (e) {
    print('이거 : $e');
    return false;
  }
}

// 회원가입 전화번호 중복 로직
Future<Map<String, dynamic>> checkPhoneNumberAvailability(String phone) async {
  Dio dio = Dio(BaseOptions(
    validateStatus: (status) {
      return status != null;
    },
  ));
  String endpoint = '${dotenv.env['API_URL']}/account/check/phone';

  Map<String, dynamic> data = {
    "phone": phone,
  };

  try {
    var response = await dio.post(endpoint, data: data);
    if (response.statusCode == 200) {
      return {"success": true, "message": "사용 가능"}; // 사용가능 전화번호
    } else {
      String duplication = response.data;
      return {"success": false, "message": duplication};
    }
  } catch (e) {
    print(e);
    return {"success": false, "message": "알 수 없는 오류가 발생했어요.."};
  }
}

// 회원가입 로직
Future<bool> sendDataToServer(
  String email,
  String password,
  String phoneNumber,
  String passwordCheck,
) async {
  Dio dio = Dio();

  Map<String, dynamic> data = {
    'email': email,
    'password': password,
    'passwordCheck': passwordCheck,
    'phone': phoneNumber,
  };

  String serverUrl = '${dotenv.env['API_URL']}/account/join';
  try {
    Response response = await dio.post(
      serverUrl,
      data: data,
    );

    if (response.statusCode == 200) {
      print('회원가입 성공');
      return true;
    } else {
      print('회원가입 실패');
      return false;
    }
  } catch (e) {
    if (e is DioError) {
      // DioError 처리
      print('DioError: ${e.response?.data}');
    } else {
      // 그 외 에러 처리
      print('Unknown error: $e');
    }
    return false;
  }
}

// 로그아웃 버튼 (이메일) + 서버 입장 보고 개발 시작
Future<bool> logout({int retry = 0}) async {
  Dio dio = Dio();
  String url = '${dotenv.env['API_URL']}/account/logout';
  try {
    var response = await dio.delete(
      url,
      options: Options(headers: {
        'Authorization': await storage.read(key: 'accessToken'),
        'refresh_token': await storage.read(key: 'refreshToken')
      }),
    );
    if (response.statusCode == 200) {
      print('로그아웃 성공');
      await storage.delete(key: 'accessToken');
      await storage.delete(key: 'refreshToken');
      return true;
    } else {
      return false;
    }
  } catch (e) {
    if (retry < 1) {
      bool result = await sendrefreshToken();
      if (result) {
        return logout(retry: retry + 1);
      } else {
        return false;
      }
    } else {
      print('로그아웃 에러 $e');
      return false;
    }
  }
}
