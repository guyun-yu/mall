package com.situ.mall.sys.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.situ.base.BaseMapper;
import com.situ.base.BaseService;
import com.situ.mall.sys.mapper.RoleMenuMapper;
import com.situ.mall.sys.model.RoleMenuModel;
import com.situ.tool.Constant;

import yun.tool.FormatEmpty;

@Service
public class RoleMenuService extends BaseService<RoleMenuModel> {
	@Autowired
	private RoleMenuMapper roleMenuMapper;

	@Override
	public BaseMapper<RoleMenuModel> getMapper() {
		return roleMenuMapper;
	}

	@Override
	public String formatModel(RoleMenuModel t) {
		if (t == null) {
			return Constant.OBJ_NULL;
		}
		String roleCode = t.getCode();
		t.setCode(roleCode == null ? null : roleCode.trim());
		String menuCode = t.getMenuCode();
		t.setMenuCode(menuCode == null ? null : menuCode.trim());
		return Constant.PASS;
	}

	@Override
	public String checkModel(RoleMenuModel t) {
		String msg = formatModel(t);
		if (!Constant.PASS.equals(msg)) {
			return msg;
		}
		if (FormatEmpty.isEmpty(t.getCode()) || FormatEmpty.isEmpty(t.getMenuCode())) {
			return Constant.CODE_NULL;
		}
		return Constant.PASS;
	}

	@Override
	public String canDel(Object[] ids) {
		return Constant.PASS;
	}

}
