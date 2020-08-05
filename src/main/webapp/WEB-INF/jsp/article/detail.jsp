<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 상세내용" />
<%@ include file="../part/head.jspf"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	function ReplyWriteForm__submit(form) {
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			form.body.focus();
			alert('내용을 입력해주세요.');
			return;
		}
		form.submit();
	}

	function Article__deleteReply(el, id) {
		if ( confirm(id + '번 댓글을 삭제하시겠습니까?') == false ) {
			return;
		}

		var $tr = $(el).closest('tr');
		$tr.remove();
	}

	function Article__turnOnModifyMode(el) {
		var $tr = $(el).closest('tr');

		$tr.attr('data-modify-mode', 'Y')
	}

	function Article__turnOffModifyMode(el) {
		var $tr = $(el).closest('tr');

		$tr.attr('data-modify-mode', 'N')
	}

	function Article__modifyReply(form) {
		form.body.value = form.body.value.trim();

		if ( form.body.value.length == 0) {
			form.body.focus();

			alert('내용을 입력해주세요.');
			return;
		}
		var $tr = $(form).closest('tr');
		$tr.attr('data-modify-mode', 'N');

		var newBody = form.body.value;
		var id = form.id.value;

		$tr.find(' > .reply-body-td > .modify-mode-invisible').empty().append('변경중..');

		$.post('./doModifyReply', {
			id:id,
			body: newBody
		}, function(data) {
			if ( data.resultCode.substr(0, 2) == 'S-' ) {
				$tr.find(' > .reply-body-td > .modify-mode-invisible').empty().append(newBody);
			}
			else {
				alert(data.message);
			}
		}, 'json');
	}
</script>

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
<div class="con">
	<h2>댓글 작성하기</h2>
</div>
<div class="con">
	<form method="POST" class="form1" action="doWriteReply" onsubmit="ReplyWriteForm__submit(this); return false;">
		<div class="table-box con">
			<table>
				<tbody>
					<tr>
						<th>내용</th>
						<td>
							<div class="form-control-box">
								<textarea placeholder="내용을 입력해주세요." name="body" maxlength="2000"></textarea>
							</div>
						</td>
					</tr>
					<tr>
						<th>작성</th>
						<td>
							<button class="btn btn-primary" type="submit">작성</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
</div>

<div class="con">
	<h2>댓글 리스트</h2>
</div>
<div class="table-box con reply-list-box">
	<table>
		<colgroup>
			<col width="100" />
			<col width="200" />
			<col />
			<col width="130" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>내용</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${replies}" var="reply">
				<tr data-modify-mode="N">
					<td>${reply.id}</td>
					<td>${reply.regDate}</td>
					<td class="reply-body-td">
						<div class="modify-mode-invisible">
							${reply.body}
						</div>
						<div class="modify-mode-visible">
							<form action="" onsubmit="Article__modifyReply(this); return false;">
								<input type="hidden" name="id" value="${reply.id}">
								<textarea maxlength="300" name="body">${reply.body}</textarea>
								<input type="submit" value="수정완료">
							</form>
						</div>
					</td>
					<td>
						<a href="javascript:;" onclick="Article__deleteReply(this, ${reply.id})">삭제</a>
						<a class="modify-mode-invisible" href="javascript:;" onclick="Article__turnOnModifyMode(this);">수정</a>
						<a class="modify-mode-visible" href="javascript:;" onclick="Article__turnOffModifyMode(this);">수정취소</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<%@ include file="../part/foot.jspf"%>