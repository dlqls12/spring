<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 추가" />
<%@ include file="../part/head.jspf"%>
<script>
	function submitAddForm(form) {
		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			alert('제목을 입력해주세요.');
			form.title.focus();

			return false;
		}

		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();

			return false;
		}

		form.submit();
	}
</script>
<div class="page-title-box">
	<h1 class="main-title con">${pageTitle}</h1>
</div>
<form class="con write-form" action="./doAdd" method="POST" onsubmit="submitAddForm(this); return false;">
	<div class="form-row">
		<label> 제목 </label>
		<div>
			<input name="title" type="text" placeholder="제목을 입력해주세요." autofocus="autofocus">
		</div>
	</div>

	<div class="form-row">
		<label> 내용 </label>
		<div>
			<textarea name="body" placeholder="내용을 입력해주세요."></textarea>
		</div>
	</div>

	<div class="form-row">
		<label> 작성 </label>
		<div>
			<input type="submit" value="작성"> <input type="reset" value="취소" onclick="history.back();">
		</div>
	</div>
</form>

<%@ include file="../part/foot.jspf"%>