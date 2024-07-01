import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  late List<Map<String, dynamic>> _wishList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {},
        ),
        title: const Text("위시리스트"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.calendar),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _dropDownBtn(),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _wishList.length,
                itemBuilder: (context, index) {
                  return _buildWishItem(_wishList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDownBtn() {
    const String dropDownValue = "최신순";

    List<String> dropDownList = [
      "최신순",
      "인기순",
      "찜 많은순",
      "리뷰 많은순",
      "판매수 많은순",
      "할인율 높은순",
      "낮은 가격순",
      "높은 가격순"
    ];

    return Row(
      children: [
        const SizedBox(width: 20.0),
        DropdownButton(
          value: dropDownValue,
          items: dropDownList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {},
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: const Text("편집"), // 추후 여기에 위시리스트 삭제 api 연결 필요
        ),
      ],
    );
  }

  Widget _buildWishItem(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(item['image']),
          const SizedBox(height: 8.0),
          Text(
            item['title'],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            '${item['price']}원',
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            '${item['discountRate']}% 할인',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}


/*
240303
위시리스트 삭제 api 연결 필요, 삭제 메소드 생성 및 추가 필요.
위시리스트 provider 이용한 상태관리 연결 했으나, 아직 값을 불러오지 못하고 있음. 해당부분 수정 필요.
*/
