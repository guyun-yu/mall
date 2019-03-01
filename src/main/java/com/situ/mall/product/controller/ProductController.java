package com.situ.mall.product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.base.BaseController;
import com.situ.base.BaseService;
import com.situ.mall.product.model.ProductModel;
import com.situ.mall.product.service.ProductService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/product")
public class ProductController extends BaseController<ProductModel> {
    @Autowired
    private ProductService productService;
    
    @Override
    public BaseService<ProductModel> getService() {
        return productService;
    }

    @Override
    public String getForwadUrl() {
        return "/page/product/productAddorUpd";
    }

    @Override
    public String getOrderBy() {
        return "dict_code,code";
    }

    @RequestMapping("/getProduct")
    public String getProduct(String code, Model model) {
        model.addAttribute("obj", JSONObject.fromObject(productService.selectProduct(code)));
        return "/front/product";
    }
    
    /**
     * --好像多此一举，就转了个页面
     * @param name
     * @param model
     * @return
     */
    @RequestMapping("/search")
    public String search(String name, Model model) {
        model.addAttribute("name", name);
        return "/front/productList";
    }
    
    @ResponseBody
    @RequestMapping("/getHotProduct")
    public String getHotProduct(ProductModel pm) {
    	return JSONArray.fromObject(productService.selectHotProduct(pm)).toString();
    }
}
