package com.sbs.lyb.at.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.lyb.at.dto.Article;
import com.sbs.lyb.at.dto.Member;
import com.sbs.lyb.at.service.ArticleService;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;

	@RequestMapping("/usr/article/list")
	public String showList(Model model) {
		List<Article> articles = articleService.getForPrintArticles();

		model.addAttribute("articles", articles);

		return "article/list";
	}

	@RequestMapping("/usr/article/detail")
	public String showDetail(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req) {
		int id = Integer.parseInt((String) param.get("id"));
		
		Member loginedMember = (Member)req.getAttribute("loginedMember");

		Article article = articleService.getForPrintArticleById(loginedMember, id);

		model.addAttribute("article", article);

		return "article/detail";
	}

	@RequestMapping("/usr/article/write")
	public String showWrite() {
		return "article/write";
	}

	@RequestMapping("/usr/article/doWrite")
	public String doWrite(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		int loginedMemberId = (int)req.getAttribute("loginedMemberId");
		param.put("memberId", loginedMemberId);
		int newArticleId = articleService.write(param);

		String redirectUri = (String) param.get("redirectUri");
		redirectUri = redirectUri.replace("#id", newArticleId + "");

		return "redirect:" + redirectUri;
	}
	
	@RequestMapping("/usr/article/modify")
	public String showModify(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req) {
		int id = Integer.parseInt((String) param.get("id"));
		Member loginedMember = (Member)req.getAttribute("loginedMember");
		Article article = articleService.getForPrintArticleById(loginedMember, id);
		model.addAttribute("article", article);
		return "article/modify";
	}
	
	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(@RequestParam Map<String, Object> param) {
		
		int id = Integer.parseInt((String) param.get("id"));
		
		articleService.modify(param);
		
		StringBuilder sb = new StringBuilder();
		String msg = id + "번 글이 수정 되었습니다.";
		sb.append("alert('" + msg + "');");
		sb.append("location.replace('./detail?id=" + id + "');");

		sb.insert(0, "<script>");
		sb.append("</script>");
		return sb.toString();
	}
	
	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {
		articleService.delete(id);
		StringBuilder sb = new StringBuilder();
		String msg = id + "번 글이 삭제 되었습니다.";
		sb.append("alert('" + msg + "');");
		sb.append("location.replace('./list');");

		sb.insert(0, "<script>");
		sb.append("</script>");
		return sb.toString();
	}
}