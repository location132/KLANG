import 'package:flutter/material.dart';
import 'package:team_between_leaf/core_services/token_required_dio.dart';
import 'package:team_between_leaf/core_services/SharedPreferences.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  final PreferencesNotification prefsNotif = PreferencesNotification();

  bool ispromoNotifs = false; // 광고성 알림 수신
  bool isorderNotifs = false; // 주문/배송 알림
  bool issellerNotifs = false; // 팔로우한 판매자 알림
  bool iswishlistNotifs = false; // 위시리스트 알림
// ----------------------------------------------------//

  @override
  void initState() {
    super.initState();
    _loadNotificationSettings();
  }

  Future<void> _loadNotificationSettings() async {
    ispromoNotifs = await prefsNotif.getNotificationPromo() ?? false;
    isorderNotifs = await prefsNotif.getNotificationOrder() ?? false;
    issellerNotifs = await prefsNotif.getNotificationSeller() ?? false;
    iswishlistNotifs = await prefsNotif.getNotificationWish() ?? false;
    setState(() {});
  }

  String WISHLIST = 'WISHLIST'; // 서버에서 필요한 위시리스트 알림
  String FOLLOWED_SELLER = 'FOLLOWED_SELLER'; // 서버에서 필요한 팔로우 알림
  String ORDER_DELIVERY = 'ORDER_DELIVERY'; //서버에서 필요한 주문 배송 알림
  String MARKETING = 'MARKETING'; // 서버에서 필요한 광고성 알림

  void _updateAndSaveSetting(bool value, String settingType) {
    switch (settingType) {
      case 'MARKETING':
        ispromoNotifs = value;
        prefsNotif.saveNotificationPromo(value);
        sendNotificationSettings(MARKETING, value);

        break;
      case 'ORDER_DELIVERY':
        isorderNotifs = value;
        prefsNotif.saveNotificationOrder(value);
        sendNotificationSettings(ORDER_DELIVERY, value);

        break;
      case 'FOLLOWED_SELLER':
        issellerNotifs = value;
        prefsNotif.saveNotificationSeller(value);
        sendNotificationSettings(FOLLOWED_SELLER, value);

        break;
      case 'WISHLIST':
        iswishlistNotifs = value;
        prefsNotif.saveNotificationWish(value);
        sendNotificationSettings(WISHLIST, value);

        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림설정'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20), // 미디어 쿼리로 수정해야해요
        child: Column(
          children: [
            const Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('광고성 알림 수신'),
                const Spacer(),
                Switch(
                  value: ispromoNotifs,
                  onChanged: ((value) {
                    setState(() {
                      ispromoNotifs = value;
                      _updateAndSaveSetting(value, 'MARKETING');
                    });
                  }),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              '광고성 알림 수신을 동의한 경우, 카카오톡이나 이메일 등으로광고성 알림이 발성됩니다.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('주문 / 배송 알림'),
                const Spacer(),
                Switch(
                  value: isorderNotifs,
                  onChanged: ((value) {
                    setState(() {
                      isorderNotifs = value;
                      _updateAndSaveSetting(value, 'ORDER_DELIVERY');
                    });
                  }),
                ),
              ],
            ),
            const Text(
              '사용자가 주문한 상훔의 배송정보(주문완료, 주문확인, 배송시작, 배송완료) 업데이트 시 알림이 발송됩니다.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('팔로우한 판매자 알림'),
                const Spacer(),
                Switch(
                  value: issellerNotifs,
                  onChanged: ((value) {
                    setState(() {
                      issellerNotifs = value;
                      _updateAndSaveSetting(value, 'FOLLOWED_SELLER');
                    });
                  }),
                ),
              ],
            ),
            const Text(
              '사용자가 팔로우한 스토어에서 보내는 알림이 있을 경우, 또는 선물한 쿠폰이 있는 경우 알림이 발송됩니다.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const Divider(),
            Row(
              children: [
                const Text('위시리스트 알림'),
                const Spacer(),
                Switch(
                  value: iswishlistNotifs,
                  onChanged: ((value) {
                    setState(() {
                      iswishlistNotifs = value;
                      _updateAndSaveSetting(value, 'WISHLIST');
                    });
                  }),
                ),
              ],
            ),
            const Text(
              '위시리스트에 담긴 상품의 가격변동, 판매자가 제공하는 쿠폰 발행, 품절된 상품 재입고 등의 변경사항이 있을 시 알림이 발송됩니다.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
