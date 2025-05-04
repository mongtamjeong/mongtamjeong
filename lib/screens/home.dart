import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'wishList.dart';
import 'chat1.dart';
import 'find_found1.dart';
import 'myPage.dart';

class Home extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _handleImagePick(BuildContext context, String value) async {
    XFile? pickedFile;
    if (value == '사진 촬영') {
      pickedFile = await _picker.pickImage(source: ImageSource.camera);
    } else if (value == '갤러리에서 선택') {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      // TODO: 이미지 처리 로직 추가
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('몽탐정 홈',
            style: TextStyle(
              color: const Color(0xFF212121),
              fontSize: 24,
              fontFamily: 'Pretendard Variable',
              fontWeight: FontWeight.w600,
            ),),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Wishlist()),
            );
          }, icon: Icon(Icons.favorite,color: Color(0xFFAEAEAE))),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications,color: Color(0xFFAEAEAE))),
        ],
      ),
      body: Container(
        color: const Color(0xFFF8FFFF),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              '그래그래...\n무엇을 찾으러 왔느냐?',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pretendard Variable',
              ),
            ),
            SizedBox(height: 23),
            SvgPicture.asset(
              'assets/images/grandpa.svg',
              width: 207,
              height: 284,
            ),
            SizedBox(height: 23),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'digital') {
                  // 색상으로 찾기 기능 실행
                } else if (value == 'pet') {
                  // 카테고리로 찾기 기능 실행
                } else if (value == 'clothes') {
                  // 카테고리로 찾기 기능 실행
                } else if (value == 'goods') {
                  // 카테고리로 찾기 기능 실행
                } else if (value == 'etc') {
                  // 카테고리로 찾기 기능 실행
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'digital', child: Text('디지털')),
                const PopupMenuItem(value: 'pet', child: Text('전자기기')),
                const PopupMenuItem(value: 'clothes', child: Text('의류')),
                const PopupMenuItem(value: 'goods', child: Text('잡화')),
                const PopupMenuItem(value: 'etc', child: Text('기타')),

              ],
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                margin: const EdgeInsets.only(bottom: 12),
                width: 214,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '조건으로 찾기',
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                _handleImagePick(context, value);
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: '사진 촬영', child: Text('사진 촬영')),
                const PopupMenuItem(value: '갤러리에서 선택', child: Text('갤러리에서 선택')),
              ],
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                width: 214,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '이미지로 찾기',
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFB5FFFF),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FindFound1()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Chat1()));
          } else if (index == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Mypage()));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: '게시판'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: '채팅'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
        ],
      ),
    );
  }
}
