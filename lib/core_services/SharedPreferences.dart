import 'package:shared_preferences/shared_preferences.dart';

// 알림설정 부분
class PreferencesNotification {
  static const _notificationpromo = 'notificationPromo';
  static const _notificationorder = 'notificationOrder';
  static const _notificationseller = 'notificationSeller';
  static const _notificationWish = 'notificationWish';
  // 알림 상태 저장
  Future<void> saveNotificationPromo(bool value) async {
    final clangNotificationPromo = await SharedPreferences.getInstance();
    await clangNotificationPromo.setBool(_notificationpromo, value);
  }

  Future<void> saveNotificationOrder(bool value) async {
    final clangNotificationOrder = await SharedPreferences.getInstance();
    await clangNotificationOrder.setBool(_notificationorder, value);
  }

  Future<void> saveNotificationSeller(bool value) async {
    final clangNotificationSeller = await SharedPreferences.getInstance();
    await clangNotificationSeller.setBool(_notificationseller, value);
  }

  Future<void> saveNotificationWish(bool value) async {
    final clangNotificationWish = await SharedPreferences.getInstance();
    await clangNotificationWish.setBool(_notificationWish, value);
  }

// 알림 상태 가져오기
  Future<bool?> getNotificationPromo() async {
    final clangNotificationPromo = await SharedPreferences.getInstance();
    return clangNotificationPromo.getBool(_notificationpromo);
  }

  Future<bool?> getNotificationOrder() async {
    final clangNotificationOrder = await SharedPreferences.getInstance();
    return clangNotificationOrder.getBool(_notificationorder);
  }

  Future<bool?> getNotificationSeller() async {
    final clangNotificationSeller = await SharedPreferences.getInstance();
    return clangNotificationSeller.getBool(_notificationseller);
  }

  Future<bool?> getNotificationWish() async {
    final clangNotificationWish = await SharedPreferences.getInstance();
    return clangNotificationWish.getBool(_notificationWish);
  }
}

class PreferencesSearchHistort {
  static const _historyKey = 'hisKey';

// 검색기록 저장
  Future<void> setSearchHistory(String newSearchSave) async {
    final loadHistory = await SharedPreferences.getInstance();
    List<String> clangHistory = loadHistory.getStringList(_historyKey) ?? [];
    if (clangHistory.length >= 10) {
      clangHistory.removeAt(0);
    }
    clangHistory.add(newSearchSave);
    await loadHistory.setStringList(_historyKey, clangHistory);
  }

//검색기록 불러오기
  Future<List<String>?> getSearchHistory() async {
    final loadHistory = await SharedPreferences.getInstance();
    return loadHistory.getStringList(_historyKey);
  }

// 검색기록 삭제
  Future<void> removeSearchHistory(String searchItem) async {
    final loadHistory = await SharedPreferences.getInstance();
    List<String> clangHistory = loadHistory.getStringList(_historyKey) ?? [];
    clangHistory.removeWhere((item) => item == searchItem);
    await loadHistory.setStringList(_historyKey, clangHistory);
  }

  // 검색기록 모두 삭제
  Future<void> removeAllHistory() async {
    final loadHistory = await SharedPreferences.getInstance();
    List<String> clangHistory = loadHistory.getStringList(_historyKey) ?? [];
    clangHistory.clear();
    await loadHistory.setStringList(_historyKey, clangHistory);
  }
}
