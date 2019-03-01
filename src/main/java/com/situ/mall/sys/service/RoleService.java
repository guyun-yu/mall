package com.situ.mall.sys.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.situ.base.BaseMapper;
import com.situ.base.BaseService;
import com.situ.mall.sys.mapper.RoleMapper;
import com.situ.mall.sys.mapper.RoleMenuMapper;
import com.situ.mall.sys.mapper.UserMapper;
import com.situ.mall.sys.model.RoleMenuModel;
import com.situ.mall.sys.model.RoleModel;
import com.situ.mall.sys.model.UserModel;
import com.situ.tool.Constant;

import yun.tool.FormatEmpty;

@Service
public class RoleService extends BaseService<RoleModel> {
	@Autowired
	private RoleMapper roleMapper;
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private RoleMenuMapper roleMenuMapper;

	@Override
	public BaseMapper<RoleModel> getMapper() {
		return roleMapper;
	}

	@Override
	public String formatModel(RoleModel t) {
		if (t == null) {
			return Constant.OBJ_NULL;
		}
		String code = t.getCode();
		t.setCode(code == null ? null : code.trim());
		String name = t.getName();
		t.setName(name == null ? null : name.trim());
		String descr = t.getDescr();
		t.setDescr(descr == null ? null : descr.trim());
		return Constant.PASS;
	}

	@Override
	public String checkModel(RoleModel t) {
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
			UserModel um = new UserModel();
			um.setRole(id.toString());
			if (userMapper.selectCount(um) > 0) {
				return Constant.CAN_NOT_DEL;
			}
		}
		return Constant.PASS;
	}

	/**
	 * --添加/修改角色，以及对应权限菜单
	 * @param t
	 * @param role
	 * @param type 1=添加，2=修改
	 * @return
	 */
	public String addOrUpd(RoleModel t, String[] role, int type) {
		String msg = checkModel(t);
		if (!Constant.PASS.equals(msg)) {
			return msg;
		}
		int result1 = 0;
		int result2 = 0;
		if (type == 1) {
			if (selectId(t.getCode()) != null) {
				return Constant.CODE_REPEAT;
			}
			result1 = roleMapper.insert(t);
		} else if (type == 2) {
			result1 = roleMapper.updateActive(t);
			roleMenuMapper.deleteModel(new RoleMenuModel(t.getCode(), null));
		}
		if (role != null) {
			for (String rol : role) {
				result2 += roleMenuMapper.insert(new RoleMenuModel(t.getCode(), rol));
			}
		}
		return (result1 + result2 >= role.length + 1) ? Constant.ADD_SUCCESS : Constant.ADD_DEFEATE;
	}

}
