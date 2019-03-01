package com.situ.mall.sys.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.situ.base.BaseMapper;
import com.situ.base.BaseService;
import com.situ.mall.product.mapper.ProductMapper;
import com.situ.mall.product.model.CategoryModel;
import com.situ.mall.product.model.ProductModel;
import com.situ.mall.sys.mapper.DictMapper;
import com.situ.mall.sys.model.DictModel;
import com.situ.tool.Constant;

import yun.tool.FormatEmpty;

@Service
public class DictService extends BaseService<DictModel> {
    @Autowired
    private DictMapper dictMapper;
    @Autowired
    private ProductMapper productMapper;
    
    @Override
    public BaseMapper<DictModel> getMapper() {
        return dictMapper;
    }
    
    @Override
    public String formatModel(DictModel t) {
        if (t == null) {
            return Constant.OBJ_NULL;
        }
        String code = t.getCode();
        t.setCode(code == null ? null : code.trim());
        String name = t.getName();
        t.setName(name == null ? null : name.trim());
        String descr = t.getDescr();
        t.setDescr(descr == null ? null : descr.trim());
        String parentCode = t.getParentCode();
        t.setParentCode(parentCode == null ? null : parentCode.trim());
        return Constant.PASS;
    }
    
    @Override
    public String checkModel(DictModel t) {
        String msg = formatModel(t);
        if (Constant.OBJ_NULL.equals(msg)) {
            return msg;
        }
        String code = t.getCode();
        if (FormatEmpty.isEmpty(code)) {
            return Constant.CODE_NULL;
        }
        String name = t.getName();
        if (FormatEmpty.isEmpty(name)) {
            return Constant.NAME_NULL;
        }
        return Constant.PASS;
    }

    /**
     * --查询商品的1、2、3级分类编号以及名字
     * @param code
     * @return
     */
    public CategoryModel selectCategory(String code) {
        if (FormatEmpty.isEmpty(code)) {
            return null;
        }
        return dictMapper.selectCategory(code);
    }
    
    /**
     * --查询所有分类，前台主页分类展示
     * @param code
     * @return
     */
    public List<DictModel> selectAllCate(String code) {
        return dictMapper.selectAllCate(code);
    }

    @Override
    public String canDel(Object[] ids) {
        for (Object id : ids) {
            if (dictMapper.selectCount(new DictModel(null, id.toString())) > 0) {
                return Constant.CAN_NOT_DEL_EXIST_CHILD;
            }
            ProductModel pm = new ProductModel();
            pm.setDictCode(id.toString());
            if (productMapper.selectCount(pm) > 0) {
                return Constant.CAN_NOT_DEL_EXIST_PRODUCT;
            }
        }
        return Constant.PASS;
    }
}
