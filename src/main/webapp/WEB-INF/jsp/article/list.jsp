<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 리스트" />
<%@ include file="../part/head.jspf"%>
<div class="page-title-box">
	<h1 class="main-title con">${pageTitle}</h1>
</div>

<div class="table-box con">
	<table>
		<colgroup>
			<col width="100" />
			<col width="200" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>제목</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${articles}" var="article">
				<tr>
					<td>${article.id}</td>
					<td>${article.regDate}</td>
					<td><a href="detail?id=${article.id}">${article.title}</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<div class="paging con">
	<c:forEach var="cnt" begin="1" end="${paging}">
		<div class="${cnt==page ? "current" : "" }">
			<a href="?page=${cnt}">${cnt}</a>
		</div>
	</c:forEach>
</div>

<%@ include file="../part/foot.jspf"%>