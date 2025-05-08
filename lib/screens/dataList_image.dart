import 'package:flutter/material.dart';
import 'wishList.dart';

class DatalistImage extends StatefulWidget {
  @override
  State<DatalistImage> createState() => _DatalistImageState();
}

class _DatalistImageState extends State<DatalistImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '이미지로 찾기',
          style: TextStyle(
            color: const Color(0xFF212121),
            fontSize: 24,
            fontFamily: 'Pretendard Variable',
            fontWeight: FontWeight.w600,
          ),        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Wishlist()),
              );
            },
            icon: const Icon(Icons.favorite),color: Color(0xFFAEAEAE),),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications,color: Color(0xFFAEAEAE))),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            height: 6,
            thickness: 6,
            color: Color(0xFFDDDDDD),
          ),
        ),
      ),

      // 게시글 리스트
      body: Stack(
        children: [
          Column(
            children: [
              // 필터 버튼 영역
              Container(
                height: 57,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                alignment: Alignment.centerLeft,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildFilterButton(context, '시간', ['1시간 이내', '오늘', '이번 주', '기억 안 남']),
                  ],
                ),
              ),
              PreferredSize(
                preferredSize: Size.fromHeight(1.0),
                child: Divider(
                  height: 6,
                  thickness: 6,
                  color: Color(0xFFDDDDDD),
                ),
              ),
              // 게시글 리스트
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 123,
                                height: 123,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      '어쩌고저쩌고',
                                      style: TextStyle(
                                        color: Color(0xFF212121),
                                        fontSize: 19,
                                        fontFamily: 'Pretendard Variable',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '찾아요/찾았어요',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '어디어디 · 10분 전',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 22,),
                                    Text(
                                      '현상금 ㅇㅇㅇ원',
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFDDDDDD),
                          indent: 16,
                          endIndent: 16,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),

          // 고정된 하단 버튼
          Positioned(
            bottom: 67,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.notifications, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      '어쩌고 알림 받기',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Pretendard Variable',
                        fontWeight: FontWeight.w600,
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

Widget _buildFilterButton(BuildContext context, String label, List<String> options) {
  return GestureDetector(
    onTap: () => _showFilterModal(context, label, options),
    child: Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFFCCCCCC)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFA2A2A2),
              fontSize: 16,
              fontFamily: 'Pretendard Variable',
              fontWeight: FontWeight.w400,
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: Color(0xFF888888), size: 18),
        ],
      ),
    ),
  );
}


void _showFilterModal(BuildContext context, String title, List<String> options) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // 화면 넘는 경우 전체 스크롤 가능
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title 선택',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                ...options.map((option) => ListTile(
                  title: Text(option),
                  onTap: () {
                    Navigator.pop(context);
                    // 선택 처리
                  },
                )),
              ],
            ),
          );
        },
      );
    },
  );
}



