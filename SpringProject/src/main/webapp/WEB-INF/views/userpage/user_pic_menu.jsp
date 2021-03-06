<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript">

	
	
	function PicsOfThisMenu(folderName){
		
		var encodedFolderName=encodeURIComponent(folderName);
		
		var iframePic = document.getElementById("iframePic");
		iframePic.src="user/picture/my_r_pic_page.action?folderName="+encodedFolderName+"&userId=${userId}";
		
		 var url = "<%=cp%>/cy/user/picture/menuList.action";
		  var value=folderName;
		  var value2="${userId}";
		  
			  $.post(url,{folderName:value,userId:value2},function(args){
				  	$("#menuData").html(args); 
			  });
	}

	

</script>
<form name="main">
	<c:if test="${mode=='normalMode' }">
	<div style="border-top: 3px solid #EBEBEB;border-bottom: 3px solid #EBEBEB;width: 150px;height: 250px;word-break:break-all;overflow: auto;" align="left">
		<c:forEach var="dto" items="${list }" varStatus="status">
		<c:set var="index" value="${status.index }"/>
				<c:if test="${dto.folderName==folderName }">
				<div style="border: 0px solid black;float: left;width: 80%;">
					<img alt="no found" src="<%=cp%>/resources/images/folder_open.png" height="15px" width="15px">
					<font  style="font-size:10pt;font-weight: bold;">			
						<a href="javascript:PicsOfThisMenu('${dto.folderName }')" style="text-decoration: none;color: #1294AB;">
							${dto.folderName }
						</a>
					</font>
				</div>
				</c:if>
				
				<c:if test="${dto.folderName!=folderName }">
					<div style="border: 0px solid black;float: left;width: 80%;">
					<img alt="no found" src="<%=cp%>/resources/images/folder_closed.png" height="15px" width="15px">
					<font>
						<a href="javascript:PicsOfThisMenu('${dto.folderName }')" style="text-decoration: none;color: #1294AB;">
							${dto.folderName }
						</a>
					</font>
					</div>
				</c:if>
		</c:forEach>
		<input type="hidden" id="currentFolderName" value="${folderName=='?????? ??????'?'?????? ??????':folderName }"/>
	</div>
	</c:if>
</form>





