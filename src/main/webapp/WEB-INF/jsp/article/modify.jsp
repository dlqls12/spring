<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 작성" />
<%@ include file="../part/head.jspf"%>

<script>
	function ArticleModifyForm__submit(form) {
		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			form.title.focus();
			alert('제목을 입력해주세요.');
			return;
		}
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			form.body.focus();
			alert('내용을 입력해주세요.');
			return;
		}
		form.submit();
	}
</script>
<form method="POST" class="form1" action="doModify" onsubmit="ArticleModifyForm__submit(this); return false;">
	<input type="hidden" name="id" value=${article.id}>
	<div class="table-box con">
		<table>
			<tbody>
				<tr>
					<th>제목</th>
					<td>
						<div class="form-control-box">
							<input type="text" name="title" value=${article.title}
								maxlength="100" />
						</div>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<div class="form-control-box">
							<textarea name="body" maxlength="2000">${article.body}</textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>수정</th>
					<td>
						<button class="btn btn-primary" type="submit">수정</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</form>

<%@ include file="../part/foot.jspf"%>