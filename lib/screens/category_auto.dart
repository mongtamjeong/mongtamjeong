import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home.dart';
import 'find_found1.dart';
import 'chat1.dart';
import 'myPage.dart';
import 'wishList.dart';
import 'dataList_image.dart';

class CategoryAuto extends StatefulWidget {
  const CategoryAuto({super.key});

  @override
  State<CategoryAuto> createState() => _CategoryAutoState();
}

class _CategoryAutoState extends State<CategoryAuto> {
  String category = '카테고리 결과 이 변수에 넣으면 될 듯';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '이미지로 찾기',
          style: TextStyle(
            color: const Color(0xFF212121),
            fontSize: 24,
            fontFamily: 'Pretendard Variable',
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Wishlist()),
            );}, icon: Icon(Icons.favorite,color: Color(0xFFAEAEAE))),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications,color: Color(0xFFAEAEAE))),
        ],
      ),

      body: Stack(
        children: [
          Container(
            color: const Color(0xFFF8FFFF), // 전체 배경색
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '내가 어디 한 번 분류해보겠소',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Pretendard Variable',
                  ),
                ),
                SizedBox(height: 22,),
                Container(
                  width: 381,
                  height: 260,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(category)
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 104,
                  height: 37,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DatalistImage()),
                        );
                      },
                      child: const Text(
                        '확인',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 원하는 위치에 이미지나 아이콘 추가
          Positioned(
            left: 287,
            top: 438,
            child: SizedBox(
              width: 109,
              height: 149,
              child: SvgPicture.asset(
                'assets/images/grandpa2.svg',
                width: 207,
                height: 284,
              ),
            ),
          ),
        ],
      ),


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // 선택된 탭 인덱스 (0 = 홈)
        type: BottomNavigationBarType.fixed, // 4개 이상일 땐 fixed 필요
        selectedItemColor: Color(0xFFB5FFFF), // 선택된 아이템 색상
        unselectedItemColor: Colors.grey, // 비선택 아이템 색상
        onTap: (index) {
          if(index == 0){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          }
          else if (index == 1){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FindFound1()),
            );
          }
          else if (index == 2){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Chat1()),
            );
          }else if (index == 3){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Mypage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: '게시판',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지',
          ),
        ],
      ),
    );
  }
  Widget _buildDropdown(
      String label,
      List<String> options,
      String? selectedValue,
      Function(String?) onChanged,
      ) {
    return SizedBox(
      height: 36,
      width: 241,
      child: DropdownButtonFormField<String>(
        isDense: true,
        value: selectedValue,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          hintText: label,
          hintStyle: TextStyle(
            fontSize: 12,
            fontFamily: 'Pretendard Variable',
            fontWeight: FontWeight.w500,
            color: Color(0xFFB0B0B0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Color(0xFFB0B0B0)),
          ),
        ),
        items: options.map((option) {
          return DropdownMenuItem(
            value: option,
            child: Text(
              option,
              style: const TextStyle(fontSize: 12),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        icon: const Icon(Icons.arrow_drop_down, size: 18),
        style: const TextStyle(fontSize: 12, color: Colors.black),
        dropdownColor: Colors.white,
      ),
    );
  }


}
