import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이용약관', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFDDDDDD)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: const Text(
                '''
1. 서비스 소개  
본 앱은 인공지능과 공공데이터를 활용하여 사용자의 분실물 찾기를 지원하는 서비스입니다.

2. 이용자의 책임  
사용자는 사실에 기반한 정보를 입력해야 하며, 허위 신고 시 서비스 이용이 제한될 수 있습니다.

3. 서비스 제공자의 책임  
AI 기반 추천 결과는 100% 정확하지 않을 수 있으며, 앱은 결과에 대한 법적 책임을 지지 않습니다.

4. 개인정보 수집 및 이용  
서비스 이용을 위해 사용자의 사진, 기기 정보, 이메일 등이 수집될 수 있으며, 본 정보는 분실물 매칭 외 목적으로 사용되지 않습니다.

5. 저작권  
앱 내 디자인, 로고, 콘텐츠는 Team 몽탐정의 지식재산으로 보호됩니다.

6. 금지 행위  
타인의 정보를 도용하거나 욕설, 허위 정보 등록 등은 금지됩니다.

7. 서비스 변경 및 중단  
운영자는 사전 공지 없이 일부 기능을 변경하거나 중단할 수 있습니다.

8. 문의처  
문의는 lostapp@teammong.kr 로 보내주시기 바랍니다.
                ''',
                style: TextStyle(fontSize: 15, height: 1.6),
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFDDDDDD)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // 동의 후 이전 화면으로 돌아가기
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB5FFFF),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '동의합니다',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
