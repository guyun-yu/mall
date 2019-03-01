package com.situ.base.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.situ.mall.sys.model.DictModel;
import com.situ.mall.sys.model.UserModel;
import com.situ.mall.sys.service.DictService;
import com.situ.mall.sys.service.UserService;
import com.situ.tool.DictConstant;

@WebListener
public class InitListener implements ServletContextListener {
    
    public InitListener() {}

    public void contextDestroyed(ServletContextEvent sce)  {}

    public void contextInitialized(ServletContextEvent sce)  {
        ApplicationContext ac = WebApplicationContextUtils.getRequiredWebApplicationContext(sce.getServletContext());
        UserService userService = (UserService) ac.getBean("userService");
        userService.insert(new UserModel("0000", "超级管理员", "0000", "1"));

        DictService dictService = (DictService) ac.getBean("dictService");
    	dictService.insert(new DictModel(DictConstant.CATEGORY_PARENT, "商品分类", DictConstant.PARENT_CODE));
    	dictService.insert(new DictModel(DictConstant.ADDRESS_PARENT, "地址维护", DictConstant.PARENT_CODE));
        System.out.println("InitListener");
    }
}
