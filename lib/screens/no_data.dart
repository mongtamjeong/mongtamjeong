import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'wishList.dart';
import 'find_found3.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';


class NoData extends StatefulWidget {
  @override
  State<NoData> createState() => _NoDataState();
}

class _NoDataState extends State<NoData> {
  String? placeText; // 분실물 추천 장소 텍스트 변수


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '조건으로 찾기',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Wishlist()),
            );
          }, icon: Icon(Icons.favorite,color: Color(0xFFAEAEAE))),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications,color: Color(0xFFAEAEAE))),
        ],
      ),
      body: Stack(
        children: [
          // 스크롤 가능한 전체 콘텐츠
          SingleChildScrollView( // 버튼 가릴 공간
            child: Container(
              width: double.infinity,
              color: const Color(0xFFF8FFFF),
              child: Column(
                children: [
                  Container(
                    width: 412,
                    height: 6,
                    decoration: const BoxDecoration(color: Color(0xFFDFDFDF)),
                  ),
                  const SizedBox(height: 100),

                  // 캐릭터
                  SvgPicture.asset(
                    'assets/images/grandpa_sad.svg',
                    width: 207,
                    height: 284,
                  ),
                  const SizedBox(height: 16),

                  // 텍스트
                  const Text(
                    '찾으려는 금도끼는 없는 모양이군...\n대신 이건 어떤가?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Pretendard Variable',
                    ),
                  ),
                  const SizedBox(height: 23),

                  // 회색 버튼
                  Container(
                    width: 214,
                    height: 51,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FindFound3()), // 이동할 페이지 넣기
                          );
                        },
                        child: const Text(
                          '찾아요 글쓰기',
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 121),

                  const Divider(
                    height: 1,
                    color: Color(0xFFDDDDDD),
                    thickness: 1,
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    '여기에 있을 확률이 있어 보이는군',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Pretendard Variable',
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 지도 자리 -> 텍스트로 수정
                  Text(
                    placeText ?? '추천 장소를 불러오는 중...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Pretendard Variable',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 화면 아래 떠 있는 검정색 버튼
          Positioned(
            bottom: 37,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '알림 받기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Pretendard Variable',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
