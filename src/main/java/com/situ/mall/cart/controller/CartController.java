package com.situ.mall.cart.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.base.BaseController;
import com.situ.base.BaseService;
import com.situ.mall.cart.model.CartModel;
import com.situ.mall.cart.service.CartService;
import com.situ.tool.Constant;

import yun.tool.FormatEmpty;

@Controller
@RequestMapping("/cart")
public class CartController extends BaseController<CartModel> {
    @Autowired
    private CartService cartService;

    @Override
    public BaseService<CartModel> getService() {
        return cartService;
    }

    @Override
    public String getForwadUrl() {
        return "/404";
    }

    @Override
    public String getOrderBy() {
        return null;
    }

    @ResponseBody
    @RequestMapping(value = "/getCount", produces = "application/json;charset=utf-8")
    public String getCount(CartModel cm) {
        return String.valueOf(cartService.selectCount(cm));
    }

    @ResponseBody
    @RequestMapping(value = "/isStockEnough", produces = "application/json;charset=utf-8")
    public String isStockEnough(String code) {
        return Constant.getMessage(cartService.isStockEnough(code));
    }

    @RequestMapping("/confirmOrder")
    public String confirmOrder(String code, Model model) {
        model.addAttribute("list", getListAll(new CartModel(code, null, true)));
        return "/front/order/confirmOrder";
    }
    
    /**
     * --购物车批量删除
     * @param code
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delAllCart", produces = "application/json;charset=utf-8")
    public String delAll(String code) {
        if (FormatEmpty.isEmpty(code)) {
            return Constant.getMessage(Constant.DEL_DEFEATE);
        }
        return Constant.getMessage(cartService.deleteModel(new CartModel(code, null, true)));
    }
}
