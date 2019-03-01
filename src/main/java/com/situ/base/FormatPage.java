package com.situ.base;

public class FormatPage {
    private Integer id;
    private String code;
    private String name;
    private int pageIndex;// 当前页
    private int pageLimit;// 每页几条
    private int rowStart;// 起始行
    private int rowCount;// 总行数
    private boolean pageOn;// 是否开启分页
    private String orderBy;// 排序字段

    public FormatPage() {
        super();
    }
    
    public FormatPage(String code, String name) {
        super();
        this.code = code;
        this.name = name;
    }

    @Override
    public String toString() {
        return "FormatPage [id=" + id + ", code=" + code + ", name=" + name + ", pageIndex=" + pageIndex
                + ", pageLimit=" + pageLimit + ", rowStart=" + rowStart + ", rowCount=" + rowCount + ", pageOn="
                + pageOn + ", orderBy=" + orderBy + "]";
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public int getPageLimit() {
        return pageLimit;
    }

    public void setPageLimit(int pageLimit) {
        this.pageLimit = pageLimit;
    }

    public int getRowStart() {
        rowStart = (pageIndex - 1) * pageLimit;
        return rowStart;
    }

    public void setRowStart(int rowStart) {
        this.rowStart = rowStart;
    }

    public int getRowCount() {
        return rowCount;
    }

    public void setRowCount(int rowCount) {
        this.rowCount = rowCount;
    }

    public boolean isPageOn() {
        return pageOn;
    }

    public void setPageOn(boolean pageOn) {
        this.pageOn = pageOn;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }
}
