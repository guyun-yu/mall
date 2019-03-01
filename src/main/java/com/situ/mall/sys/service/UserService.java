package com.situ.mall.sys.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.situ.base.BaseMapper;
import com.situ.base.BaseService;
import com.situ.mall.sys.mapper.UserMapper;
import com.situ.mall.sys.model.UserModel;
import com.situ.tool.Constant;

import yun.tool.FormatEmpty;
import yun.tool.FormatMD5;

@Service
public class UserService extends BaseService<UserModel> {
    @Autowired
    private UserMapper userMapper;
    
    @Override
    public BaseMapper<UserModel> getMapper() {
        return userMapper;
    }
    
    @Override
    public String formatModel(UserModel um) {
        if (um == null) {
            return Constant.OBJ_NULL;
        }
        String code = um.getCode();
        um.setCode(code == null ? null : code.trim());
        String password = um.getPassword();
        um.setPassword(password == null ? null : password.trim());
        String name = um.getName();
        um.setName(name == null ? null : name.trim());
        String sex = um.getSex();
        um.setSex(sex == null ? null : sex.trim());
        String birthday = um.getBirthday();
        um.setBirthday(birthday == null ? null : birthday.trim());
        String phone = um.getPhone();
        um.setPhone(phone == null ? null : phone.trim());
        return Constant.PASS;
    }
    
    @Override
    public String checkModel(UserModel um) {
        String msg = formatModel(um);
        if (Constant.OBJ_NULL.equals(msg)) {
            return msg;
        }
        String code = um.getCode();
        if (FormatEmpty.isEmpty(code)) {
            return Constant.ACCOUNT_NULL;
        }
        String password = um.getPassword();
        if (FormatEmpty.isEmpty(password)) {
            return Constant.PASSWORD_NULL;
        }
        String role = um.getRole();
        if (FormatEmpty.isEmpty(role)) {
            return Constant.ROLE_NULL;
        }
        return Constant.PASS;
    }
    
    public String insert(UserModel t) {
        t.setPassword(FormatMD5.encode(t.getPassword()));
        return super.insert(t);
    }

    @Override
    public String canDel(Object[] ids) {
        for (Object id : ids) {
            UserModel um = selectId(id);
            if ("1".equals(um.getRole())) {
                return Constant.CAN_NOT_DEL_ADMIN;
            }
        }
        return Constant.PASS;
    }
}
