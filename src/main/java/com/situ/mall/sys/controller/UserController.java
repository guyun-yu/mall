package com.situ.mall.sys.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.base.BaseController;
import com.situ.base.BaseService;
import com.situ.mall.sys.model.UserModel;
import com.situ.mall.sys.service.UserService;
import com.situ.tool.Constant;

import net.sf.json.JSONObject;
import yun.tool.FormatEmpty;
import yun.tool.FormatMD5;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController<UserModel> {
    @Autowired
    private UserService userService;
    
    @ResponseBody
    @RequestMapping(value="/addUser", produces="application/json;charset=utf-8")
    public String addUser(String again, UserModel um) {
        if (um == null || again == null) {
            return Constant.getMessage(Constant.OBJ_NULL);
        }
        
        if (!again.equals(um.getPassword())) {
            return Constant.getMessage(Constant.PASSWORD_NOT_SAME);
        }
        return add(um);
    }
    
    @Override
    public BaseService<UserModel> getService() {
        return userService;
    }

    @Override
    public String getForwadUrl() {
        return "/page/user/userAddorUpd";
    }

    @Override
    public String getOrderBy() {
        return "role,code";
    }
    
    @ResponseBody
    @RequestMapping(value="/login", produces="application/json;charset=utf-8")
    public String login(UserModel um, String authCode, HttpSession session) {
        JSONObject obj = new JSONObject();
        if (!isAuthCode(session, authCode)) {
            obj.put("msg", Constant.getMessage(Constant.AUTH_CODE_ERROR));
            return obj.toString();
        }
        UserModel u = userService.selectId(um.getCode());
        if (u == null) {
            obj.put("msg", Constant.getMessage(Constant.ACCOUNT_NOT_EXIST));
            return obj.toString();
        }
        if (!FormatMD5.compareMD5(um.getPassword(), u.getPassword())) {
            obj.put("msg", Constant.getMessage(Constant.PASSWORD_ERROR));
            return obj.toString();
        }
        session.setAttribute("user", u);
        obj.put("msg", Constant.getMessage(Constant.LOGIN_SUCCESS));
        obj.put("role", u.getRole());
        return obj.toString();
    }
    
    @RequestMapping("/exit")
    public String exit(HttpSession session, HttpServletRequest request) {
        session.removeAttribute("user");
        String url = request.getHeader("referer");
        String context = request.getContextPath();
        return "redirect:" + url.substring(url.indexOf(context) + context.length());
    }
    
    @ResponseBody
    @RequestMapping(value="/register", produces="application/json;charset=utf-8")
    public String register(String again, UserModel um, HttpSession session) {
        if (um == null) {
            return Constant.getMessage(Constant.OBJ_NULL);
        }
        um.setRole("3");
        String msg = addUser(again, um);
        if (Constant.getMessage(Constant.ADD_SUCCESS).equals(msg)) {
            session.setAttribute("user", userService.selectId(um.getCode()));
        }
        return msg;
    }
    
    @ResponseBody
    @RequestMapping(value="/updUser", produces="application/json;charset=utf-8")
    public String updUser(String code, HttpSession session) {
    	UserModel um = userService.selectId(code);
    	if (um == null) {
    		return Constant.getMessage(Constant.ACCOUNT_NULL);
    	}
    	session.setAttribute("user", um);
    	return Constant.getMessage(Constant.UPD_SUCCESS);
    }
    
    /**
     * --修改密码，退出登录
     * @param again
     * @param um
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/updPass", produces="application/json;charset=utf-8")
    public String updPass(String again, UserModel um, HttpSession session) {
    	if (um == null || again == null) {
            return Constant.getMessage(Constant.OBJ_NULL);
        }
        
        if (!again.equals(um.getPassword())) {
            return Constant.getMessage(Constant.PASSWORD_NOT_SAME);
        }
        um.setPassword(FormatMD5.encode(um.getPassword()));
        String msg = userService.updateActive(um);
        if (Constant.UPD_SUCCESS.equals(msg)) {
        	session.removeAttribute("user");
        }
        return Constant.getMessage(msg);
    }
    
    /**
     * --模拟电话验证码
     * @param phone
     * @param authCode
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/phoneCode", produces="application/json;charset=utf-8")
    public String phoneCode(String phone, String authCode) {
    	UserModel um = new UserModel();
    	um.setPhone(phone);
    	List<UserModel> list = userService.selectModel(um);
    	if (FormatEmpty.isEmpty(list)) {
    		return Constant.getMessage(Constant.PHONE_ERROR);
    	}
    	if (!"0000".equals(authCode)) {
    		return Constant.getMessage(Constant.AUTH_CODE_ERROR);
    	}
    	return JSONObject.fromObject(list.get(0)).toString();
    }
    
    private boolean isAuthCode(HttpSession session, String inputCode) {
        Object authCode = session.getAttribute("authCode");
        if (inputCode == null) {
            return false;
        }
        return inputCode.equalsIgnoreCase(authCode.toString());
    }
}
