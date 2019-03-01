package com.situ.mall.sys.model;

import com.situ.base.FormatPage;

public class RoleModel extends FormatPage {
	
	private String descr;

	public RoleModel() {
		super();
	}

	@Override
	public String toString() {
		return super.toString() + "RoleModel [descr=" + descr + "]";
	}

	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}
}
