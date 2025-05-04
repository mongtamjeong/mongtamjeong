import 'package:flutter/material.dart';
import 'wishList.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ItemInformationPublic extends StatefulWidget {
  @override
  State<ItemInformationPublic> createState() => _ItemInformationPublicState();
}

class _ItemInformationPublicState extends State<ItemInformationPublic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Wishlist()),
            );
          }, icon: Icon(Icons.favorite, color: Colors.white,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications, color: Colors.white,)),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 285,
            width: double.infinity,
            color: Colors.grey[300],
          ),

          // 본문 내용
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 20),

                  // 제목
                  const Text(
                    '저 진짜 너무 힘드네요.. 힘드네요..',
                    style: TextStyle(
                      color: const Color(0xFF212121),
                      fontSize: 19,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),
                  const Text(
                    '분류/아찌고/똥    5분 전',
                    style: TextStyle(
                      color: const Color(0xFFAEAEAE),
                      fontSize: 13,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 14),
                  const Divider(color: Color(0xFFDDDDDD), thickness: 1),

                  // 프로필 정보
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 54,
                          width: 54,
                          child: SvgPicture.asset(
                            'assets/images/profileImage_noCamera.svg', // 너의 실제 SVG 경로로 바꿔줘
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 19),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '기관이름',
                              style: TextStyle(
                                color: const Color(0xFF212121),
                                fontSize: 16,
                                fontFamily: 'Pretendard Variable',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '위치',
                              style: TextStyle(
                                color: const Color(0xFFAEAEAE),
                                fontSize: 13,
                                fontFamily: 'Pretendard Variable',
                                fontWeight: FontWeight.w400,
                              ),
                            )                          ],
                        )
                      ],
                    ),
                  ),

                  const Divider(color: Color(0xFFDDDDDD), thickness: 1),

                  const SizedBox(height: 20),

                  // 본문
                  const Text(
                    '본문 내용\n\n가나다라마바사 아자차카타파하\n디자인 차력쇼를 보여드리겠습니다\n\n안녕하세요 감사합니다 영어로 땡큐 중국어로 쎼쎼\n\n반택만 합니다\n직거래 안합니다\n\n하자 오염 없습니다\n\n커어어억.... 드렁슨',
                    style: TextStyle(
                      color: const Color(0xFF212121),
                      fontSize: 16,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30),


                ],
              ),
            ),
          ),
        ],
      ),

      // 하단 고정 영역: bottomNavigationBar로 이동
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFDDDDDD), // 연회색 구분선
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Row(
                  children: const [
                    Icon(Icons.favorite, color: Colors.grey),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // 지도로 이동 등
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB5FFFF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    '지도보기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
