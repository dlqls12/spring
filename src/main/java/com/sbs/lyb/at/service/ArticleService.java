package com.sbs.lyb.at.service;

import java.util.List;
import java.util.Map;

import com.sbs.lyb.at.dto.Article;

public interface ArticleService {
	public List<Article> getForPrintArticles();

	public long add(Map<String, Object> param);

	public Article getForPrintArticleById(int id);

	public void delete(int id);

	public void modify(Map<String, Object> param);

	public List<Article> getArticles(int limitFrom);
}
