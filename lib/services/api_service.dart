//오픈 api 연동 및 데이터 불러오기
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

Future<List<Map<String, dynamic>>> fetchAllLostItems() async {
  const apiKey = '4a75667368676d6c36387562464d4a';
  const serviceName = 'lostArticleInfo';
  const maxPerPage = 1000;

  List<Map<String, dynamic>> allItems = [];

  // 1. 먼저 1~1 요청해서 전체 개수 알아냄
  final countUrl = Uri.parse(
      'http://openapi.seoul.go.kr:8088/$apiKey/xml/$serviceName/1/1/'
  );
  final countResponse = await http.get(countUrl);

  if (countResponse.statusCode != 200) {
    throw Exception('총 개수 조회 실패: ${countResponse.statusCode}');
  }

  final countDoc = xml.XmlDocument.parse(countResponse.body);
  final totalCountText = countDoc
      .findAllElements('list_total_count')
      .first
      .innerText;
  final totalCount = int.tryParse(totalCountText) ?? 0;

  print('총 데이터 개수: $totalCount');

  // 2. 총 개수를 바탕으로 반복 요청
  for (int start = 274000; start <= totalCount; start += maxPerPage) {
    final end = (start + maxPerPage - 1 > totalCount)
        ? totalCount
        : start + maxPerPage - 1;

    final url = Uri.parse(
        'http://openapi.seoul.go.kr:8088/$apiKey/xml/$serviceName/$start/$end/'
    );

    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('데이터 요청 실패: ${response.statusCode}');
    }

    final doc = xml.XmlDocument.parse(response.body);
    final rows = doc.findAllElements('row');

    for (var element in rows) {
      final status = element.getElement('LOST_STTS')?.innerText ?? '';
      final regYmd = element.getElement('REG_YMD')?.innerText ?? '';

      // 날짜 파싱
      DateTime? regDate;
      try {
        regDate = DateTime.parse(regYmd);
      } catch (_) {
        continue; // 파싱 실패한 건 건너뜀
      }

      // 날짜 조건 범위 설정
      final startDate = DateTime(2023, 5, 6);
      final endDate = DateTime(2025, 5, 6);

      // 조건에 맞지 않으면 제외
      if (status != '보관' || regDate.isBefore(startDate) || regDate.isAfter(endDate)) {
        continue;
      }

      // 조건을 통과한 경우만 리스트에 추가
      allItems.add({
        'id': element.getElement('LOST_MNG_NO')?.innerText ?? '',
        'kind': element.getElement('LOST_KND')?.innerText ?? '',
        'status': element.getElement('LOST_STTS')?.innerText ?? '',
        'name': element.getElement('LOST_NM')?.innerText ?? '',
        'place': element.getElement('CSTD_PLC')?.innerText ?? '',
        'company': element.getElement('RCPL')?.innerText ?? '',
        'regDate': element.getElement('REG_YMD')?.innerText ?? '',
        'registrarId': element.getElement('LOST_RGTR_ID')?.innerText ?? '',
        'detail' : element.getElement('LGS_DTL_CN')?.innerText ?? ''
      });
    }



    print('📦 $start ~ $end 처리 완료 (${allItems.length} 누적)');
  }

  return allItems;
}
