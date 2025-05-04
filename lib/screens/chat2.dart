import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class Chat2 extends StatefulWidget {
  @override
  State<Chat2> createState() => _Chat2State();
}

class _Chat2State extends State<Chat2> {
  File? _selectedImage;

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('떵쿠노',style: TextStyle(
            color: const Color(0xFF212121),
        fontSize: 24,
        fontFamily: 'Pretendard Variable',
        fontWeight: FontWeight.w600,
      ),
    ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: Column(
        children: [
          const Divider(height: 1, thickness: 1, color: Color(0xFFDDDDDD)),

          // 물건 정보 (항상 고정)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 47,
                  height: 47,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE4E4E4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),// 물건 이미지 자리
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('제목', style: TextStyle(
                      color: const Color(0xFF212121),
                      fontSize: 16,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w600,
                    ),),
                    SizedBox(height: 2),
                    Text('7000원', style: TextStyle(
                        color: const Color(0xFF212121),
                  fontSize: 16,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w600,
                ),),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFDDDDDD)),

          // 채팅 영역
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                // 상대방 채팅 (왼쪽)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 38,
                      width: 38,
                      child: SvgPicture.asset(
                        'assets/images/profileImage_noCamera.svg',
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('안녕하세요 \n떵쿠노입니다 \n오늘의 먹방은 만두'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 내 채팅 (오른쪽)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFDDDDDD)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('맛있게 먹겠습니다~'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //  입력창
          Column(
            children: [
              // 이미지 미리보기 (선택된 경우에만)
              if (_selectedImage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _selectedImage!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImage = null; // 이미지 제거
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                ),


              //  채팅 입력창
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.grey),
                      onPressed: _pickImageFromGallery,
                    ),

                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE4E4E4),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: '채팅 보내기',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Pretendard Variable',
                              fontWeight: FontWeight.w600,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),
                    const Icon(Icons.send, color: Colors.grey),
                  ],
                ),
              ),

              const SizedBox(height: 41),
            ],
          ),
        ],
      ),
    );
  }
}
