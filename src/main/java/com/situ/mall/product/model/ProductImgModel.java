package com.situ.mall.product.model;

import com.situ.base.FormatPage;

public class ProductImgModel extends FormatPage {
    private Integer type;// 1=主图，2=其他

    public ProductImgModel() {
        super();
    }
    
    public ProductImgModel(String code, String name, Integer type) {
        super(code, name);
        this.type = type;
    }

    @Override
    public String toString() {
        return super.toString() + "ProductImgModel [type=" + type + "]";
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
}
