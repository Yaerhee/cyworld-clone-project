<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String aa="_ok";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><link rel="stylesheet" href="${resourcePath }/img${userFontCss}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.unselected-Menu{
	border: 1px solid;
	border-left: 0px;
	width: 60px;
	height: 22px;
	padding-top: 6px;
	margin-bottom: 3px;
	border-top-right-radius: 6px;
	border-bottom-right-radius: 6px;
	font-size: 9pt;
	user-select:none;
}
.selected-Menu{
	border: 1px solid;
	border-left: 0px;
	background-color: white;
	width: 60px;
	height: 22px;
	padding-top: 6px;
	margin-bottom: 3px;
	border-top-right-radius: 6px;
	border-bottom-right-radius: 6px;
	font-size: 9pt;
	user-select:none;
}
</style>
<script type="text/javascript">
$(function(){
	$('.unselected-Menu').css('background-color', '#${cyMenuDTO.menuBackgroundColor }');
	$('.unselected-Menu').css('color', '#${cyMenuDTO.menuFontColor }');
	$('.unselected-Menu').css('border-color', '#${cyMenuDTO.menuBorderColor }');
	$('.selected-Menu').css('color', '#${cyMenuDTO.menuFontColor }');
	$('.selected-Menu').css('border-color', '#${cyMenuDTO.menuBorderColor }');
});
</script>
</head>
<body>
	<c:if test="${cyMenuDTO.menu1=='0' }">
		<c:if test="${menu=='menu1' }">
			<div align="center" class="selected-Menu" onclick="javaScript:location.href='user_home.action?menu=menu1&userId=${userId}';">홈</div>
		</c:if>
		<c:if test="${menu!='menu1' }">
			<div align="center" class="unselected-Menu" onclick="javaScript:location.href='user_home.action?menu=menu1&userId=${userId}';">홈</div>
		</c:if>
	</c:if>
	
	<c:if test="${cyMenuDTO.menu2=='0' }">
		<c:if test="${menu=='menu2' }">
			<div align="center" class="selected-Menu" onclick="javaScript:location.href='user_profile.action?menu=menu2&userId=${userId}';">프로필</div>
		</c:if>
		<c:if test="${menu!='menu2' }">
			<div align="center" class="unselected-Menu" onclick="javaScript:location.href='user_profile.action?menu=menu2&userId=${userId}';">프로필</div>
		</c:if>
	</c:if>
	
	<c:if test="${cyMenuDTO.menu3=='0' }">
		<c:if test="${menu=='menu3' }">
			<div align="center" class="selected-Menu" onclick="javaScript:location.href='user_picture.action?menu=menu3&userId=${userId}';">사진첩</div>
		</c:if>
		<c:if test="${menu!='menu3' }">
			<div align="center" class="unselected-Menu" onclick="javaScript:location.href='user_picture.action?menu=menu3&userId=${userId}';">사진첩</div>
		</c:if>
	</c:if>
	
	<c:if test="${cyMenuDTO.menu4=='0' }">
		<c:if test="${menu=='menu4' }">
			<div align="center" class="selected-Menu" onclick="javaScript:location.href='user_board.action?menu=menu4&userId=${userId}';">게시판</div>
		</c:if>
		<c:if test="${menu!='menu4' }">
			<div align="center" class="unselected-Menu" onclick="javaScript:location.href='user_board.action?menu=menu4&userId=${userId}';">게시판</div>
		</c:if>
	</c:if>
	
	<c:if test="${cyMenuDTO.menu5=='0' }">
		<c:if test="${menu=='menu5' }">
			<div align="center" class="selected-Menu" onclick="javaScript:location.href='user_video.action?menu=menu5&userId=${userId}';">동영상</div>
		</c:if>
		<c:if test="${menu!='menu5' }">
			<div align="center" class="unselected-Menu" onclick="javaScript:location.href='user_video.action?menu=menu5&userId=${userId}';">동영상</div>
		</c:if>
	</c:if>
	
	<c:if test="${cyMenuDTO.menu6=='0' }">
		<c:if test="${menu=='menu6' }">
			<div align="center" class="selected-Menu" onclick="javaScript:location.href='user_guest.action?menu=menu6&userId=${userId}';">방명록</div>
		</c:if>
		<c:if test="${menu!='menu6' }">
			<div align="center" class="unselected-Menu" onclick="javaScript:location.href='user_guest.action?menu=menu6&userId=${userId}';">방명록</div>
		</c:if>
	</c:if>
</body>
</html>