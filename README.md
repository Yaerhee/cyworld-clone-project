# cyworld-clone-project

싸이월드 클론 및 기능 구현 Project 입니다.  
(2020.12.21 - 2021.01.19) 

<b>개발목표:</b>
1. JAVA, Spring 및 JavaScript 등을 활용하여 실용적인 웹 환경 구축  
2. DB 데이터를 실제 페이지에 연동 및 구현하는 웹 사이트 개발  

<b>개발환경:</b>    

*  [OS] Windows 10 / [IDE] Eclipse / VSCode  
*  [Server] Apache Tomcat 8.5.59  
*  Spring 3.0 / Oracle Database (11g)  
*  jQuery / jQueryUI / Ajax / Bootstrap + HTML, CSS  
  
<b>담당업무:</b>  

1. 싸이월드 메인 회원가입 페이지  
  – 회원가입 조건 및 ID 중복체크 구현  
2. 선물가게 메인, 싸이월드 메인   
  – 디자인 + 데이터 연동 (ex. 회원 가입한 유저 데이터 출력, 싸이월드는 폰트 적용하여 출력)
3. 선물가게 제품 list 페이지   
  – DB 상품 random 배열문 구현, 제품 장바구니에 담을 시 swal 팝업 출력(버튼 클릭에 따른 기능 구현)  
4. 선물가게 제품/제품상세 페이지 이동 시   
  – EL문을 통한 선택 데이터 출력, jQuery를 통해 cyworld 메인 로고 및 링크가 변동되도록 설계  
5. 싸이월드 동영상 게시판   
  – FileManager 기반 파일 업/다운로드 구현,  
  DB는 privacy 칼럼을 통해 공개범위 설정 및 출력 적용. Script 설계로 폴더명 특수문자 지정 방지
  
<b>Comments:</b>  
*  SpringProject 폴더 내에 파일이 위치해 있습니다.  
*  /src/main/java/com/cyworld 에는 Controller, dao, dto, mapper 등의 파일이 담겨 있습니다.  
*  /src/main/webapp/resources 에는 css, js, 이미지 등이 담겨 있습니다.  
*  /src/main/webapp/WEB-INF 에는 spring - servlet 세팅 파일과, 홈페이지를 구성하는 jsp 파일이 담겨 있습니다.
