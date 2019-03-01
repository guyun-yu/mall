package com.situ.mall.sys.mapper;

import java.util.List;

import com.situ.base.BaseMapper;
import com.situ.mall.product.model.CategoryModel;
import com.situ.mall.sys.model.DictModel;

public interface DictMapper extends BaseMapper<DictModel> {

    /**
     * --查询商品的1、2、3级分类编号以及名字
     * @param code
     * @return
     */
    CategoryModel selectCategory(String code);
    
    /**
     * --查询所有分类
     * @param code
     * @return
     */
    List<DictModel> selectAllCate(String code);
}
