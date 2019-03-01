package com.situ.mall.sys.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.situ.base.BaseController;
import com.situ.base.BaseService;
import com.situ.mall.sys.model.RoleMenuModel;
import com.situ.mall.sys.service.RoleMenuService;

@Controller
@RequestMapping("/roleMenu")
public class RoleMenuController extends BaseController<RoleMenuModel> {
	@Autowired
	private RoleMenuService roleMenuService;

	@Override
	public BaseService<RoleMenuModel> getService() {
		return roleMenuService;
	}

	@Override
	public String getForwadUrl() {
		return "/404";
	}

	@Override
	public String getOrderBy() {
		return null;
	}

}
