package com.situ.mall.order.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.situ.base.FormatPage;

public class OrderModel extends FormatPage {
    private String userCode;// 用户主键
    private String shippingId;// 收货地址主键
    private String createTime;// 创建时间
    private BigDecimal payment;// 付款金额
    private Integer status;// 1=已下单 2=已付款 3=已发货 4=已退款 5=已收货 6=已评论

    private List<OrderItemModel> child = new ArrayList<>();
    
    public OrderModel() {
        super();
    }

    public OrderModel(String code, BigDecimal payment, Integer status) {
		setCode(code);
		this.payment = payment;
		this.status = status;
	}

	public OrderModel(String code, String userCode, String createTime, Integer status) {
        setCode(code);
        this.userCode = userCode;
        this.createTime = createTime;
        this.status = status;
    }

    @Override
    public String toString() {
        return super.toString() + "OrderModel [userCode=" + userCode + ", shippingId=" + shippingId + ", createTime="
                + createTime + ", payment=" + payment + ", status=" + status + "]";
    }

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode;
    }

    public String getShippingId() {
        return shippingId;
    }

    public void setShippingId(String shippingId) {
        this.shippingId = shippingId;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public BigDecimal getPayment() {
        return payment;
    }

    public void setPayment(BigDecimal payment) {
        this.payment = payment;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public List<OrderItemModel> getChild() {
        return child;
    }

    public void setChild(List<OrderItemModel> child) {
        this.child = child;
    }
}
