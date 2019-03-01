package com.situ.base.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import org.springframework.core.annotation.Order;

import com.situ.mall.sys.model.UserModel;

/**
 * --权限过滤
 */
@WebFilter(urlPatterns="/web/page/*")
@Order(2)
public class RoleFilter implements Filter {
	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
	    HttpServletRequest hRequest = (HttpServletRequest) request;
        UserModel user = (UserModel) hRequest.getSession().getAttribute("user");
        if (user == null || (!"1".equals(user.getRole()) && !"2".equals(user.getRole()))) {
            request.getRequestDispatcher("/web/front/index.jsp").forward(request, response);
        } else {
            chain.doFilter(request, response);
        }
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
