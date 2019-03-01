package com.situ.mall.sys.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.situ.base.BaseMapper;
import com.situ.base.BaseService;
import com.situ.mall.sys.mapper.MenuMapper;
import com.situ.mall.sys.model.MenuModel;
import com.situ.tool.Constant;
import com.situ.tool.DictConstant;

import yun.tool.FormatEmpty;

@Service
public class MenuService extends BaseService<MenuModel> {
	@Autowired
	private MenuMapper menuMapper;

	@Override
	public BaseMapper<MenuModel> getMapper() {
		return menuMapper;
	}

	@Override
	public String formatModel(MenuModel t) {
		if (t == null) {
			return Constant.OBJ_NULL;
		}
		String code = t.getCode();
		t.setCode(code == null ? null : code.trim());
		String name = t.getName();
		t.setName(name == null ? null : name.trim());
		String url = t.getUrl();
		t.setUrl(url == null ? null : url.trim());
		String parentCode = t.getParentCode();
		t.setParentCode(parentCode == null ? null : parentCode.trim());
		return Constant.PASS;
	}

	@Override
	public String checkModel(MenuModel t) {
		String msg = formatModel(t);
		if (!Constant.PASS.equals(msg)) {
			return msg;
		}
		if (FormatEmpty.isEmpty(t.getCode())) {
			return Constant.CODE_NULL;
		}
		if (FormatEmpty.isEmpty(t.getName())) {
			return Constant.NAME_NULL;
		}
		return Constant.PASS;
	}

	@Override
	public String canDel(Object[] ids) {
		for (Object id : ids) {
			MenuModel mm = new MenuModel();
			mm.setParentCode(id.toString());
			if (menuMapper.selectCount(mm) > 0) {
				return Constant.CAN_NOT_DEL_EXIST_CHILD;
			}
		}
		return Constant.PASS;
	}

	/**
	 * --获取所有二级菜单
	 * @return
	 */
	public List<MenuModel> getChildMenu() {
		return menuMapper.getChildMenu(DictConstant.MENU_PARENT);
	}
	
	/**
	 * --根据权限查询菜单
	 * @param rolecode
	 * @return
	 */
	public List<MenuModel> selectAllMenu(String rolecode) {
		return menuMapper.selectAllMenu(rolecode);
	}

}
