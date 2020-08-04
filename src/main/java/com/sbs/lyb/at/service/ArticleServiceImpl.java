package com.sbs.lyb.at.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.lyb.at.dao.ArticleDao;
import com.sbs.lyb.at.dto.Article;
import com.sbs.lyb.at.util.Util;

@Service
public class ArticleServiceImpl implements ArticleService {
	@Autowired
	ArticleDao articleDao;

	@Override
	public List<Article> getForPrintArticles() {
		return articleDao.getForPrintArticles();
	}

	@Override
	public long add(Map<String, Object> param) {
		articleDao.add(param);

		return Util.getAsLong(param.get("id"));
	}

	@Override
	public Article getForPrintArticleById(int id) {
		return articleDao.getForPrintArticleById(id);
	}
	
	@Override
	public void delete(int id) {
		articleDao.delete(id);
	}
	
	@Override
	public void modify(Map<String, Object> param) {
		articleDao.modify(param);
	}
	
	@Override
	public List<Article> getArticles(int limitFrom) {
		return articleDao.getArticles(limitFrom);
	}
}
