package com.situ.mall.sys.model;

import com.situ.base.FormatPage;

public class RoleMenuModel extends FormatPage {

	private String menuCode;

	public RoleMenuModel() {
		super();
	}

	public RoleMenuModel(String code, String menuCode) {
		setCode(code);
		this.menuCode = menuCode;
	}

	@Override
	public String toString() {
		return super.toString() + "RoleMenuModel [menuCode=" + menuCode + "]";
	}

	public String getMenuCode() {
		return menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}
}
