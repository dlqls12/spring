package com.sbs.lyb.at.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.lyb.at.dto.Article;
import com.sbs.lyb.at.service.ArticleService;

@Controller
public class ArticleController {
	@Autowired
	ArticleService articleService;

	@RequestMapping("/article/detail")
	public String showDetail(Model model, int id) {
		Article article = articleService.getForPrintArticleById(id);

		model.addAttribute("article", article);

		return "article/detail";
	}

	@RequestMapping("/article/list")
	public String showList(Model model, int page) {
		List<Article> allArticles = articleService.getForPrintArticles();
		int allArticlesSize = allArticles.size();
		int itemsInAPage = 10;
		int limitFrom = (page - 1) * itemsInAPage;
		int paging = 1;
		List<Article> articles = articleService.getArticles(limitFrom);
		
		if ( allArticlesSize%itemsInAPage == 0 ) {
			paging = (allArticlesSize/itemsInAPage);
		}
		else {
			paging = (allArticlesSize/itemsInAPage)+1;
		}
		
		model.addAttribute("page", page);
		model.addAttribute("paging", paging);
		model.addAttribute("articles", articles);

		return "article/list";
	}

	@RequestMapping("/article/add")
	public String showAdd() {
		return "article/add";
	}
	
	@RequestMapping("/article/doAdd")
	@ResponseBody
	public String doAdd(@RequestParam Map<String, Object> param) {
		long newId = articleService.add(param);

		String msg = newId + "번 게시물이 추가되었습니다.";

		StringBuilder sb = new StringBuilder();

		sb.append("alert('" + msg + "');");
		sb.append("location.replace('./detail?id=" + newId + "');");

		sb.insert(0, "<script>");
		sb.append("</script>");

		return sb.toString();
	}
	
	@RequestMapping("/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {
		articleService.delete(id);

		String msg = id + "번 게시물이 삭제되었습니다.";

		StringBuilder sb = new StringBuilder();

		sb.append("alert('" + msg + "');");
		sb.append("location.replace('./list?page=1');");

		sb.insert(0, "<script>");
		sb.append("</script>");

		return sb.toString();
	}
	
	@RequestMapping("/article/modify")
	public String showModify(Model model, int id) {
		Article article = articleService.getForPrintArticleById(id);

		model.addAttribute("article", article);

		return "article/modify";
	}
	
	@RequestMapping("/article/doModify")
	@ResponseBody
	public String doModify(@RequestParam Map<String, Object> param, long id) {
		articleService.modify(param);

		String msg = id + "번 게시물이 수정되었습니다.";

		StringBuilder sb = new StringBuilder();

		sb.append("alert('" + msg + "');");
		sb.append("location.replace('./detail?id=" + id + "');");

		sb.insert(0, "<script>");
		sb.append("</script>");

		return sb.toString();
	}
}
