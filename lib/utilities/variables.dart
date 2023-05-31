import 'package:dagather_frontend/models/mission_type_model.dart';
import 'package:dagather_frontend/utilities/colors.dart';

enum ProfileFilterType {
  nation,
  basic,
}

enum MessageType {
  text,
  image,
  all,
}

enum TagType {
  purpose,
  interest,
}

enum GenderType {
  woman,
  man,
}

class FriendRequestType {
  static const send = 1;
  static const receive = 0;
}

class FriendStateType {
  static const isNotFriend = 'NONE';
  static const send = 'SEND';
  static const receive = 'RECEIVE';
  static const isFriend = 'FRIEND';
}

final missionTypes = [
  MissionTypeModel(
    value: 0,
    color: AppColor.red,
    subColor: AppColor.redLight,
  ),
  MissionTypeModel(
    value: 1,
    color: AppColor.yellow4,
    subColor: AppColor.yellow1,
  ),
  MissionTypeModel(
    value: 2,
    color: AppColor.green,
    subColor: AppColor.greenLight,
  ),
  MissionTypeModel(
    value: 3,
    color: AppColor.blue,
    subColor: AppColor.blueLight,
  ),
];

final List<Map<String, String>> detectLanguages = [
  {
    "language": '한국어',
    "code": 'ko',
  },
  {
    "language": '일본어',
    "code": 'ja',
  },
  {
    "language": '중국어 간체',
    "code": 'zh-CN',
  },
  {
    "language": '중국어 번체',
    "code": 'zh-TW',
  },
  {
    "language": '힌디어',
    "code": 'hi',
  },
  {
    "language": '영어',
    "code": 'en',
  },
  {
    "language": '스페인어',
    "code": 'es',
  },
  {
    "language": '프랑스어',
    "code": 'fr',
  },
  {
    "language": '독일어',
    "code": 'de',
  },
  {
    "language": '포르투갈어',
    "code": 'pt',
  },
  {
    "language": '베트남어',
    "code": 'vi',
  },
  {
    "language": '인도네시아어',
    "code": 'id',
  },
  {
    "language": '페르시아어',
    "code": 'fa',
  },
  {
    "language": '아랍어',
    "code": 'ar',
  },
  {
    "language": '미얀마어',
    "code": 'mm',
  },
  {
    "language": '태국어',
    "code": 'th',
  },
  {
    "language": '러시아어',
    "code": 'ru',
  },
  {
    "language": '이탈리아어',
    "code": 'it',
  },
];

final Map<String, List<String>> avaliableTranslate = {
  'ko': [
    'en',
    'ja',
    'zh-CN',
    'zh-TW',
    'vi',
    'id',
    'th',
    'de',
    'ru',
    'es',
    'it',
    'fr',
  ],
  'en': ['fr', 'zh-CN', 'zh-TW', 'ko'],
  'ja': ['zh-CN', 'zh-TW', 'ko', 'en'],
  'zh-CN': ['zh-TW', 'ko', 'en', 'ja'],
  'zh-TW': ['zh-CN', 'ko', 'en', 'ja'],
  'vi': ['ko'],
  'id': ['ko'],
  'th': ['ko'],
  'de': ['ko'],
  'ru': ['ko'],
  'es': ['ko'],
  'it': ['ko'],
  'fr': ['ko', 'en'],
};

final purposes = [
  '한국어 공부',
  '한국 생활 적응',
  '친목',
  '육아정보공유',
];

final interests = [
  '게임',
  '등산',
  '축구',
  '야구',
  '배드민턴',
  '테니스',
  '골프',
  '스키',
  '스노우보드',
  '서핑',
  '볼링',
  '캠핑',
  '헬스',
  '요가',
  '필라테스',
  '명상',
  '러닝',
  '홈트',
  '수영',
  '베이킹',
  '요리',
  '술',
  '카페',
  '음식',
  '디저트',
  '맛집',
  '주식',
  '재태크',
  '넷플릭스',
  '웹툰',
  'k-pop',
  '유튜브',
  '드라마',
  '애니메이션',
  '영화',
  '틱톡',
  '책',
  '음악',
  '패션',
  '메이크업',
  '노래',
  '전시회/박물관',
  '연극/뮤지컬',
  '댄스',
  '미술',
  '콘서트/페스티벌',
  '여행',
  '인권',
  '환경',
  '정치'
];

final periods = [
  {
    "name": '3개월 미만',
    "value": '3개월 미만',
  },
  {
    'name': '3개월 ~ 6개월',
    'value': '3개월 ~ 6개월',
  },
  {
    'name': '6개월 ~ 1년',
    'value': '6개월 ~ 1년',
  },
  {
    'name': '1년 ~ 3년',
    'value': '1년 ~ 3년',
  },
  {
    'name': '3년 ~ 5년',
    'value': '3년 ~ 5년',
  },
  {
    'name': '5년 ~ 10년',
    'value': '5년 ~ 10년',
  },
  {
    'name': '10년 이상',
    'value': '10년 이상',
  }
];

final countries = [
  {
    "name": "아프가니스탄",
    "code": "AF",
    "emoji": "🇦🇫",
  },
  {
    "name": "올란드 제도",
    "code": "AX",
    "emoji": "🇦🇽",
  },
  {
    "name": "알바니아",
    "code": "AL",
    "emoji": "🇦🇱",
  },
  {
    "name": "알제리",
    "code": "DZ",
    "emoji": "🇩🇿",
  },
  {
    "name": "아메리칸사모아",
    "code": "AS",
    "emoji": "🇦🇸",
  },
  {
    "name": "안도라",
    "code": "AD",
    "emoji": "🇦🇩",
  },
  {
    "name": "앙골라",
    "code": "AO",
    "emoji": "🇦🇴",
  },
  {
    "name": "앵귈라",
    "code": "AI",
    "emoji": "🇦🇮",
  },
  {
    "name": "앤티가 바부다",
    "code": "AG",
    "emoji": "🇦🇬",
  },
  {
    "name": "아르헨티나",
    "code": "AR",
    "emoji": "🇦🇷",
  },
  {
    "name": "아르메니아",
    "code": "AM",
    "emoji": "🇦🇲",
  },
  {
    "name": "아루바",
    "code": "AW",
    "emoji": "🇦🇼",
  },
  {
    "name": "오스트레일리아",
    "code": "AU",
    "emoji": "🇦🇺",
  },
  {
    "name": "오스트리아",
    "code": "AT",
    "emoji": "🇦🇹",
  },
  {
    "name": "아제르바이잔",
    "code": "AZ",
    "emoji": "🇦🇿",
  },
  {
    "name": "바하마",
    "code": "BS",
    "emoji": "🇧🇸",
  },
  {
    "name": "바레인",
    "code": "BH",
    "emoji": "🇧🇭",
  },
  {
    "name": "방글라데시",
    "code": "BD",
    "emoji": "🇧🇩",
  },
  {
    "name": "바베이도스",
    "code": "BB",
    "emoji": "🇧🇧",
  },
  {
    "name": "벨라루스",
    "code": "BY",
    "emoji": "🇧🇾",
  },
  {
    "name": "벨기에",
    "code": "BE",
    "emoji": "🇧🇪",
  },
  {
    "name": "벨리즈",
    "code": "BZ",
    "emoji": "🇧🇿",
  },
  {
    "name": "베냉",
    "code": "BJ",
    "emoji": "🇧🇯",
  },
  {
    "name": "버뮤다",
    "code": "BM",
    "emoji": "🇧🇲",
  },
  {
    "name": "부탄",
    "code": "BT",
    "emoji": "🇧🇹",
  },
  {
    "name": "볼리비아",
    "code": "BO",
    "emoji": "🇧🇴",
  },
  {
    "name": "보스니아 헤르체고비나",
    "code": "BA",
    "emoji": "🇧🇦",
  },
  {
    "name": "보츠와나",
    "code": "BW",
    "emoji": "🇧🇼",
  },
  {
    "name": "부베 섬",
    "code": "BV",
    "emoji": "🇧🇻",
  },
  {
    "name": "브라질",
    "code": "BR",
    "emoji": "🇧🇷",
  },
  {
    "name": "영국령 인도양 지역",
    "code": "IO",
    "emoji": "🇮🇴",
  },
  {
    "name": "브루나이",
    "code": "BN",
    "emoji": "🇧🇳",
  },
  {
    "name": "불가리아",
    "code": "BG",
    "emoji": "🇧🇬",
  },
  {
    "name": "부르키나파소",
    "code": "BF",
    "emoji": "🇧🇫",
  },
  {
    "name": "부룬디",
    "code": "BI",
    "emoji": "🇧🇮",
  },
  {
    "name": "캄보디아",
    "code": "KH",
    "emoji": "🇰🇭",
  },
  {
    "name": "카메룬",
    "code": "CM",
    "emoji": "🇨🇲",
  },
  {
    "name": "캐나다",
    "code": "CA",
    "emoji": "🇨🇦",
  },
  {
    "name": "카보베르데",
    "code": "CV",
    "emoji": "🇨🇻",
  },
  {
    "name": "케이맨 제도",
    "code": "KY",
    "emoji": "🇰🇾",
  },
  {
    "name": "중앙아프리카 공화국",
    "code": "CF",
    "emoji": "🇨🇫",
  },
  {
    "name": "차드",
    "code": "TD",
    "emoji": "🇹🇩",
  },
  {
    "name": "칠레",
    "code": "CL",
    "emoji": "🇨🇱",
  },
  {
    "name": "중화인민공화국",
    "code": "CN",
    "emoji": "🇨🇳",
  },
  {
    "name": "크리스마스 섬",
    "code": "CX",
    "emoji": "🇨🇽",
  },
  {
    "name": "코코스 제도",
    "code": "CC",
    "emoji": "🇨🇨",
  },
  {
    "name": "콜롬비아",
    "code": "CO",
    "emoji": "🇨🇴",
  },
  {
    "name": "코모로",
    "code": "KM",
    "emoji": "🇰🇲",
  },
  {
    "name": "콩고 공화국",
    "code": "CG",
    "emoji": "🇨🇬",
  },
  {
    "name": "쿡 제도",
    "code": "CK",
    "emoji": "🇨🇰",
  },
  {
    "name": "코스타리카",
    "code": "CR",
    "emoji": "🇨🇷",
  },
  {
    "name": "코트디부아르",
    "code": "CI",
    "emoji": "🇨🇮",
  },
  {
    "name": "크로아티아",
    "code": "HR",
    "emoji": "🇭🇷",
  },
  {
    "name": "쿠바",
    "code": "CU",
    "emoji": "🇨🇺",
  },
  {
    "name": "키프로스",
    "code": "CY",
    "emoji": "🇨🇾",
  },
  {
    "name": "체코",
    "code": "CZ",
    "emoji": "🇨🇿",
  },
  {
    "name": "덴마크",
    "code": "DK",
    "emoji": "🇩🇰",
  },
  {
    "name": "지부티",
    "code": "DJ",
    "emoji": "🇩🇯",
  },
  {
    "name": "도미니카 연방",
    "code": "DM",
    "emoji": "🇩🇲",
  },
  {
    "name": "도미니카 공화국",
    "code": "DO",
    "emoji": "🇩🇴",
  },
  {
    "name": "동티모르",
    "code": "TL",
    "emoji": "🇹🇱",
  },
  {
    "name": "에콰도르",
    "code": "EC",
    "emoji": "🇪🇨",
  },
  {
    "name": "이집트",
    "code": "EG",
    "emoji": "🇪🇬",
  },
  {
    "name": "엘살바도르",
    "code": "SV",
    "emoji": "🇸🇻",
  },
  {
    "name": "적도 기니",
    "code": "GQ",
    "emoji": "🇬🇶",
  },
  {
    "name": "에리트레아",
    "code": "ER",
    "emoji": "🇪🇷",
  },
  {
    "name": "에스토니아",
    "code": "EE",
    "emoji": "🇪🇪",
  },
  {
    "name": "에티오피아",
    "code": "ET",
    "emoji": "🇪🇹",
  },
  {
    "name": "포클랜드 제도",
    "code": "FK",
    "emoji": "🇫🇰",
  },
  {
    "name": "페로 제도",
    "code": "FO",
    "emoji": "🇫🇴",
  },
  {
    "name": "피지",
    "code": "FJ",
    "emoji": "🇫🇯",
  },
  {
    "name": "핀란드",
    "code": "FI",
    "emoji": "🇫🇮",
  },
  {
    "name": "프랑스",
    "code": "FR",
    "emoji": "🇫🇷",
  },
  {
    "name": "프랑스령 기아나",
    "code": "GF",
    "emoji": "🇬🇫",
  },
  {
    "name": "프랑스령 폴리네시아",
    "code": "PF",
    "emoji": "🇵🇫",
  },
  {
    "name": "프랑스령 남부와 남극 지역",
    "code": "TF",
    "emoji": "🇹🇫",
  },
  {
    "name": "가봉",
    "code": "GA",
    "emoji": "🇬🇦",
  },
  {
    "name": "감비아",
    "code": "GM",
    "emoji": "🇬🇲",
  },
  {
    "name": "조지아",
    "code": "GE",
    "emoji": "🇬🇪",
  },
  {
    "name": "독일",
    "code": "DE",
    "emoji": "🇩🇪",
  },
  {
    "name": "가나",
    "code": "GH",
    "emoji": "🇬🇭",
  },
  {
    "name": "지브롤터",
    "code": "GI",
    "emoji": "🇬🇮",
  },
  {
    "name": "그리스",
    "code": "GR",
    "emoji": "🇬🇷",
  },
  {
    "name": "그린란드",
    "code": "GL",
    "emoji": "🇬🇱",
  },
  {
    "name": "그레나다",
    "code": "GD",
    "emoji": "🇬🇩",
  },
  {
    "name": "과들루프",
    "code": "GP",
    "emoji": "🇬🇵",
  },
  {
    "name": "괌",
    "code": "GU",
    "emoji": "🇬🇺",
  },
  {
    "name": "과테말라",
    "code": "GT",
    "emoji": "🇬🇹",
  },
  {
    "name": "건지 섬",
    "code": "GG",
    "emoji": "🇬🇬",
  },
  {
    "name": "기니",
    "code": "GN",
    "emoji": "🇬🇳",
  },
  {
    "name": "기니비사우",
    "code": "GW",
    "emoji": "🇬🇼",
  },
  {
    "name": "가이아나",
    "code": "GY",
    "emoji": "🇬🇾",
  },
  {
    "name": "아이티",
    "code": "HT",
    "emoji": "🇭🇹",
  },
  {
    "name": "허드 맥도널드 제도",
    "code": "HM",
    "emoji": "🇭🇲",
  },
  {
    "name": "온두라스",
    "code": "HN",
    "emoji": "🇭🇳",
  },
  {
    "name": "홍콩",
    "code": "HK",
    "emoji": "🇭🇰",
  },
  {
    "name": "헝가리",
    "code": "HU",
    "emoji": "🇭🇺",
  },
  {
    "name": "아이슬란드",
    "code": "IS",
    "emoji": "🇮🇸",
  },
  {
    "name": "인도",
    "code": "IN",
    "emoji": "🇮🇳",
  },
  {
    "name": "인도네시아",
    "code": "ID",
    "emoji": "🇮🇩",
  },
  {
    "name": "이란",
    "code": "IR",
    "emoji": "🇮🇷",
  },
  {
    "name": "이라크",
    "code": "IQ",
    "emoji": "🇮🇶",
  },
  {
    "name": "아일랜드",
    "code": "IE",
    "emoji": "🇮🇪",
  },
  {
    "name": "맨 섬",
    "code": "IM",
    "emoji": "🇮🇲",
  },
  {
    "name": "이스라엘",
    "code": "IL",
    "emoji": "🇮🇱",
  },
  {
    "name": "이탈리아",
    "code": "IT",
    "emoji": "🇮🇹",
  },
  {
    "name": "자메이카",
    "code": "JM",
    "emoji": "🇯🇲",
  },
  {
    "name": "일본",
    "code": "JP",
    "emoji": "🇯🇵",
  },
  {
    "name": "저지 섬",
    "code": "JE",
    "emoji": "🇯🇪",
  },
  {
    "name": "요르단",
    "code": "JO",
    "emoji": "🇯🇴",
  },
  {
    "name": "카자흐스탄",
    "code": "KZ",
    "emoji": "🇰🇿",
  },
  {
    "name": "케냐",
    "code": "KE",
    "emoji": "🇰🇪",
  },
  {
    "name": "키리바시",
    "code": "KI",
    "emoji": "🇰🇮",
  },
  {
    "name": "조선민주주의인민공화국",
    "code": "KP",
    "emoji": "🇰🇵",
  },
  {
    "name": "대한민국",
    "code": "KR",
    "emoji": "🇰🇷",
  },
  {
    "name": "쿠웨이트",
    "code": "KW",
    "emoji": "🇰🇼",
  },
  {
    "name": "키르기스스탄",
    "code": "KG",
    "emoji": "🇰🇬",
  },
  {
    "name": "라오스",
    "code": "LA",
    "emoji": "🇱🇦",
  },
  {
    "name": "라트비아",
    "code": "LV",
    "emoji": "🇱🇻",
  },
  {
    "name": "레바논",
    "code": "LB",
    "emoji": "🇱🇧",
  },
  {
    "name": "레소토",
    "code": "LS",
    "emoji": "🇱🇸",
  },
  {
    "name": "라이베리아",
    "code": "LR",
    "emoji": "🇱🇷",
  },
  {
    "name": "리비아",
    "code": "LY",
    "emoji": "🇱🇾",
  },
  {
    "name": "리히텐슈타인",
    "code": "LI",
    "emoji": "🇱🇮",
  },
  {
    "name": "리투아니아",
    "code": "LT",
    "emoji": "🇱🇹",
  },
  {
    "name": "룩셈부르크",
    "code": "LU",
    "emoji": "🇱🇺",
  },
  {
    "name": "마카오",
    "code": "MO",
    "emoji": "🇲🇴",
  },
  {
    "name": "마다가스카르",
    "code": "MG",
    "emoji": "🇲🇬",
  },
  {
    "name": "말라위",
    "code": "MW",
    "emoji": "🇲🇼",
  },
  {
    "name": "Malaysia",
    "code": "MY",
    "emoji": "🇲🇾",
  },
  {
    "name": "말레이시아",
    "code": "MV",
    "emoji": "🇲🇻",
  },
  {
    "name": "말리",
    "code": "ML",
    "emoji": "🇲🇱",
  },
  {
    "name": "몰타",
    "code": "MT",
    "emoji": "🇲🇹",
  },
  {
    "name": "마셜 제도",
    "code": "MH",
    "emoji": "🇲🇭",
  },
  {
    "name": "마르티니크",
    "code": "MQ",
    "emoji": "🇲🇶",
  },
  {
    "name": "모리타니",
    "code": "MR",
    "emoji": "🇲🇷",
  },
  {
    "name": "모리셔스",
    "code": "MU",
    "emoji": "🇲🇺",
  },
  {
    "name": "마요트",
    "code": "YT",
    "emoji": "🇾🇹",
  },
  {
    "name": "멕시코",
    "code": "MX",
    "emoji": "🇲🇽",
  },
  {
    "name": "미크로네시아 연방",
    "code": "FM",
    "emoji": "🇫🇲",
  },
  {
    "name": "몰도바",
    "code": "MD",
    "emoji": "🇲🇩",
  },
  {
    "name": "모나코",
    "code": "MC",
    "emoji": "🇲🇨",
  },
  {
    "name": "몽골",
    "code": "MN",
    "emoji": "🇲🇳",
  },
  {
    "name": "몬테네그로",
    "code": "ME",
    "emoji": "🇲🇪",
  },
  {
    "name": "몬트세랫",
    "code": "MS",
    "emoji": "🇲🇸",
  },
  {
    "name": "모로코",
    "code": "MA",
    "emoji": "🇲🇦",
  },
  {
    "name": "모잠비크",
    "code": "MZ",
    "emoji": "🇲🇿",
  },
  {
    "name": "미얀마",
    "code": "MM",
    "emoji": "🇲🇲",
  },
  {
    "name": "나미비아",
    "code": "NA",
    "emoji": "🇳🇦",
  },
  {
    "name": "나우루",
    "code": "NR",
    "emoji": "🇳🇷",
  },
  {
    "name": "네팔",
    "code": "NP",
    "emoji": "🇳🇵",
  },
  {
    "name": "네덜란드",
    "code": "NL",
    "emoji": "🇳🇱",
  },
  {
    "name": "네덜란드령 카리브",
    "code": "BQ",
    "emoji": "🇧🇶",
  },
  {
    "name": "누벨칼레도니",
    "code": "NC",
    "emoji": "🇳🇨",
  },
  {
    "name": "뉴질랜드",
    "code": "NZ",
    "emoji": "🇳🇿",
  },
  {
    "name": "니카라과",
    "code": "NI",
    "emoji": "🇳🇮",
  },
  {
    "name": "니제르",
    "code": "NE",
    "emoji": "🇳🇪",
  },
  {
    "name": "나이지리아",
    "code": "NG",
    "emoji": "🇳🇬",
  },
  {
    "name": "니우에",
    "code": "NU",
    "emoji": "🇳🇺",
  },
  {
    "name": "노퍽 섬",
    "code": "NF",
    "emoji": "🇳🇫",
  },
  {
    "name": "북마리아나 제도",
    "code": "MP",
    "emoji": "🇲🇵",
  },
  {
    "name": "노르웨이",
    "code": "NO",
    "emoji": "🇳🇴",
  },
  {
    "name": "오만",
    "code": "OM",
    "emoji": "🇴🇲",
  },
  {
    "name": "파키스탄",
    "code": "PK",
    "emoji": "🇵🇰",
  },
  {
    "name": "팔라우",
    "code": "PW",
    "emoji": "🇵🇼",
  },
  {
    "name": "팔레스타인",
    "code": "PS",
    "emoji": "🇵🇸",
  },
  {
    "name": "파나마",
    "code": "PA",
    "emoji": "🇵🇦",
  },
  {
    "name": "파푸아 뉴기니",
    "code": "PG",
    "emoji": "🇵🇬",
  },
  {
    "name": "파라과이",
    "code": "PY",
    "emoji": "🇵🇾",
  },
  {
    "name": "페루",
    "code": "PE",
    "emoji": "🇵🇪",
  },
  {
    "name": "필리핀",
    "code": "PH",
    "emoji": "🇵🇭",
  },
  {
    "name": "핏케언 제도",
    "code": "PN",
    "emoji": "🇵🇳",
  },
  {
    "name": "폴란드",
    "code": "PL",
    "emoji": "🇵🇱",
  },
  {
    "name": "포르투갈",
    "code": "PT",
    "emoji": "🇵🇹",
  },
  {
    "name": "푸에르토리코",
    "code": "PR",
    "emoji": "🇵🇷",
  },
  {
    "name": "카타르",
    "code": "QA",
    "emoji": "🇶🇦",
  },
  {
    "name": "마케도니아 공화국",
    "code": "MK",
    "emoji": "🇲🇰",
  },
  {
    "name": "남수단",
    "code": "SS",
    "emoji": "🇸🇸",
  },
  {
    "name": "레위니옹",
    "code": "RE",
    "emoji": "🇷🇪",
  },
  {
    "name": "루마니아",
    "code": "RO",
    "emoji": "🇷🇴",
  },
  {
    "name": "러시아",
    "code": "RU",
    "emoji": "🇷🇺",
  },
  {
    "name": "르완다",
    "code": "RW",
    "emoji": "🇷🇼",
  },
  {
    "name": "세인트키츠 네비스",
    "code": "KN",
    "emoji": "🇰🇳",
  },
  {
    "name": "세인트루시아",
    "code": "LC",
    "emoji": "🇱🇨",
  },
  {
    "name": "세인트빈센트 그레나딘",
    "code": "VC",
    "emoji": "🇻🇨",
  },
  {
    "name": "사모아",
    "code": "WS",
    "emoji": "🇼🇸",
  },
  {
    "name": "산마리노",
    "code": "SM",
    "emoji": "🇸🇲",
  },
  {
    "name": "상투메 프린시페",
    "code": "ST",
    "emoji": "🇸🇹",
  },
  {
    "name": "사우디아라비아",
    "code": "SA",
    "emoji": "🇸🇦",
  },
  {
    "name": "세네갈",
    "code": "SN",
    "emoji": "🇸🇳",
  },
  {
    "name": "세르비아",
    "code": "RS",
    "emoji": "🇷🇸",
  },
  {
    "name": "세이셸",
    "code": "SC",
    "emoji": "🇸🇨",
  },
  {
    "name": "시에라리온",
    "code": "SL",
    "emoji": "🇸🇱",
  },
  {
    "name": "싱가포르",
    "code": "SG",
    "emoji": "🇸🇬",
  },
  {
    "name": "슬로바키아",
    "code": "SK",
    "emoji": "🇸🇰",
  },
  {
    "name": "슬로베니아",
    "code": "SI",
    "emoji": "🇸🇮",
  },
  {
    "name": "소말리아",
    "code": "SO",
    "emoji": "🇸🇴",
  },
  {
    "name": "남아프리카 공화국",
    "code": "ZA",
    "emoji": "🇿🇦",
  },
  {
    "name": "사우스조지아 사우스샌드위치 제도",
    "code": "GS",
    "emoji": "🇬🇸",
  },
  {
    "name": "스페인",
    "code": "ES",
    "emoji": "🇪🇸",
  },
  {
    "name": "스리랑카",
    "code": "LK",
    "emoji": "🇱🇰",
  },
  {
    "name": "세인트헬레나",
    "code": "SH",
    "emoji": "🇸🇭",
  },
  {
    "name": "생피에르 미클롱",
    "code": "PM",
    "emoji": "🇵🇲",
  },
  {
    "name": "수단",
    "code": "SD",
    "emoji": "🇸🇩",
  },
  {
    "name": "수리남",
    "code": "SR",
    "emoji": "🇸🇷",
  },
  {
    "name": "스발바르 얀마옌",
    "code": "SJ",
    "emoji": "🇸🇯",
  },
  {
    "name": "에스와티니",
    "code": "SZ",
    "emoji": "🇸🇿",
  },
  {
    "name": "스웨덴",
    "code": "SE",
    "emoji": "🇸🇪",
  },
  {
    "name": "스위스",
    "code": "CH",
    "emoji": "🇨🇭",
  },
  {
    "name": "시리아",
    "code": "SY",
    "emoji": "🇸🇾",
  },
  {
    "name": "트리스탄다쿠나",
    "code": "TA",
    "emoji": "🇹🇦",
  },
  {
    "name": "중화민국",
    "code": "TW",
    "emoji": "🇹🇼",
  },
  {
    "name": "타지키스탄",
    "code": "TJ",
    "emoji": "🇹🇯",
  },
  {
    "name": "탄자니아",
    "code": "TZ",
    "emoji": "🇹🇿",
  },
  {
    "name": "타이",
    "code": "TH",
    "emoji": "🇹🇭",
  },
  {
    "name": "토고",
    "code": "TG",
    "emoji": "🇹🇬",
  },
  {
    "name": "토켈라우",
    "code": "TK",
    "emoji": "🇹🇰",
  },
  {
    "name": "통가",
    "code": "TO",
    "emoji": "🇹🇴",
  },
  {
    "name": "트리니다드 토바고",
    "code": "TT",
    "emoji": "🇹🇹",
  },
  {
    "name": "튀니지",
    "code": "TN",
    "emoji": "🇹🇳",
  },
  {
    "name": "터키",
    "code": "TR",
    "emoji": "🇹🇷",
  },
  {
    "name": "투르크메니스탄",
    "code": "TM",
    "emoji": "🇹🇲",
  },
  {
    "name": "터크스 케이커스 제도",
    "code": "TC",
    "emoji": "🇹🇨",
  },
  {
    "name": "투발루",
    "code": "TV",
    "emoji": "🇹🇻",
  },
  {
    "name": "우간다",
    "code": "UG",
    "emoji": "🇺🇬",
  },
  {
    "name": "우크라이나",
    "code": "UA",
    "emoji": "🇺🇦",
  },
  {
    "name": "아랍에미리트",
    "code": "AE",
    "emoji": "🇦🇪",
  },
  {
    "name": "영국",
    "code": "GB",
    "emoji": "🇬🇧",
  },
  {
    "name": "미국",
    "code": "US",
    "emoji": "🇺🇸",
  },
  {
    "name": "미국령 해외 제도",
    "code": "UM",
    "emoji": "🇺🇲",
  },
  {
    "name": "우루과이",
    "code": "UY",
    "emoji": "🇺🇾",
  },
  {
    "name": "우즈베키스탄",
    "code": "UZ",
    "emoji": "🇺🇿",
  },
  {
    "name": "바누아투",
    "code": "VU",
    "emoji": "🇻🇺",
  },
  {
    "name": "바티칸 시국",
    "code": "VA",
    "emoji": "🇻🇦",
  },
  {
    "name": "베네수엘라",
    "code": "VE",
    "emoji": "🇻🇪",
  },
  {
    "name": "베트남",
    "code": "VN",
    "emoji": "🇻🇳",
  },
  {
    "name": "영국령 버진아일랜드",
    "code": "VG",
    "emoji": "🇻🇬",
  },
  {
    "name": "미국령 버진아일랜드",
    "code": "VI",
    "emoji": "🇻🇮",
  },
  {
    "name": "왈리스 퓌튀나",
    "code": "WF",
    "emoji": "🇼🇫",
  },
  {
    "name": "서사하라",
    "code": "EH",
    "emoji": "🇪🇭",
  },
  {
    "name": "코소보",
    "code": "XK",
    "emoji": "🇽🇰",
  },
  {
    "name": "예멘",
    "code": "YE",
    "emoji": "🇾🇪",
  },
  {
    "name": "잠비아",
    "code": "ZM",
    "emoji": "🇿🇲",
  },
  {
    "name": "짐바브웨",
    "code": "ZW",
    "emoji": "🇿🇼",
  },
  {
    "name": "신트마르턴",
    "code": "SX",
    "emoji": "🇸🇽",
  },
  {
    "name": "어센션 섬",
    "code": "AC",
    "emoji": "🇦🇨",
  },
  {
    "name": "생바르텔레미",
    "code": "BL",
    "emoji": "🇧🇱",
  },
  {
    "name": "클리퍼턴 섬",
    "code": "CP",
    "emoji": "🇨🇵",
  },
  {
    "name": "퀴라소",
    "code": "CW",
    "emoji": "🇨🇼",
  },
  {
    "name": "디에고 가르시아",
    "code": "DG",
    "emoji": "🇩🇬",
  },
  {
    "name": "세우타 및 멜리야",
    "code": "EA",
    "emoji": "🇪🇦",
  },
  {
    "name": "카나리아 제도",
    "code": "IC",
    "emoji": "🇮🇨",
  },
  {
    "name": "생마르탱",
    "code": "MF",
    "emoji": "🇲🇫",
  },
  {
    "name": "남극",
    "code": "AQ",
    "emoji": "🇦🇶",
  },
];
