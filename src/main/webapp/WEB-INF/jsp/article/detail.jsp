<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 상세내용" />
<%@ include file="../part/head.jspf"%>
<div class="page-title-box">
	<h1 class="main-title con">${pageTitle}</h1>
</div>
<div class="table-box con">
	<table>
		<tbody>
			<tr>
				<th>번호</th>
				<td>${article.id}</td>
			</tr>
			<tr>
				<th>날짜</th>
				<td>${article.regDate}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${article.title}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${article.body}</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="con"><a href="list?page=1">[리스트로 돌아가기]</a>/<a href="modify?id=${article.id}">[수정하기]</a>/<a href="doDelete?id=${article.id}">[삭제하기]</a></div>

<%@ include file="../part/foot.jspf"%>