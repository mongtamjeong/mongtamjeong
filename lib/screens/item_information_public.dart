import 'package:flutter/material.dart';
import 'wishList.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'institutionMap.dart';


String timeAgoFromNow(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal();
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 1) return '방금 전';
  if (difference.inMinutes < 60) return '${difference.inMinutes}분 전';
  if (difference.inHours < 24) return '${difference.inHours}시간 전';
  if (difference.inDays < 7) return '${difference.inDays}일 전';
  return '${dateTime.year}.${dateTime.month}.${dateTime.day}';
}



class ItemInformationPublic extends StatefulWidget {
  final Map<String, dynamic> post;
  const ItemInformationPublic({Key? key, required this.post}) : super(key: key);
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
                  Text(
                    widget.post['name'] ?? '제목 없음',
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 19,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),
                  Text(
                    '${widget.post['kind'] ?? '분류없음'}   ${timeAgoFromNow(widget.post['regDate'] ?? DateTime.now().toIso8601String())}',
                    style: const TextStyle(
                      color: Color(0xFFAEAEAE),
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
                          children:  [
                            Text(
                              widget.post['company'] ?? '공공기관',
                              style: const TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 16,
                                fontFamily: 'Pretendard Variable',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.post['place'] ?? '-',
                              style: const TextStyle(
                                color: Color(0xFFAEAEAE),
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
                  Text(
                    widget.post['detail'] ?? '',
                    style: const TextStyle(
                      color: Color(0xFF212121),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InstitutionMap(
                          latitude: 37.4504, // 기관 위도 (예: 인하대학교)
                          longitude: 126.6535, // 기관 경도
                          name: '인하대학교', // 기관 이름
                        ),
                      ),
                    );
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
