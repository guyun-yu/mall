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

import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;

/**
 * --登录过滤
 */
@WebFilter(urlPatterns= {"/web/page/*", "/web/front/order/*", "/web/front/user/*"})
@Order(Ordered.HIGHEST_PRECEDENCE)
public class UserFilter implements Filter {
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
	    HttpServletRequest hRequest = (HttpServletRequest) request;
        Object user = hRequest.getSession().getAttribute("user");
        if (user == null) {
            request.getRequestDispatcher("/web/front/index.jsp").forward(request, response);
        } else {
            chain.doFilter(request, response);
        }
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

    public void destroy() {
    }

}
