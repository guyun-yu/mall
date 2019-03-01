package com.situ.mall.sys.model;

import java.util.ArrayList;
import java.util.List;

import com.situ.base.FormatPage;

public class DictModel extends FormatPage {
    private String descr;
    private String parentCode;
    private Integer type;
    
    private List<DictModel> child = new ArrayList<>();

    public DictModel() {
        super();
    }
    
    public DictModel(String code, String name, String parentCode) {
    	super(code, name);
    	this.parentCode = parentCode;
    }
    
    public DictModel(String descr, String parentCode) {
        super();
        this.descr = descr;
        this.parentCode = parentCode;
    }

    @Override
    public String toString() {
        return super.toString() + "DictModel [descr=" + descr + ", parentCode=" + parentCode + ", type=" + type 
                + ", child=" + child + "]";
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

    public String getParentCode() {
        return parentCode;
    }

    public void setParentCode(String parentCode) {
        this.parentCode = parentCode;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public List<DictModel> getChild() {
        return child;
    }

    public void setChild(List<DictModel> child) {
        this.child = child;
    }
}
