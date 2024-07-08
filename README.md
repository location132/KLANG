# KLANG

## 🔍 프로젝트 개요
프로젝트 잎사이에 이어서, 클랭 프로젝트는 Flutter 개발과 PM 역할을 맡은 제 두 번째 프로젝트입니다.<br />이 프로젝트에서 제가 처음 세운 목표는 학생 신분으로서 최대한의 포트폴리오를 구축하는 것이었으며, <br />이를 통해 커뮤니케이션과 협업의 중요성을 강조하고 싶었습니다. <br />14명의 팀원들과 함께 신뢰를 바탕으로 각자의 역할을 충실히 수행하며, 커뮤니케이션 오류 없이 공동의 목표를 달성해 나갔습니다.<br />
현재 이 프로젝트는 u300 지원사업에 계획서를 제출한 상태이며, 다가오는 2월 배포를 목표로 진행하고 있습니다.
<br />
<br />

<img src="https://github.com/location132/IFSAI/assets/132702102/ab4a1dcf-468c-434f-8197-9d32cd519ce2" width="20" alt="Project Image"> <a href="https://www.figma.com/design/FwD55zosIVRHQ8a6LqD5Fk/클랭-%2F-design?node-id=0-1&t=VsBVALbBUHN3kb02-0"><strong>피그마 바로가기 (Web)</strong></a> 
<br />
 <img src="https://github.com/location132/IFSAI/assets/132702102/81fbb182-9ce0-4881-b81c-d3b47c1feeb0" width="20" alt="Project Image"> <a href="https://intriguing-cowl-e9d.notion.site/KLANG-fb9ad7a5dd4b4e419e1f2291684502c5?pvs=4"><strong>노션 바로가기 (Web)</strong></a>


<br />

## 팀원 소개


| 이정원 (PM) | 김형준 (팀장) | 박상진 (팀장) | 김도윤 (팀장) | 장하빈 (팀장) | 문성윤 (bob) | 
| :-: | :-: | :-: | :-: | :-: | :-: | 
| **Flutter** 개발자 | **React** 개발자 | **Spring Boot** 개발자 | **경영** | **디자이너** | **보안 전문가** | 
| 이정원 | 김형준, 석재범, 안영주 | 박상진, 이승진, 정유진 | 김도윤, 이수, 최조은 | 장하빈, 최정원, 구나래 | 문성윤 |


<br />

## 💻 개발 환경

### APP
![Dart](https://img.shields.io/badge/Dart-0175C2.svg?&style=for-the-badge&logo=Dart&logoColor=white)
![Flutter](https://img.shields.io/badge/flutter-02569B.svg?&style=for-the-badge&logo=flutter&logoColor=white)
![Figma](https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white)
![Zeplin](https://img.shields.io/badge/zeplin-EE6723?style=for-the-badge&logo=openzeppelin&logoColor=white)

### BACKEND
![Java](https://img.shields.io/badge/Java-007396.svg?&style=for-the-badge&logo=Java&logoColor=white)
![SpringBoot](https://img.shields.io/badge/SpringBoot-6DB33F.svg?&style=for-the-badge&logo=springboot&logoColor=white)
![springsecurity](https://img.shields.io/badge/springsecurity-6DB33F.svg?&style=for-the-badge&logo=springsecurity&logoColor=white)
![amazons3](https://img.shields.io/badge/amazons3-569A31.svg?&style=for-the-badge&logo=amazons3&logoColor=white)
![swagger](https://img.shields.io/badge/swagger-85EA2D.svg?&style=for-the-badge&logo=swagger&logoColor=white)

### Collaboration
![Notion](https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=Notion&logoColor=white)
![discord](https://img.shields.io/badge/discord-5865F2?style=for-the-badge&logo=Discord&logoColor=white)
![Github](https://img.shields.io/badge/Github-181717.svg?&style=for-the-badge&logo=github&logoColor=white)

<br />

## App 화면 구성
App 화면 구성은 아래의 노션 링크를 클릭해주세요:

[App 화면 구성 노션 링크](https://intriguing-cowl-e9d.notion.site/flutter-c919267f80f2483bbf6f6fef4a19b662?pvs=4)


<br />

## 📌 특이사항

![image](https://github.com/location132/KLANG/assets/132702102/9f1abfb4-811c-44f9-a56c-5afa4582bd50)
- dotENV 파일 관리
- 상태관리, 생명주기, 애니메이션, API연결 등
- 커뮤니케이션 오류 없이 협업하기



<br />

## 📁 Flutter 아키텍쳐

```
lib
├── \010mainPage
│   ├── clang_search_detail
│   │   ├── search_bar.dart
│   │   ├── search_dio.dart
│   │   ├── search_history.dart
│   │   ├── search_popularSearches.dart
│   │   └── search_related.dart
│   └── main_page_detail
│       └── main_screen.dart
├── LoadingScreen.dart
├── core_services
│   ├── SharedPreferences.dart
│   ├── authentication_dio.dart
│   ├── provider.dart
│   ├── routes.dart
│   ├── token_required_dio.dart
│   └── verify_form.dart
├── join_membership
│   ├── agree_page
│   │   ├── AgreePageModal.dart
│   │   ├── MarketingAgreedPage.dart
│   │   ├── PrivacyAgreedPage.dart
│   │   └── ServiceAgreedPage.dart
│   ├── join_email.dart
│   ├── join_password.dart
│   └── join_phonenumber.dart
├── klang_mainscreen
│   ├── 0_coreScreen
│   │   └── logo_screen.dart
│   ├── 1_startPage
│   │   └── start_page.dart
│   ├── 2_membership
│   │   ├── login_page.dart
│   │   └── snslogin
│   │       ├── apple_login.dart
│   │       ├── google_login.dart
│   │       ├── kakao_login.dart
│   │       └── naver_login.dart
│   ├── 3_emailLogin
│   │   ├── detail
│   │   │   ├── ld_input_login.dart
│   │   │   └── ld_social_login_widget.dart
│   │   └── emailLogin_page.dart
│   ├── 4_emailError
│   │   ├── detail
│   │   │   ├── input_code.dart
│   │   │   ├── input_name.dart
│   │   │   └── input_phone.dart
│   │   └── error_id_password.dart
│   ├── 5_findidpw
│   │   ├── detail
│   │   │   ├── 0_defaultTabController.dart
│   │   │   ├── 1_find_id.dart
│   │   │   ├── 2_find_id_detail.dart
│   │   │   ├── 3_find_pw.dart
│   │   │   └── 4_find_pw_detail.dart
│   │   └── find_id_password.dart
│   ├── 6_joinmembership
│   │   ├── detail
│   │   │   ├── email_field.dart
│   │   │   ├── password_field.dart
│   │   │   └── phone_field.dart
│   │   └── membership_page.dart
│   └── Main_page.dart
├── main.dart
├── my_page
│   ├── SellerStore.dart
│   ├── TalentRequest.dart
│   └── notification_settings.dart
└── wishlist_page.dart


