package com.sbs.lyb.at.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.lyb.at.dto.Article;
import com.sbs.lyb.at.dto.ArticleReply;

@Mapper
public interface ArticleDao {
	List<Article> getForPrintArticles();

	Article getForPrintArticleById(int id);

	void write(Map<String, Object> param);

	List<ArticleReply> getForPrintArticleReplies(int id);

	void writeReply(Map<String, Object> param);
}
