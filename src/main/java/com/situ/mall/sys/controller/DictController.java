package com.situ.mall.sys.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.base.BaseController;
import com.situ.base.BaseService;
import com.situ.mall.product.model.CategoryModel;
import com.situ.mall.sys.model.DictModel;
import com.situ.mall.sys.service.DictService;
import com.situ.tool.Constant;
import com.situ.tool.DictConstant;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import yun.tool.FormatEmpty;

@Controller
@RequestMapping("/dict")
public class DictController extends BaseController<DictModel> {
    @Autowired
    private DictService dictService;

    @Override
    public BaseService<DictModel> getService() {
        return dictService;
    }
    
    @ResponseBody
    @RequestMapping(value="/categoryAdd", produces="application/json;charset=utf-8")
    public String categoryAdd(CategoryModel cm) {
        return addorUpd(cm, 1);
    }
    
    @ResponseBody
    @RequestMapping(value="/categoryUpd", produces="application/json;charset=utf-8")
    public String categoryUpd(CategoryModel cm) {
        return addorUpd(cm, 2);
    }
    
    @RequestMapping("/categoryUpdTab")
    public String categoryUpdTab(String code, Model model) {
        CategoryModel t = dictService.selectCategory(code);
        if (t == null) {
            return "/404";
        } else {
            model.addAttribute("obj", t);
            return getForwadUrl();
        }
    }
    
    @Override
    public String getForwadUrl() {
        return "/page/basis/categoryAddorUpd";
    }

    @Override
    public String getOrderBy() {
        return "code,parent_code";
    }
    
    @ResponseBody
    @RequestMapping(value="/getAllCateList", produces="application/json;charset=utf-8")
    public String getAllCateList() {
        return JSONArray.fromObject(getAllCateList(DictConstant.CATEGORY_PARENT)).toString();
    }
    
    @RequestMapping("/getCategory")
    public String getCategory(String code, Model model) {
        model.addAttribute("obj", JSONObject.fromObject(dictService.selectCategory(code)));
        return "/front/productList";
    }
    
    @ResponseBody
    @RequestMapping(value="/getProdCate", produces="application/json;charset=utf-8")
    public String getProdCate(String code) {
        return JSONObject.fromObject(dictService.selectCategory(code)).toString();
    }
    
    /**
     * @param cm
     * @param type 1=添加 2=修改
     * @return
     */
    private String addorUpd(CategoryModel cm, int type) {
        if (cm == null) {
            return Constant.OBJ_NULL;
        }
        
        String category1 = cm.getCategory1();
        String category2 = cm.getCategory2();
        if (FormatEmpty.isEmpty(category2) || category1.equals(category2)) {
            cm.setParentCode(category1);
        } else {
            cm.setParentCode(category2);
        }
        String msg;
        if (type == 1) {
            msg = dictService.insert(cm);
        } else {
            msg = dictService.updateActive(cm);
        }
        return Constant.getMessage(msg);
    }
    
    private List<DictModel> getAllCateList(String code) {
        return dictService.selectAllCate(code);
    }
}
