import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'chat1.dart';
import 'find_found1.dart';
import 'home.dart';
import 'terms.dart';

class Mypage extends StatefulWidget {
  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('마이페이지',
          style: TextStyle(fontWeight: FontWeight.bold),),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFDDDDDD),
          ),
        ),
      ),


      body: Container(
        color: const Color(0xFFF8FFFF),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 40),
            SvgPicture.asset(
              'assets/images/profileImage.svg',
              width: 97,
              height: 97,
            ),
            const SizedBox(height: 23),
            const Text(
              '햄수 님',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                fontFamily: 'Pretendard Variable',
              ),
            ),

            const SizedBox(height: 30),

            // 하늘색 구분선
            Container(
              height: 6,
              color: Color(0xFFE0FFFF), // 하늘색 구분선
            ),

            const SizedBox(height: 30),

            // 흰색 박스 안에 메뉴 리스트
            Center(
              child: Container(
                width: 381,
                height: 260,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xFFECECEC),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => _showVersionInfo(context),
                      child: const Text(
                        '버전정보',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Terms()),
                        );
                      },

                      child: const Text(
                        '이용약관',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        // 수정필요
                      },
                      child: const Text(
                        '문의하기',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('로그아웃'),
                            content: Text('정말 로그아웃 하시겠습니까?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('취소'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // 나중에 FirebaseAuth.instance.signOut() 또는 API 호출로 교체
                                  Navigator.pop(context); // 팝업 닫기
                                  Navigator.popUntil(context, (route) => route.isFirst); // 로그인 화면으로
                                },
                                child: Text('확인'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text(
                        '로그아웃',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('서비스 탈퇴'),
                            content: Text('계정을 완전히 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('취소'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // 나중에 사용자 삭제 API나 Firebase delete() 추가 예정
                                  Navigator.pop(context); // 팝업 닫기
                                  Navigator.popUntil(context, (route) => route.isFirst); // 로그인 화면으로
                                },
                                child: Text('탈퇴하기', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text(
                        '서비스 탈퇴',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),



      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // 선택된 탭 인덱스
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

//버전정보
void _showVersionInfo(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('버전정보'),
      content: const Text(
        '앱 이름: 몽탐정 – 분실물 찾기\n'
            '버전: 1.0.0\n'
            '빌드: 2025.05.09\n'
            '개발팀: Team 몽탐정\n'
            '문의: lostapp@teammong.kr\n\n'
            '© 2025 Team 몽탐정. All rights reserved.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('닫기'),
        ),
      ],
    ),
  );
}
