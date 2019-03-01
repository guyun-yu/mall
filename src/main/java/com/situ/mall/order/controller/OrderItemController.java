package com.situ.mall.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.situ.base.BaseController;
import com.situ.base.BaseService;
import com.situ.mall.order.model.OrderItemModel;
import com.situ.mall.order.service.OrderItemService;

@Controller
@RequestMapping("/orderItem")
public class OrderItemController extends BaseController<OrderItemModel> {
    @Autowired
    private OrderItemService orderItemService;
    
    @RequestMapping("/addProduct")
    public String addProduct(String orderCode, Model model) {
        model.addAttribute("orderCode", orderCode);
        return "/page/order/orderItemAdd";
    }

    @Override
    public BaseService<OrderItemModel> getService() {
        return orderItemService;
    }

    @Override
    public String getForwadUrl() {
        return "/page/order/orderItemAdd";
    }

    @Override
    public String getOrderBy() {
        return null;
    }

}
