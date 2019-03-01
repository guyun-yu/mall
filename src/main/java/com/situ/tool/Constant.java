package com.situ.tool;

import java.util.ResourceBundle;

/**
 * --常量类
 */
public class Constant {
    // 1000=对象为空，1024=通过
    public static final String OBJ_NULL =  "1000";
    public static final String PASS =  "1024";
    /*
     * 2001=账号为空，2002=密码为空，2003=权限为空，2004=数量为空，2005=未选中商品
     * 2006=编号为空，2007=名称为空，2008=url为空，2009=未分类，2010=价格为空
     * 2011=库存为空，2012=状态为空，2013=类型为空，2014=创建时间为空，2015=收货地址为空
     * 2016=订单主键为空，2017=商品主键为空
     */
    public static final String ACCOUNT_NULL = "2001";
    public static final String PASSWORD_NULL = "2002";
    public static final String ROLE_NULL = "2003";
    public static final String QUANTITY_NULL = "2004";
    public static final String CHECKED_PRODUCT_NULL = "2005";
    public static final String CODE_NULL = "2006";
    public static final String NAME_NULL = "2007";
    public static final String URL_NULL = "2008";
    public static final String CATEGORY_NULL = "2009";
    public static final String PRICE_NULL = "2010";
    public static final String STOCK_NULL = "2011";
    public static final String STATUS_NULL = "2012";
    public static final String TYPE_NULL = "2013";
    public static final String CREATE_TIME_NULL = "2014";
    public static final String SHIPPING_ID_NULL = "2015";
    public static final String ORDER_CODE_NULL = "2016";
    public static final String PRODUCT_CODE_NULL = "2017";
    // 3001=添加成功，3002=添加失败，3003=登陆成功
    public static final String ADD_SUCCESS = "3001";
    public static final String ADD_DEFEATE = "3002";
    public static final String LOGIN_SUCCESS = "3003";
    /*
     * 4001=删除成功，4002=删除失败，4003=无法删除，4004=主图无法删除，4005=超级管理员无法删除
     * 4006=该分类下存在子分类，无法删除，4007=该分类下有商品，无法删除
     * 4008=订单中存在该商品，无法删除
     */
    public static final String DEL_SUCCESS = "4001";
    public static final String DEL_DEFEATE = "4002";
    public static final String CAN_NOT_DEL = "4003";
    public static final String CAN_NOT_DEL_MAIN_IMG = "4004";
    public static final String CAN_NOT_DEL_ADMIN = "4005";
    public static final String CAN_NOT_DEL_EXIST_CHILD = "4006";
    public static final String CAN_NOT_DEL_EXIST_PRODUCT = "4007";
    public static final String CAN_NOT_DEL_EXIST_ORDER = "4008";
    // 5001=修改成功，5002=修改失败
    public static final String UPD_SUCCESS = "5001";
    public static final String UPD_DEFEATE = "5002";
    /*
     * 6001=编号重复，6002=两次输入密码不同，6003=存在子分类，6004=产品不存在，6005=库存不足
     * 6006=验证码错误，6007=账号不存在，6008=密码错误， 6009=手机号错误，6010=商品已收藏
     */
    public static final String CODE_REPEAT = "6001";
    public static final String PASSWORD_NOT_SAME = "6002";
    public static final String EXIST_CHILD = "6003";
    public static final String PRODUCT_NOT_EXIST = "6004";
    public static final String LOW_STOCK = "6005";
    public static final String AUTH_CODE_ERROR = "6006";
    public static final String ACCOUNT_NOT_EXIST = "6007";
    public static final String PASSWORD_ERROR = "6008";
    public static final String PHONE_ERROR = "6009";
    public static final String COLLECT_EXIST = "6010";
    // 9000=预设编号
    public static final String PRESET_CODE = "9000";
    
    public static final Integer MAIN_IMG = 1;
    public static final Integer ORTHER_IMG = 2;
    
    private static final ResourceBundle RES = ResourceBundle.getBundle("prop");
    
    public static String getMessage(String msg) {
        return RES.getString(msg);
    }
    
    private Constant() {}
//    public static void main(String[] args) {
//        System.out.println(map);
//    }
}
