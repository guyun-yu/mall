package com.situ.mall.order.model;

import java.math.BigDecimal;

import com.situ.base.FormatPage;

public class OrderItemModel extends FormatPage {
    private String orderCode;// 订单主键
    private String productCode;// 商品主键
    private Integer quantity;// 数量
    private BigDecimal unitPrice;// 单价

    private BigDecimal totalPrice;
    private String productName;
    private String productDescr;
    private String imgName;

    public OrderItemModel() {
        super();
    }

    public OrderItemModel(String orderCode, String productCode, Integer quantity,  BigDecimal unitPrice) {
        super();
        this.orderCode = orderCode;
        this.productCode = productCode;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    @Override
    public String toString() {
        return super.toString() + "OrderItemModel [orderCode=" + orderCode + ", productCode=" + productCode
                + ", quantity=" + quantity + ", unitPrice=" + unitPrice + ", totalPrice=" + totalPrice + "]";
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
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

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public BigDecimal getTotalPrice() {
        return unitPrice.multiply(new BigDecimal(quantity));
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductDescr() {
        return productDescr;
    }

    public void setProductDescr(String productDescr) {
        this.productDescr = productDescr;
    }

    public String getImgName() {
        return imgName;
    }

    public void setImgName(String imgName) {
        this.imgName = imgName;
    }

}
