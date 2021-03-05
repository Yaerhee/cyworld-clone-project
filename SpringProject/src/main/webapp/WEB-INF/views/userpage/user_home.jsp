<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
%>
<!DOCTYPE html>
<html>
<head><link rel="stylesheet" href="${resourcePath }/img${userFontCss}"/>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
$(function(){
	$("#menuData").show();
	url = "<%=cp%>/cy/setting/userRightMenu.action";
	$.post(url,{menu:"${menu}",userId:"${userId}"},function(args){
		$("#rightMenu").html(args); 
	});  
});
</script>

<style type="text/css">
body
{
scrollbar-face-color: #000000;
 scrollbar-highlight-color: #DBDBDB;
 scrollbar-3dlight-color: #FFFFFF;
 scrollbar-shadow-color: #9C92FF;
 scrollbar-darkshadow-color: #FFFFFF;
 scrollbar-track-color: #FFFFFF;
 scrollbar-arrow-color: #9C92FF
 }
</style>

 </head>


<form name="main">

 <body topmargin="0" leftmargin="0" >
	<table border="0" align="left" valign="top" width="850" height="550" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<table border="0" align="left" width="800" height="510">
					<tr>
						<td colspan="2" align="center">
							<br>
							<font ><span style="font-size:8pt;">today <font color="red">${userDTO.getToDay() }</font>  total ${userDTO.getTotalDay() }</span></font>
						</td>
						<td  height="40">
						<center>
								<iframe frameborder="0" width="470" height="40" src="user_top_title.action?userId=${userId }"></iframe> 
							</center>
						</td>
						<td></td>
					</tr>
					<tr>
						<td width="10"> </td>

						<td width="178" height="450" background="${pageContext.request.contextPath}/resources/images/bg_left_rect.jpg">

							<!-- 왼쪽 내용 부분 ----------------------------------------------------------- -->
							<center>
								<iframe frameborder="0" width="160" height="440" src="user_left_intro.action?userId=${userId }"></iframe> 
							</center>
							<!-- ---------------------------------------------------------------------------- -->

						</td>
						<td width="480" height="450" background="${pageContext.request.contextPath}/resources/images/bg_center_rect.jpg">
										
							<center>
							<!-- 오른쪽 내용 부분 ----------------------------------------------------------- -->
							<iframe frameborder="0" width="470" height="430" src="user_r_home.action?userId=${userId }"></iframe> 
							<!-- ---------------------------------------------------------------------------- -->
							</center>
						</td>
						<!-- 오른쪽 메뉴 부분 이걸 for문 돌려서 메뉴 선택한거 다보여주게 하기 ---------------------------------------------- -->
							<td valign="top" style="padding-top: 20px;">
								<!-- Setting menu beginning -->
									<span id="rightMenu"></span>
								<!-- Setting menu ending -->	
							</td>
						<!-- 오른쪽 메뉴 부분 ----------------------------------------------------------- -->
					</tr>

					<tr>
						<td ></td>
					</tr>
				</table>
				<!-- ------------------------ -->
			</td>
		</tr>
	</table>
 </body>
</body>
</html>