<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 상세내용" />
<%@ include file="../part/head.jspf"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	function Article__writeReply(form) {
		
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			form.body.focus();
			alert('내용을 입력해주세요.');
			return;
		}

		var $form = $(form);

		$form.find('input[type="submit"]').val('작성중..');
		$form.find('input[type="submit"]').prop('disabled', true);
		$form.find('input[type="reset"]').prop('disabled', true);
		
		$.post(
			'./doWriteReply',
			{
				articleId:articleId,
				body:form.body.value
			},
			function(data) {
				if ( data.resultCode.substr(0, 2) == 'F-' ) {
					alert(data.msg);
				}
				else {
					$form.find('input[type="submit"]').val('작성');
					$form.find('input[type="submit"]').prop('disabled', false);
					$form.find('input[type="reset"]').prop('disabled', false);
				}
			}, 
			'json'
		);
		form.body.value = '';
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

		var body = $tr.find(' > .reply-body-td > .modify-mode-invisible').html().trim();
		
		$tr.find(' > .reply-body-td > .modify-mode-visible > form > textarea').val(body);
		
		$tr.attr('data-modify-mode', 'Y')
		$tr.siblings('[data-modify-mode="Y"]').attr('data-modify-mode', 'N');
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
<div class="reply-write con">
	<form action="./doWriteReply" method="POST" onsubmit="Article__writeReply(this);">
		<input type="hidden" name="redirectUrl" value="/article/detail?id=#id">
		<input type="hidden" name="articleId" value="${article.id}">
		<table>
			<tbody>
				<tr>
					<th>내용</th>
					<td>
						<textarea placeholder="내용을 입력해주세요." name="body" maxlength="300"></textarea>
					</td>
				</tr>
				<tr>
					<th>작성</th>
					<td>
						<input type="submit" value="작성" />
						<input type="reset" value="취소" />
					</td>
				</tr>
			</tbody>
		</table>
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
								<textarea maxlength="300" name="body"></textarea>
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