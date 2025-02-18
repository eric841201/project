<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<jsp:include page="layout/header.jsp"></jsp:include>


<style>
.shape-ex6{
    width: 200px;
    height: 200px;
    max-width:  100%;
    
    display: block;
    position: relative;
    font-size: 0;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -10%);
    
    border-radius:50%;
    border: 2px solid;
    overflow:hidden;
}
.shape-ex6-block{
    width: 100%; 
    height: 100%;
    position: absolute;
    text-align: center;
    overflow:hidden;
    
    margin: 0 auto;
}
.shape-ex6-block:before{
    content: ''; 
    display: inline-block;
    height: 100%;
    width: 0;
    vertical-align: middle;
    overflow:hidden;
}
.shape-ex6-img{
    max-width: 100%; 
    max-height: 100%;
    width: auto;
    height: auto;
    display: inline-block;
    vertical-align: middle;
    overflow:hidden;
}
.py-555 {
  padding-top: 10px !important;
  padding-bottom: 10px !important;
}
span{
	color: #ae0000;
}
</style>

<header class="bg-dark py-555" style="padding-bottom: 5px">
	<div class="container px-4 px-lg-5 my-5">
		<div class="text-center text-white">
			<div class="shape-ex6">
			<div class="shape-ex6-block">
				<img class="shape-ex6-img" src="data:image/jpg;base64,<c:out value='${canSeeUser.byteArrayString}'/>"
					onerror="nofind()"/>
			</div>
			</div>
			<h1 class="display-4 fw-bolder">${canSeeUser.userName}</h1>
			<p class="lead fw-normal text-white-50 mb-0">${canSeeUser.userAccount}</p>
		</div>
	</div>
</header>
<body>

    <table class="table table-striped" style="width: 70%; transform: translate(25%, 0%);
    margin-top: 15px; border: 1px solid gray;">
        <tbody>
          <tr>
            <td hidden="${canSeeUser.userId}" id="${canSeeUser.userId}"></td>
          </tr>
          <tr>
            <td scope="row">姓名</td>
            <td>${canSeeUser.userName}</td>
          </tr>
            <tr>
            <td scope="row">電子信箱</td>
            <td>${canSeeUser.userAccount}</td>
          </tr>
            <tr>
            <td scope="row">密碼</td>
            <td>*******</td>
          </tr>
          <tr>
            <td scope="row">地址</td>
            <td>${canSeeUser.userAddress}</td>
          </tr>
          <tr>
            <td scope="row">連絡電話</td>
            <td>${canSeeUser.phone}</td>
          </tr>
          <tr>
            <td scope="row">性別</td>
            <td>${canSeeUser.gender}</td>
          </tr>
          <tr>
            <td scope="row">權限</td>
            <td>${canSeeUser.role}</td>
          </tr>
          <tr>
            <td scope="row">生日</td>
            <td>
            	<fmt:formatDate value="${canSeeUser.birthday}" var="ubd" type="both" pattern="yyyy年MM月dd日" /> ${ubd}
            </td>
          </tr>
          <tr>
            <td scope="row">創建日期</td>
            <td>
                <fmt:formatDate value="${canSeeUser.createdate}" var="ucd" type="both" pattern="yyyy年MM月dd日 hh:mm:ss" /> ${ucd}
            </td>
          </tr>
          <tr>
          	<td colspan="2" style="text-align: center;">
<%--           	<a href="${contextRoot}/front/userUpdate"> --%>
<!-- 				<button type="button" class="btn btn-light">修改</button> -->
<!-- 			</a> -->
			<div style="margin: 5px"><c:url value="/front/userUpdate/${canSeeUser.userId}" var="update_url" />
				<a href="${update_url}">
					<button type="button" class="btn btn-light">編輯</button>
				</a></div>
          	</td>
          </tr>
        </tbody>
      </table>
	
	
	
	
	
</body>

<script type="text/javascript">
function nofind(){
  var img=event.srcElement;
  img.src="http://localhost:8081/drinkmaster/images/user.png"; //替換的圖片
  img.onerror=null; //控制不要一直觸發錯誤
}
</script>


<jsp:include page="layout/footer.jsp"></jsp:include>