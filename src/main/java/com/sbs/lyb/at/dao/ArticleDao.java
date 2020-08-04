package com.sbs.lyb.at.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.lyb.at.dto.Article;

@Mapper // 이렇게 해주면 ArticleDao의 구현체를 마이바티스가 대신 구현해준다.
public interface ArticleDao {
	public List<Article> getForPrintArticles();

	public void add(Map<String, Object> param);

	public Article getForPrintArticleById(int id);
	
	public void delete(int id);
	
	public void modify(Map<String, Object> param);

	public List<Article> getArticles(int limitFrom);
}