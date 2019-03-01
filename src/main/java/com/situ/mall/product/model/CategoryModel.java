package com.situ.mall.product.model;

import com.situ.mall.sys.model.DictModel;

public class CategoryModel extends DictModel {
    private String category1;// 1级分类编号
    private String category2;// 2级分类编号
    private String cate1Name;
    private String cate2Name;

    public CategoryModel() {
        super();
    }

    @Override
    public String toString() {
        return super.toString() + "CategoryModel [category1=" + category1 + ", category2=" + category2 + ", cate1Name="
                + cate1Name + ", cate2Name=" + cate2Name + "]";
    }

    public String getCategory1() {
        return category1;
    }

    public void setCategory1(String category1) {
        this.category1 = category1;
    }

    public String getCategory2() {
        return category2;
    }

    public void setCategory2(String category2) {
        this.category2 = category2;
    }

    public String getCate1Name() {
        return cate1Name;
    }

    public void setCate1Name(String cate1Name) {
        this.cate1Name = cate1Name;
    }

    public String getCate2Name() {
        return cate2Name;
    }

    public void setCate2Name(String cate2Name) {
        this.cate2Name = cate2Name;
    }
}
