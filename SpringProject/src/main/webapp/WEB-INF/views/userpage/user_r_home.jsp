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



	<style type="text/css">

ul{
    display: inline-block;
    vertical-align: middle;
    padding: 0px 0px 0px 30px;
	font-size : 9pt;

}

body
	{scrollbar-face-color: #FFFFFF;
	 scrollbar-highlight-color: #DBDBDB;
	 scrollbar-3dlight-color: #FFFFFF;
	 scrollbar-shadow-color: #9C92FF;
	 scrollbar-darkshadow-color: #FFFFFF;
	 scrollbar-track-color: #FFFFFF;
	 scrollbar-arrow-color: #9C92FF}
	 
 a{ 
 color: black; text-decoration: none;
 }
 
	</style>
 </head>
<script type="text/javascript" src="/cyworld/resources/js/ajaxUtil2.js"></script>
<script src="//apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript">
 
 $(document).ready(function(){
	    initSet();
	});
 
 function initSet(){
	 	var params = "userId=${userId}";
		sendRequest("user_get_MemberBoard.action",params,displayInfo,"GET");
}
 
 function sendMemberBoard(){
	 var str = document.getElementById("content").value;
	 str = str.replace(/(<([^>]+)>)/gi, "");
	 var params = "userId=${userId}&memberId=${session.getUserId()}&content="+str;
	 var url = "user_get_MemberBoard_send.action?"+params;
	 url = encodeURI(url);
	 sendRequest(url,null,displayInfo,"GET");
 }
 

 function displayInfo(){
 	if(httpRequest.readyState==4){
 		if(httpRequest.status==200){
 			str_i = httpRequest.responseText;
 			var memberBoard = document.getElementById("memberBoard");
 			memberBoard.innerHTML = str_i;	
 			document.getElementById("content").value = "";
 		}
 	}
 }
 
 function deleteComment(userId){
	 var params = "userId="+userId;
	 sendRequest("user_get_MemberBoard_delete.action",params,displayInfo,"GET");
 }
  
 function moveToUser(userId){
	 window.open("user_main.action?userId="+userId,userId,"width=1090,height=600,location=no,status=no,scrollbars=no");
 }
 
 </script>

 <body leftmargin="5" topmargin="0")">
<form action="" method="post" name="myForm">
	<table bgcolor="#DBDBDB" width="440" cellpadding="1" cellspacing="1">
		<tr bgcolor="#FFFFFF" >
			<td colspan="2"><font class="updateBoard"><b>Update Board...</b></font></td>
		</tr>
		<tr bgcolor="#FFFFFF" style="font-size:9pt;">
			<td width="240"> 
				<c:if test="${size ne 0 }">
				<c:forEach var="i" begin="0" end="${list.size()-1 }" step="1">
				<img alt="" src="${pageContext.request.contextPath}/resources/images/${list.get(i).getType() }Title.png" width="30px" height="12px">${list.get(i).getSubject() }<br/>
				</c:forEach>
				<c:forEach var="i" begin="0" end="${5-list.size() }" step="1">
				<br/>
				</c:forEach>
				</c:if>
				<c:if test="${size eq 0}">
				<span style="text-align: center;"><br/>????????? ???????????? ????????????<br/>????????? ?????? ???????????? ????????? ????????????<br/>???????????????.<br/><br/><br/></span>
				</c:if>
			</td>
			<td valign="center">  
				
				<table bgcolor="#FFFFFF" width="200" align="center" cellpadding="2" cellspacing="0">
					<c:if test="${length ne 0 }">
						<%int a = 0; %>
						<tr bgcolor="#FFFFFF" align="left">
						<c:forEach var="i" begin="0" end="${length-1 }" step="1">
						<%a++; %>																			
								<td><font style="font-size:9pt;"><a href="${array[i][1] }">${array[i][0] }</a></font> <font color="#2d384a"style="font-size:8pt;">${array[i][2] }/${array[i][3] }</font><c:if test="${array[i][2] ne '0' }"><img alt="" src="${pageContext.request.contextPath}/resources/images/new.png"></c:if></td>
						<%if(a==2){ %>
						<tr/>
						<%} %>
						</c:forEach>
					</c:if>
				</table>

			</td>
		</tr>
	</table>

	<br/>

	<img src="${pageContext.request.contextPath}/resources/images/bar.jpg" width="440" height="6" border="0" alt="??????">

	<table bgcolor="#DBDBDB" width="440" cellpadding="1" cellspacing="1">
		<tr bgcolor="#FFFFFF" >
			<td align="center"  colspan="2">  
				<font><b>?????? ???????????? ??????????????? ???????????????.</b></font>	
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td align="center" colspan="2">  
				<img src="${resourcePath }/img${useStoryRoom}" width="389" height="192" border="0" alt="${resourcePath }/img${useStoryRoom}">
				<img src="${resourcePath }/img${useMinimi.getOriginalFileName() }" alt="${resourcePath }/img${useMinimi}" style="position: absolute; top :${useMinimi.getImgY() }; left : ${useMinimi.getImgX() };"/>
			</td>
		</tr>
	</table><br/>
		<font color="#8be0ff" size="3pt"><b>?????????</b></font>
		<c:if test="${check ne 0 }">
		<input type="text" name="content" id="content" style="width: 70%;"><input type="button" value="??????" onclick="sendMemberBoard();"/>
		</c:if>
		<hr noshade size="1px" color="#e6e6e6"/>
		<span id="memberBoard"></span>
	</form>
 </body>
</html>