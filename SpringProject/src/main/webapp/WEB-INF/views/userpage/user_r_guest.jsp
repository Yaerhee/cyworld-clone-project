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

ul li {
	list-style-type: none;
}

ul {
	-webkit-padding-start:0px;
}

span {
	text-align: left;
}

</style>

</head>

<script type="text/javascript" src="/cyworld/resources/js/ajaxUtil2.js"></script>
<script src="//apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
    initSet();
});

function send(){
	var str = document.myForm.content.value;
	str = str.trim();
	if(str==""){
		return;
	}
	document.myForm.action = "user_guest_write.action";
	document.myForm.submit();
}

function initSet(){
	var str = document.getElementById('num0').value;
	var params = "num0="+str;
	
	if('${length}'>=2){
		str = document.getElementById('num1').value;
		params += "&num1="+str;
	}
	
	if('${length}'>=3){
		
		str = document.getElementById('num2').value;
		params += "&num2="+str;
	}
	params+= "&length="+${length};
	sendRequest("user_get_guestbook.action",params,displayInfo,"GET");
}


function displayInfo(){
	if(httpRequest.readyState==4){
		if(httpRequest.status==200){
			str_i = httpRequest.responseText;
			var strArray = str_i.split('==__');
			var span0 = document.getElementById("span0");
			var span1 = document.getElementById("span1");
			var span2 = document.getElementById("span2");
			span0.innerHTML = strArray[0].replace(/<br\/>/ig, "\n");
			span1.innerHTML = strArray[1].replace(/<br\/>/ig, "\n");
			span2.innerHTML = strArray[2].replace(/<br\/>/ig, "\n");
		}
	}
}

function deleteComment(num){
	 var params = "num="+num;
	 sendRequest("user_get_guestBoard_delete.action",params,initSet,"GET");
}
 
function moveToUser(userId){
	 window.open("user_main.action?userId="+userId,userId,"width=1090,height=600,location=no,status=no,scrollbars=no");
}

function comment(num){
	var str;
	var num;
	if(num == 0 ){
		str = document.getElementById('comment0').value;
		num = document.getElementById('num0').value;
	}else if(num == 1){
		str = document.getElementById('comment1').value;
		num = document.getElementById('num1').value;
	}else if(num == 2){
		str = document.getElementById('comment2').value;
		num = document.getElementById('num2').value;
	}
	str = str.trim();
	if(str==""){
		alert("?????? ?????? ????????????");
		return;
	}
	str = str.replace(/(<([^>]+)>)/gi, "");
	str = str.replace(/\n/gi, "<br/>");
	var url = "user_guestBook_wirte.action?num="+num+"&comment="+str;
	url = encodeURI(url);
	document.myForm.action = url;
	document.myForm.submit();
}

function secret(num){
	document.myForm.action = "user_guestBook_secret.action?num="+num;
	document.myForm.submit();
}


</script>


 <body>

<form name="myForm" method="post" action="">

	<!-- ???, ????????? -------------------------------------------------------------------------------- -->
 	<table width="410" border="0" cellpadding="3" cellspacing="1" bgcolor="#DBDBDB" align="center">
		<tr bgcolor="#FFFFFF">
			<td align="center"> 
				<font>
					????????? ???????????? ???????????? ????????? ?????????...
				</font>
			</td>
		</tr>
	</table>
	<br/>

	<!-- Session?????? ?????? ????????? ????????????????????? ?????????????????? -->
	<center><img src="${pageContext.request.contextPath}/resources/images/bar.jpg" width="430" height="6" border="0" alt=""></center>
	<c:if test="${member eq 1 }">
	<table width="410" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#e6e6e6">
		<tr>
			<td bgcolor="#e6e6e6">  
				<img src="${resourcePath }/img/${minimi }" width="98" height="98" border="0" alt="???????????? ??????????????????">
			</td>
			<td align="center" bgcolor="#e6e6e6">  
				<textarea name="content" rows="7" cols="40" style="width: 280px; height: 80px;resize: none;"></textarea>
				<input type="hidden" name="userId" value="${userId }"/>
			</td >
		</tr>
	</table>
	<table border="0" width="410" cellpadding="0" cellspacing="0" align="center" bgcolor="#e6e6e6">
		<tr>
			<td style="">
				<input type="checkbox" name="secret" value="1"/>????????? ??????
			</td>
			<td width="200" align="right" bgcolor="#e6e6e6">  
				<input type="button" name="write_guest" value="??????" onclick="send();">
			</td>
		</tr>
	</table>
	<center><img src="${pageContext.request.contextPath}/resources/images/bar.jpg" width="430" height="6" border="0" alt=""></center>
	</c:if>
	<!-------- -------------------------------------------------------------------------------- -->

	<!-- c:Foreach ????????? ------------------------------------------------------------ -->
	<c:if test="${length eq 0 }">
		<br/><center>
		????????? ?????? ????????????.<br/><br/>
		??????????????? ????????? ??????????????? ??? ?????????????</center>
	</c:if>
	<c:if test="${length ne 0 }">
	<%int i = 0; %>
	<c:forEach var="i" begin="0" end="${list.size()-1 }" step="1">
	<c:if test="${list.get(i).secret eq 1 }">
	<table border="0" bgcolor="#ffeed2" width="430" cellpadding="1" cellspacing="1" align="center">
	</c:if>
	<c:if test="${list.get(i).secret eq 0 }">
	<table border="0" bgcolor="#f1f1f1" width="430" cellpadding="1" cellspacing="1" align="center">
	</c:if>
		<tr>
			<td><font>NO.${list.get(i).listNum }</font>
			<a href="" onclick="moveToUser('${list.get(i).memberId }');"><font  style="font-size:9pt; color: #113377; ">${list.get(i).memberName }</font> <img src="${resourcePath }/img/admin/pic/house.jpg"/></a>			
			<font style="font-size:8pt;">(${list.get(i).created })</font></td>
			<td align="right">
			<c:if test="${session.getUserId() eq list.get(i).memberId }">
			<font style="font-size:9pt;"><c:if test="${list.get(i).secret eq 0 }"><a href="javascript:void(0);" onclick="secret('${list.get(i).num }');">????????? ??????</a> | </c:if> <a href="user_guest_delete.action?num=${list.get(i).num }&userId=${userId}" >??????</a></font>
			</c:if>
			</td>			
		</tr>
	</table>

	<table border="0" width="410" align="center">
		<tr>
			<td width="100">  
				<img src="${resourcePath }/img/${minimiArray[i] }" width="98" height="98" border="0" alt="${resourcePath }/img/${minimiArray[i] }">
			</td>
			<td width="330"> 
			<c:if test="${list.get(i).secret eq 1 }">
			<img src="${resourcePath }/img/admin/pic/secret.jpg" alt="????????? ?????????"/><br/>
			</c:if>			
				<font>
					${list.get(i).content }
				</font>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center" bgcolor="#fffbff">
				<span id="span<%=i %>" style="text-align: left;" align="left"></span><br/>
				<input type="hidden" id="num<%=i %>" value="${list.get(i).num }">
				<c:if test="${member eq 1 }">
				<textarea id="comment<%=i %>" rows="2" cols="47" style="resize:none; width: 80%;"></textarea>
				<input type="button" name="comment_save" value="??????" onclick="comment('<%=i%>');">
				</c:if>
			</td>
		</tr>
	</table>	
	<br/><br/>
	<%i++; %>
	</c:forEach>
	<!-- ---------- ------------------------------------------------------------ -->
	<div align="center">
	${pageIndexList }
	</div>
	</c:if>	
	<input type="hidden" name="currentPage" value="${currentPage }"/>
	<input type="hidden" id="userId" value="${userId }"/>
</form>
 </body>
</html>