<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 작성" />
<%@ include file="../part/head.jspf"%>

<script>
		var ArticleWriteForm__submitDone = false;
		function ArticleWriteForm__submit(form) {
			if ( ArticleWriteForm__submitDone ) {
				alert('처리중입니다.');
			}
			form.title.value = form.title.value.trim();
			if (form.title.value.length == 0) {
				form.title.focus();
				alert('제목을 입력해주세요.');
				return;
			}
			form.body.value = form.body.value.trim();
			if (form.body.value.length == 0) {
				alert('내용을 입력해주세요.');
				form.body.focus();
				return;
			}
			ArticleWriteForm__submitDone = true;
			var startUploadFiles = function(onSuccess) {
				if ( form.file__article__0__common__attachment__1.value.length == 0 && form.file__article__0__common__attachment__2.value.length == 0 ) {
					onSuccess();
					return;
				}
				var fileUploadFormData = new FormData(form); 
				
				fileUploadFormData.delete("title");
				fileUploadFormData.delete("body");
				$.ajax({
					url : './../file/doUploadAjax',
					data : fileUploadFormData,
					processData : false,
					contentType : false,
					dataType:"json",
					type : 'POST',
					success : onSuccess
				});
			}
			var startWrite = function(fileIdsStr, onSuccess) {
				$.ajax({
					url : './../article/doWriteAjax',
					data : {
						fileIdsStr: fileIdsStr,
						body: form.body.value,
						title: form.title.value
					},
					dataType:"json",
					type : 'POST',
					success : onSuccess
				});
			};
			startUploadFiles(function(data) {
				
				var idsStr = '';
				if ( data && data.body && data.body.fileIdsStr ) {
					idsStr = data.body.fileIdsStr;
				}
				startWrite(idsStr, function(data) {
					
					if ( data.msg ) {
						alert(data.msg);
					}
					
					form.body.value = '';
					form.file__article__0__common__attachment__1.value = '';
					form.file__article__0__common__attachment__2.value = '';
					ArticleWriteReplyForm__submitDone = false;
					location.href="/usr/article/list";
				});
			});
		}
</script>

<form class="form1" onsubmit="ArticleWriteForm__submit(this); return false;">
	<div class="table-box con">
		<table>
			<tbody>
				<tr>
					<th>제목</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="제목을 입력해주세요." name="title"
								maxlength="100" />
						</div>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<div class="form-control-box">
							<textarea maxlength="2000" name="body" placeholder="내용을 입력해주세요."></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>첨부1 비디오</th>
					<td>
						<div class="form-control-box">
							<input type="file" accept="video/*"
								name="file__article__0__common__attachment__1">
						</div>
					</td>
				</tr>
				<tr>
					<th>첨부2 비디오</th>
					<td>
						<div class="form-control-box">
							<input type="file" accept="video/*"
								name="file__article__0__common__attachment__2">
						</div>
					</td>
				</tr>
				<tr>
					<th>작성</th>
					<td><input type="submit" value="작성"></td>
				</tr>
			</tbody>
		</table>
	</div>
</form>
<%@ include file="../part/foot.jspf"%>