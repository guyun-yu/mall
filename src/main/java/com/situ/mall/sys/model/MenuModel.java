package com.situ.mall.sys.model;

import java.util.ArrayList;
import java.util.List;

import com.situ.base.FormatPage;

public class MenuModel extends FormatPage {

	private String url;
	private String parentCode;
	private List<MenuModel> child = new ArrayList<>();

	public MenuModel() {
		super();
	}

	@Override
	public String toString() {
		return super.toString() + "MenuModel [url=" + url + ", parentCode=" + parentCode + ", child=" + child + "]";
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public List<MenuModel> getChild() {
		return child;
	}

	public void setChild(List<MenuModel> child) {
		this.child = child;
	}
}
