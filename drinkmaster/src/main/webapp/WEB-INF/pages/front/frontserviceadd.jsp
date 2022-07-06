<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="layout/header.jsp" />
<title>意見回饋</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<style>
/*                背景滿版     */
                    html { 
            			height: 100%; 
     					} 
                    body {
                        background-image: url("<c:url value="/images/cold_drink_juice_promotion_image.jpg"/>");
                        background-repeat: no-repeat;
                        background-attachment:fixed;
                        background-position: 50% 40%;
                        background-size: 100% 120%;
                    }
/*                背景滿版    */



</style>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<div class="container">
<div class="row justify-content-center">
<div class="col-6">
 <h1>新增意見回饋</h1>
<form:form class="form" method="post" action="${contextRoot}/front/service/post" modelAttribute="workMessages">
<div class="form-group">
     <label for="exampleFormControlInput1">會員編號 :</label>
     
       <form:input  path="userBean" class="form-control"  value="${canSeeUser.userId}"  readonly="true"/>
           
<%--     <c:out value="${latestMsg.userBean.userId}"  /> --%>
 
    <br/>
    <label for="exampleFormControlInput1">姓   名 :</label>
       <form:input path="userBean" class="form-control"  value="${canSeeUser.userName}"  readonly="true"/>
<%--     <c:out value="${latestMsg.userBean.userName}" /> --%>


   </div>
  
  <br/>
  
  <div class="form-group">
    <label for="exampleFormControlTextarea1">意見回饋 :</label>
    <br/>
    <form:textarea path="answer" class="form-control"/>
     </div>
     <br/>
     <div class="form-group">
    
     <input type="button" name="submit" class="btn btn-success" value="送出" id="send">
    
 </div>
</form:form>
</div>
</div>

<br/>
<br/><br/><br/><br/><br/><br/>
</div>

<script type="text/javascript">

$(function(){
	
	$("#send").click(function(){
		Swal.fire({
			  icon:'success',
			  title:'意見回饋已送出',
			  showConfirmButton: false,
			  timer: 3000
			}).then((result) => {
					location.replace('http://localhost:8081/drinkmaster/front/service/add')
			}
			);
}
)});

</script>
<jsp:include page="layout/footer.jsp" />


