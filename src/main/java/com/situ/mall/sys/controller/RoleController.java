package com.situ.mall.sys.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.base.BaseController;
import com.situ.base.BaseService;
import com.situ.mall.sys.model.RoleModel;
import com.situ.mall.sys.service.RoleService;
import com.situ.tool.Constant;

@Controller
@RequestMapping("/role")
public class RoleController extends BaseController<RoleModel> {
	@Autowired
	private RoleService roleService;

	@Override
	public BaseService<RoleModel> getService() {
		return roleService;
	}

	@Override
	public String getForwadUrl() {
		return "/page/user/roleAddorUpd";
	}

	@Override
	public String getOrderBy() {
		return null;
	}

	@ResponseBody
    @RequestMapping(value="/addRole", produces="application/json;charset=utf-8")
    public String add(RoleModel t, String[] role) {
        return Constant.getMessage(roleService.addOrUpd(t, role, 1));
    }
    
    @ResponseBody
    @RequestMapping(value="/updRole", produces="application/json;charset=utf-8")
    public String upd(RoleModel t, String[] role) {
        return Constant.getMessage(roleService.addOrUpd(t, role, 2));
    }
    
}
