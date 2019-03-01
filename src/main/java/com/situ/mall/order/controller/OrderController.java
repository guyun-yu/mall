package com.situ.mall.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.base.BaseController;
import com.situ.base.BaseService;
import com.situ.mall.order.model.OrderModel;
import com.situ.mall.order.service.OrderService;
import com.situ.tool.Constant;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/order")
public class OrderController extends BaseController<OrderModel> {
    @Autowired
    private OrderService orderService;
    
    @RequestMapping("/orderItemTab")
    public String orderItemTab(String code, Model model) {
        model.addAttribute("code", code);
        return "/page/order/orderItemList";
    }
    
    @Override
    public BaseService<OrderModel> getService() {
        return orderService;
    }

    @Override
    public String getForwadUrl() {
        return "/page/order/orderUpd";
    }

    @Override
    public String getOrderBy() {
        return "create_time desc";
    }
    
    @RequestMapping("/createOrder")
    public String createOrder(OrderModel t) {
        if (t == null) {
            return "/404";
        }
        orderService.createOrder(t.getUserCode());
        return "redirect:/web/front/order/orderList.jsp";
    }
    
    @ResponseBody
    @RequestMapping(value="/getOrder", produces="application/json;charset=utf-8")
    public String getOrder(OrderModel t) {
        t.setPageOn(true);
        t.setOrderBy(getOrderBy());
        JSONObject obj = new JSONObject();
        obj.put("list", orderService.selectOrder(t));
        obj.put("rowCount", orderService.selectCount(t));
        return obj.toString();
    }
    
    @ResponseBody
    @RequestMapping(value="/pay", produces="application/json;charset=utf-8")
    public String pay(String code) {
    	return Constant.getMessage(orderService.pay(code));
    }
}
