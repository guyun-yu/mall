package com.situ.mall.product.controller;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.situ.base.BaseController;
import com.situ.base.BaseService;
import com.situ.mall.product.model.ProductImgModel;
import com.situ.mall.product.service.ProductImgService;
import com.situ.tool.Constant;

@Controller
@RequestMapping("/productImg")
public class ProductImgController extends BaseController<ProductImgModel> {
    @Autowired
    private ProductImgService productImgService;
    
    private static final String PATH = "H:/image/productImg/";
    
    static {
        File file = new File(PATH);
        if (!file.exists()) {
            file.mkdir();
        }
    }
    
    @ResponseBody
    @RequestMapping("/upload")
    public String upload(HttpServletRequest request, String code) throws IllegalStateException, IOException {
        // 将当前上下文初始化给 CommonsMutipartResolver （多部分解析器）
        CommonsMultipartResolver multipartResolver = 
                new CommonsMultipartResolver(request.getSession().getServletContext());
        // 检查form中是否有enctype="multipart/form-data"
        if (multipartResolver.isMultipart(request)) {
            // 将request变成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            // 获取multiRequest 中所有的文件名
            Iterator<String> iter = multiRequest.getFileNames();
            // 一次遍历所有文件
            while (iter.hasNext()) {
                MultipartFile file = multiRequest.getFile(iter.next().toString());
                if (file != null) {
                    String filename = file.getOriginalFilename();
                    String saveName = UUID.randomUUID().toString() + filename.substring(filename.lastIndexOf("."));
                    String path = PATH + saveName;
                    file.transferTo(new File(path));// 上传
                    productImgService.insert(new ProductImgModel(code, saveName, Constant.ORTHER_IMG));
                }
            }
        }
        return "0";
    }
    
    @ResponseBody
    @RequestMapping(value="/setMain", produces="application/json;charset=utf-8")
    public String setMain(ProductImgModel t) {
        t.setType(Constant.MAIN_IMG);
        String msg = productImgService.setMain(t);
        
        String rel = Constant.getMessage(msg);
        System.out.println(rel);
        return rel;
    }
    
    @Override
    public BaseService<ProductImgModel> getService() {
        return productImgService;
    }

    @Override
    public String getForwadUrl() {
        return "/404";
    }

    @Override
    public String getOrderBy() {
        return "type";
    }

}
