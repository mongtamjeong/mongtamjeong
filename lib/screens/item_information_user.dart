import 'package:flutter/material.dart';
import 'wishList.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/chat_service.dart';
import 'chat2.dart'; // 채팅방 화면
import 'package:firebase_auth/firebase_auth.dart';


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



class ItemInformationUser extends StatefulWidget {
  final Map<String, dynamic> post;
  const ItemInformationUser({Key? key, required this.post}) : super(key: key);
  @override
  State<ItemInformationUser> createState() => _ItemInformationUserState();
}

class _ItemInformationUserState extends State<ItemInformationUser> {
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
                          child: (() {
                            final profileImage = widget.post['profileImage'] as String? ?? '';
                            if (profileImage.isNotEmpty) {
                              return ClipOval(
                                child: Image.network(
                                  profileImage,
                                  fit: BoxFit.cover,
                                  width: 54,
                                  height: 54,
                                  errorBuilder: (context, error, stackTrace) {
                                    return SvgPicture.asset(
                                      'assets/images/profileImage_noCamera.svg',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              );
                            } else {
                              return SvgPicture.asset(
                                'assets/images/profileImage_noCamera.svg',
                                fit: BoxFit.cover,
                              );
                            }
                          })(),
                        ),


                        const SizedBox(width: 19),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post['nickname'] ?? '이름없음',
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
                                color:  Color(0xFFAEAEAE),
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
                    widget.post['description'] ?? '-',
                    style: const TextStyle(
                      color:  Color(0xFF212121),
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
                  children: [
                    Icon(Icons.favorite, color: Colors.grey),
                    SizedBox(width: 26.23),
                    Text(
                      widget.post['reward'] ?? '현상금 없음',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final currentUser = FirebaseAuth.instance.currentUser;
                      final targetUid = widget.post['registerarId'];

                      if (currentUser == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("로그인이 필요합니다.")),
                        );
                        return;
                      }

                      if (currentUser.uid == targetUid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("본인과 채팅할 수 없습니다.")),
                        );
                        return;
                      }

                      final chatService = ChatService();
                      final chatroomId = await chatService.createOrGetChatRoom(targetUid);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Chat2(chatroomId: chatroomId),
                        ),
                      );
                    } catch (e) {
                      print("❌ 채팅방 생성 오류: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("채팅방을 생성하지 못했습니다.")),
                      );
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB5FFFF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    '채팅하기',
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
