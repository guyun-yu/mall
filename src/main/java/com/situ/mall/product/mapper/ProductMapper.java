package com.situ.mall.product.mapper;

import com.situ.base.BaseMapper;
import com.situ.mall.product.model.ProductModel;

public interface ProductMapper extends BaseMapper<ProductModel> {

    /**
     * --关联两表，查出商品信息及图片
     * @param code
     * @return
     */
    ProductModel selectProduct(String code);
}
