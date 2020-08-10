package com.sbs.lyb.at.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.lyb.at.dao.ArticleDao;
import com.sbs.lyb.at.dto.Article;
import com.sbs.lyb.at.dto.ArticleReply;
import com.sbs.lyb.at.dto.Member;
import com.sbs.lyb.at.dto.ResultData;
import com.sbs.lyb.at.util.Util;


@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;

	public List<Article> getForPrintArticles() {
		List<Article> articles = articleDao.getForPrintArticles();

		return articles;
	}

	public Article getForPrintArticleById(int id) {
		Article article = articleDao.getForPrintArticleById(id);

		return article;
	}

	public int write(Map<String, Object> param) {
		articleDao.write(param);

		return Util.getAsInt(param.get("id"));
	}

	public int writeReply(Map<String, Object> param) {
		articleDao.writeReply(param);

		return Util.getAsInt(param.get("id"));
	}

	public List<ArticleReply> getForPrintArticleReplies(@RequestParam Map<String, Object> param) {
		List<ArticleReply> articleReplies = articleDao.getForPrintArticleReplies(param);
		
		Member actor = (Member)param.get("actor");
		
		
		for ( ArticleReply articleReply : articleReplies ) {
			updateForPrintInfo(actor,articleReply);
		}
		
		return articleReplies;
	}

	private void updateForPrintInfo(Member actor, ArticleReply articleReply) {
		articleReply.getExtra().put("actorCanDelete", actorCanDelete(actor,articleReply));
		articleReply.getExtra().put("actorCanModify", actorCanModify(actor,articleReply));
	}

	public boolean actorCanModify(Member actor, ArticleReply articleReply) {
		return actor != null && actor.getId() == articleReply.getMemberId() ? true : false;
	}

	public boolean actorCanDelete(Member actor, ArticleReply articleReply) {
		return actorCanModify(actor, articleReply);
	}

	public void deleteReply(int id) {
		articleDao.deleteReply(id);
	}

	public void delete(int id) {
		articleDao.delete(id);
	}

	public void modify(Map<String, Object> param) {
		articleDao.modify(param);
	}

	public ArticleReply getForPrintArticleReplyById(int id) {
		return articleDao.getForPrintArticleReplyById(id);
	}

	public ResultData modifyReply(Map<String, Object> param) {
		articleDao.modifyReply(param);
		return new ResultData("S-1", String.format("%d번 댓글을 수정하였습니다.", Util.getAsInt(param.get("id"))), param);
	}
}