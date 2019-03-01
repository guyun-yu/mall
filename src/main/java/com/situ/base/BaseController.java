package com.situ.base;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.tool.Constant;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public abstract class BaseController<T extends FormatPage> {
    public abstract BaseService<T> getService();
    
    /**
     * @return 切换选项卡时转发路径
     */
    public abstract String getForwadUrl();
    
    public abstract String getOrderBy();
    
    @ResponseBody
    @RequestMapping(value="/getList", produces="application/json;charset=utf-8")
    public String getList(T t) {
        t.setPageOn(true);
        t.setOrderBy(getOrderBy());
        JSONObject obj = new JSONObject();
        obj.put("list", getService().selectModel(t));
        obj.put("rowCount", getService().selectCount(t));
        return obj.toString();
    }
    
    @ResponseBody
    @RequestMapping(value="/getListAll", produces="application/json;charset=utf-8")
    public String getListAll(T t) {
        return JSONArray.fromObject(getService().selectAll(t)).toString();
    }
    
    @ResponseBody
    @RequestMapping("/getModel")
    public String getModel(String id) {
        return JSONObject.fromObject(getService().selectId(id)).toString();
    }
    
    @RequestMapping("/addTab")
    public String addTab() {
        return getForwadUrl();
    }
    
    @ResponseBody
    @RequestMapping(value="/del", produces="application/json;charset=utf-8")
    public String del(String id) {
        return Constant.getMessage(getService().delete(id));
    }
    
    @ResponseBody
    @RequestMapping(value="/delAll", produces="application/json;charset=utf-8")
    public String delAll(String[] id) {
        return Constant.getMessage(getService().delete(id));
    }
    
    /**
     * --修改选项卡
     * @param code
     * @param model
     * @return 转发路径
     */
    @RequestMapping("/updTab")
    public String updTab(String id, Model model) {
        T t = getService().selectId(id);
        System.out.println(t);
        if (t == null) {
            return "/404";
        } else {
            model.addAttribute("obj", t);
            return getForwadUrl();
        }
    }
    
    @ResponseBody
    @RequestMapping(value="/add", produces="application/json;charset=utf-8")
    public String add(T t) {
        return addorUpd(t, 1);
    }
    
    @ResponseBody
    @RequestMapping(value="/upd", produces="application/json;charset=utf-8")
    public String upd(T t) {
        return addorUpd(t, 2);
    }
    
    /**
     * @param t
     * @param type 1=添加  2=修改
     * @return
     */
    private String addorUpd(T t, int type) {
        String msg;
        if (type == 1) {
            msg = getService().insert(t);
        } else {
            msg = getService().updateActive(t);
        }
        return Constant.getMessage(msg);
    }
}
