package com.sbs.lyb.at.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.lyb.at.dao.ArticleDao;
import com.sbs.lyb.at.dto.Article;
import com.sbs.lyb.at.dto.ArticleReply;
import com.sbs.lyb.at.util.Util;


@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;
	
	public List<Article> getForPrintArticles() {
		return articleDao.getForPrintArticles();
	}

	public Article getForPrintArticleById(int id) {
		return articleDao.getForPrintArticleById(id);
	}

	public int write(Map<String, Object> param) {
		articleDao.write(param);
		return Util.getAsInt(param.get("id"));
	}

	public List<ArticleReply> getForPrintArticleReplies(int id) {
		return articleDao.getForPrintArticleReplies(id);
	}

	public int writeReply(Map<String, Object> param) {
		articleDao.writeReply(param);
		return Util.getAsInt(param.get("articleId"));
	}
}