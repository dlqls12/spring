<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>
<div class="page-title-box">
	<h1 class="main-title con">${pageTitle}</h1>
</div>
<div class="con">
	<ul>
		<li><a href="../article/add">게시물 작성</a></li>
		<li><a href="../article/list?page=1">게시물 리스트</a></li>
	</ul>
</div>
<%@ include file="../part/foot.jspf"%>