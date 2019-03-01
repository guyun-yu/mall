package com.situ.mall.sys.mapper;

import java.util.List;

import com.situ.base.BaseMapper;
import com.situ.mall.sys.model.MenuModel;

public interface MenuMapper extends BaseMapper<MenuModel> {

	List<MenuModel> selectAllMenu(String code);

	List<MenuModel> getChildMenu(String code);
}
