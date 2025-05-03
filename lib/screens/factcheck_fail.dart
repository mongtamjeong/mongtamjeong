import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'wishList.dart';
import 'chat1.dart';
import 'find_found1.dart';
import 'myPage.dart';
import 'home.dart';

class FactcheckFail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('이미지로 찾기',
          style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Wishlist()),
            );}, icon: Icon(Icons.favorite)),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
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
                  textAlign: TextAlign.center,
                  '아쉽게도 다른 사람의 금도끼인듯하네...',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Pretendard Variable',
                  ),
                ),
                SizedBox(height: 22),
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
                      _buildGrayRoundedButton(
                        context,
                        text: '습득자에게 채팅하기',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Chat1()), // TODO: 실제 채팅방으로 수정
                          );
                        },
                      ),
                      const SizedBox(height: 12), // 버튼 간 간격
                      _buildGrayRoundedButton(
                        context,
                        text: '다른 금도끼 찾아보기',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FindFound1()),
                          );
                        },
                      ),
                    ],
                  ),

                ),
              ],
            ),
          ),

          // 원하는 위치에 이미지나 아이콘 추가
          Positioned(
            left: 287,
            top: 438,
            child: Container(
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
}

Widget _buildGrayRoundedButton(BuildContext context,
    {required String text, required VoidCallback onPressed}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 24),
    width: 181,
    height: 37,
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(30),
    ),
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
