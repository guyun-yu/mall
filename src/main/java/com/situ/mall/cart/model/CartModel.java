package com.situ.mall.cart.model;

import java.math.BigDecimal;

import com.situ.base.FormatPage;

public class CartModel extends FormatPage {
    private String productCode;// 商品主键
    private Integer quantity;// 数量
    private Boolean checked;// 是否选中

    private String productName;// 商品名字
    private String descr;// 商品描述
    private BigDecimal unitPrice;// 单价
    private String mainPicture;// 商品主图

    public CartModel() {
        super();
    }

    public CartModel(String code, String productCode, Boolean checked) {
        setCode(code);
        this.productCode = productCode;
        this.checked = checked;
    }

    @Override
    public String toString() {
        return super.toString() + "CartModel [productCode=" + productCode + ", quantity=" + quantity + ", checked="
                + checked + ", productName=" + productName + ", descr=" + descr + ", unitPrice=" + unitPrice
                + ", mainPicture=" + mainPicture + "]";
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Boolean getChecked() {
        return checked;
    }

    public void setChecked(Boolean checked) {
        this.checked = checked;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getMainPicture() {
        return mainPicture;
    }

    public void setMainPicture(String mainPicture) {
        this.mainPicture = mainPicture;
    }
}
