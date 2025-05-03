import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'find_found1.dart';
import 'myPage.dart';
import 'home.dart';

class Chat1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('채팅', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFDDDDDD),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Row(
              children: [
                _buildTabButton("전체", true),
                const SizedBox(width: 9.77),
                _buildTabButton("찾아요", false),
                const SizedBox(width: 9.77),
                _buildTabButton("찾았어요", false),
              ],
            ),
          ),
          const Divider(thickness: 1, color: Color(0xFFDDDDDD)),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => const Divider(thickness: 1, color: Color(0xFFDDDDDD)),
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 90,
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/images/chat_grandpa.svg',
                      width: 48,
                      height: 48,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('닉네임', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 7),
                        const Text('2분 전', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    subtitle: const Text('마지막 대화 내용'),
                    onTap: () {
                      // TODO: 채팅방 이동
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFB5FFFF),
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

Widget _buildTabButton(String label, bool isSelected) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: isSelected ? Color(0xFFB5FFFF) : Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: isSelected
          ? null
          : Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: isSelected ? Colors.white : Colors.grey,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

