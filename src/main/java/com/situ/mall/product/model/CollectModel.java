package com.situ.mall.product.model;

import com.situ.base.FormatPage;

public class CollectModel extends FormatPage {

	private String productCode;
	private String createTime;

	private String productName;// 商品名
	private String unitPrice;// 单价
	private String mainPicture;// 主图

	public CollectModel() {
		super();
	}

	@Override
	public String toString() {
		return super.toString() + "Collect [productCode=" + productCode + ", createTime=" + createTime
				+ ", productName=" + productName + ", unitPrice=" + unitPrice + ", mainPicture=" + mainPicture + "]";
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getMainPicture() {
		return mainPicture;
	}

	public void setMainPicture(String mainPicture) {
		this.mainPicture = mainPicture;
	}
}
