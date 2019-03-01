package com.situ.mall.product.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.situ.base.FormatPage;

public class ProductModel extends FormatPage {
    private BigDecimal unitPrice;
    private String descr;
    private Integer stock;// 库存
    private Integer status;// 状态 1=上架 2=下架 3=未发布 4=缺货
    private String dictCode;// 分类编号
    private Integer clickQuantity;// 点击量
    private Integer sales;// 销量
    
    private String category1;// 1级分类
    private String category2;// 2级分类
    private String mainPicture;
    private List<ProductImgModel> imgs = new ArrayList<>();

    public ProductModel() {
        super();
    }

    public ProductModel(String code, Integer clickQuantity, Integer sales) {
		setCode(code);
		this.clickQuantity = clickQuantity;
		this.sales = sales;
	}

	@Override
	public String toString() {
		return super.toString() + "ProductModel [unitPrice=" + unitPrice + ", descr=" + descr + ", stock=" + stock
				+ ", status=" + status + ", dictCode=" + dictCode + ", clickQuantity=" + clickQuantity + ", sales="
				+ sales + ", category1=" + category1 + ", category2=" + category2 + ", mainPicture=" + mainPicture
				+ ", imgs=" + imgs + "]";
	}

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getDictCode() {
        return dictCode;
    }

    public void setDictCode(String dictCode) {
        this.dictCode = dictCode;
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

    public String getMainPicture() {
        return mainPicture;
    }

    public void setMainPicture(String mainPicture) {
        this.mainPicture = mainPicture;
    }

    public List<ProductImgModel> getImgs() {
        return imgs;
    }

    public void setImgs(List<ProductImgModel> imgs) {
        this.imgs = imgs;
    }

	public Integer getClickQuantity() {
		return clickQuantity;
	}

	public void setClickQuantity(Integer clickQuantity) {
		this.clickQuantity = clickQuantity;
	}

	public Integer getSales() {
		return sales;
	}

	public void setSales(Integer sales) {
		this.sales = sales;
	}
}
