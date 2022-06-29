<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="layout/header.jsp" />
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>

<link href="${contextRoot}/css/lib/font-awesome.min.css" rel="stylesheet" type="text/css" media="all">
<link href="${contextRoot}/css/lib/awesomeRating.min.css" rel="stylesheet" type="text/css" media="all">
<link href="${contextRoot}/font/fontawesome-webfont.ttf" rel="stylesheet" type="text/css" media="all">
<link href="${contextRoot}/font/fontawesome-webfont.woff" rel="stylesheet" type="text/css" media="all">
<link href="${contextRoot}/font/fontawesome-webfont.woff2" rel="stylesheet" type="text/css" media="all">

<script src="${contextRoot}/js/lib/awesomeRating.min.js"></script>

<style>

div.awesomeRating {
	font-size: 2em;
}

#dropdownMenuButton1{
	background-color: white;
	border: 1px solid gray;
	float:right;
}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>




<div class="container">


<div class="row justify-content-center">
<div class="col-9">
<h1 style="text-align:center">評論區</h1>
<div class="card">
 
  <div class="card-body">
  
  
  	<c:if test="${empty userBean}">
  	
  	<br/>
  				<h3>登入後可評論~</h3>
  	
  	
 	</c:if>
  
 	 <br/>
 	 
	<c:if test="${not empty userBean}">
	
 <c:choose>
  	
  	<c:when test="${not empty findusId}">
  	

    <c:forEach  var="usercomment" items="${findusId}" >
  		
  		<div class="row justify-content-center">
<div class="col-9">

<div class="card">

<span style="font-size: 1.5em">你的評論</span>
  <div class="card-header">
		<c:out value="${usercomment.storeBean.storeName}"></c:out>
  </div>
  <div class="card-body">
  	<c:out value="${usercomment.userBean.userName}"></c:out>
<%--   	<c:out value="${usercomment.userBean.userId}"></c:out> --%>
  	<br/>
  	
  	
  	
  	<div style="pointer-events: none" id="scores${usercomment.commentId}" class="awesomeRating"></div>
	<div class="awesomeRatingValue"></div>
	<script type="text/javascript">
	
		$("#scores${usercomment.commentId}").awesomeRating({
			
			valueInitial: "${usercomment.score}",
			values: ["1.0", "2.0", "3.0", "4.0", "5.0"],
			targetSelector: "span.awesomeRatingValue"
		});
	
		console.log(${usercomment.score});
	</script>
	
	<c:out value="${usercomment.content}"></c:out>
	
	<br/>
	
	<img src="${usercomment.commentPhoto}" style="width: 100px;heiget: 100px" />

	<br/>
	(時間) <fmt:formatDate pattern="yyyy 年 MM 月 dd 日 a hh:mm:ss EEEE" value="${usercomment.createTime}" />
  		
  		
  		
<%--   		<c:out value="${usercomment.userBean.userName}" /> --%>
  		
  		  </div>
</div>
</div>
</div>
  		
  		</c:forEach>

    
    
    </c:when>
  	
  	<c:otherwise>
  	


<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal0" data-bs-whatever="@mdo">撰寫評論</button>

<div class="modal fade" id="exampleModal0" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">新增評論</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form:form class="form" method="post" action="${contextRoot}/front/comment/insert" modelAttribute="commentBean" enctype="multipart/form-data">
          <div class="form-group">
<!-- 	userid -->
		<input id=userid name="userid" value="${userBean.userId}" type="hidden" />
<!-- 	storeid -->
	<form:input path="storeBean" class="form-control" type="hidden" />
<%-- 	productid<form:input path="productBean" class="form-control" /> --%>
<!-- 	score -->
	<form:input id="score1" path="score" class="form-control" style="pointer-events: none" type="hidden"/>
	
	<div id="scores" class="awesomeRating"></div>
	<input class="awesomeRatingValue" style="display:none" required></input>
	<script type="text/javascript">
	
		$("#scores").click(function(){
			
			var test = $(".awesomeRatingValue").val();
			console.log(test);
			$("#score1").attr("value",test);
			
		});
		
	
		$(".awesomeRating").awesomeRating({
			
			valueInitial: "",
			values: ["1.0", "2.0", "3.0", "4.0", "5.0"],
			targetSelector: "input.awesomeRatingValue"
			
		});
	
		
	</script>
	
	
	<form:input path="scoreType" class="form-control" type="hidden"/>
	content<form:textarea path="content" class="form-control" />
	
	<br/>
	
	<input id="commentPhoto1" name="commentPhoto1"  type="file" class="form-control" onchange="preview()" />

		<img id="image" src="" width="100px" height="100px" />
	<c:if test="${comment.commentId!=null}">
					<img id="oldImage" src="${comment.commentPhoto}" width="100px"
						height="100px" />
	</c:if>
	
	
</div>

<!-- 			<button type="submit" name="submit" class="btn btn-primary">新增評論</button> -->
        
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="submit" name="submit" class="btn btn-primary">新增評論</button>
      </div>
      </form:form>
      </div>
    </div>
  </div>
</div>
  		
  	</c:otherwise>
  	
  	</c:choose>
  	
  	    </c:if>
  

  
	<script type="text/javascript">
	
	$(function() {
		$('#image').hide();
	});

	function preview() {
		image.src = URL.createObjectURL(event.target.files[0]);
		if ((event.target.files[0].type).startsWith("image")) {
			$('#oldImage').hide();
			$('#image').show();
		}
	}
	
	</script>
  
  </div>
</div>
</div>
</div>


<br/>

<div class="row justify-content-center">
	<div class="col-9">

<div class="dropdown" style="text-align:right">
  <button class="btn btn-black dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
    排序
  </button>
  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
    <li><a class="dropdown-item" href="${contextRoot}/front/comment/all">最新</a></li>
    <li><a class="dropdown-item" href="${contextRoot}/front/comment/scoredesc">評分最高</a></li>
    <li><a class="dropdown-item" href="${contextRoot}/front/comment/scoreasc">評分最低</a></li>
    <li><a class="dropdown-item" href="${contextRoot}/front/comment/timeasc">最早</a></li>
  </ul>
</div>

</div>
</div>

<br/>
<c:forEach  var="comment" items="${page.content}" >
<%-- <c:forEach  var="comment" items="${page.content}" > --%>

<div class="row justify-content-center">
<div class="col-9">

<div class="card">
  <div class="card-header">
		<c:out value="${comment.storeBean.storeName}"></c:out>
  </div>
  <div class="card-body">
  	<c:out value="${comment.userBean.userName}"></c:out>
  	<br/>
  	
  	
  	
  	<div style="pointer-events: none" id="scores2${comment.commentId}" class="awesomeRating"></div>
	<input class="awesomeRatingValue" style="display:none" required></input>
	<script type="text/javascript">
	
		$("#scores2${comment.commentId}").awesomeRating({
			
			valueInitial: "${comment.score}",
			values: ["1.0", "2.0", "3.0", "4.0", "5.0"],
			targetSelector: "input.awesomeRatingValue"
		});
	
		console.log(${comment.score});
	</script>
	
	<c:out value="${comment.content}"></c:out>
	
	<br/>
	
	<img src="${comment.commentPhoto}" style="width: 100px;heiget: 100px" />

	<br/>
	(時間) <fmt:formatDate pattern="yyyy 年 MM 月 dd 日 a hh:mm:ss EEEE" value="${comment.createTime}" />
	
	
  
  </div>
</div>
</div>
</div>

</c:forEach>

<div class="row justify-content-center">
	<div class="col-9">
		<c:forEach var="pageNumber" begin="1" end="${page.totalPages}">
		
		<c:choose>
			<c:when test="${page.number != pageNumber-1}" >
			
				<a href="${contextRoot}/front/comment/all/?p=${pageNumber}" > <c:out value="${pageNumber}" /></a>
			
			</c:when>
		
			<c:otherwise>
				<c:out value="${pageNumber}" />
			</c:otherwise>	
		
		</c:choose>
		
		<c:if test="${page.totalPages != pageNumber}">
			|
		</c:if>
			
		
		</c:forEach>

	</div>
</div>



<!-- <div class="row justify-content-center"> -->
<!-- <div class="col-9"> -->

<!-- <div class="card"> -->
<!--   <div class="card-header"> -->
<%--     最新留言(時間) <fmt:formatDate pattern="yyyy 年 MM 月 dd 日 a hh:mm:ss EEEE" value="${lastestComment.createTime}" /> --%>
<!--   </div> -->
<!--   <div class="card-body"> -->
  
<%-- 	<c:out value="${lastestComment.content}"></c:out> --%>
  
<!--   </div> -->
<!-- </div> -->
<!-- </div> -->
<!-- </div> -->


</div>


<jsp:include page="layout/footer.jsp" />



</body>
</html>