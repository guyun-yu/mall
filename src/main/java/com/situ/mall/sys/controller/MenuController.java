package com.situ.mall.sys.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.base.BaseController;
import com.situ.base.BaseService;
import com.situ.mall.sys.model.MenuModel;
import com.situ.mall.sys.service.MenuService;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/menu")
public class MenuController extends BaseController<MenuModel> {
	@Autowired
	private MenuService menuService;

	@Override
	public BaseService<MenuModel> getService() {
		return menuService;
	}

	@Override
	public String getForwadUrl() {
		return "/page/basis/menuAddorUpd";
	}

	@Override
	public String getOrderBy() {
		return "parent_code,code";
	}

	@ResponseBody
	@RequestMapping(value="/getChildMenu", produces="application/json;charset=utf-8")
	public String getChildMenu() {
		return JSONArray.fromObject(menuService.getChildMenu()).toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/getAllMenu", produces="application/json;charset=utf-8")
	public String getAllMenu(String rolecode) {
		return JSONArray.fromObject(menuService.selectAllMenu(rolecode)).toString();
	}
}
