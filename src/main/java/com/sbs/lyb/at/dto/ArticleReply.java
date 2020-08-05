package com.sbs.lyb.at.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ArticleReply {
	private int id;
	private String regDate;
	private String updateDate;
	private int articleId;
	private String body;
}
