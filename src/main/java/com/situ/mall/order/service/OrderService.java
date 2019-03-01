package com.situ.mall.order.service;


import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.situ.base.BaseMapper;
import com.situ.base.BaseService;
import com.situ.mall.cart.mapper.CartMapper;
import com.situ.mall.cart.model.CartModel;
import com.situ.mall.order.mapper.OrderItemMapper;
import com.situ.mall.order.mapper.OrderMapper;
import com.situ.mall.order.model.OrderItemModel;
import com.situ.mall.order.model.OrderModel;
import com.situ.mall.product.mapper.ProductMapper;
import com.situ.mall.product.model.ProductModel;
import com.situ.tool.Constant;

import yun.tool.FormatDate;
import yun.tool.FormatEmpty;

@Service
public class OrderService extends BaseService<OrderModel> {
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private CartMapper cartMapper;
    @Autowired
    private OrderItemMapper orderItemMapper;
    @Autowired
    private ProductMapper productMapper;

    @Override
    public BaseMapper<OrderModel> getMapper() {
        return orderMapper;
    }

    @Override
    public String formatModel(OrderModel t) {
        if (t == null) {
            return Constant.OBJ_NULL;
        }
        String code = t.getCode();
        t.setCode(code == null ? null : code.trim());
        String userCode = t.getUserCode();
        t.setUserCode(userCode == null ? null : userCode.trim());
        String createTime = t.getCreateTime();
        t.setCreateTime(createTime == null ? null : createTime.trim());
        String shippingId = t.getShippingId();
        t.setShippingId(shippingId == null ? null : shippingId.trim());
        return Constant.PASS;
    }

    @Override
    public String checkModel(OrderModel t) {
        String msg = formatModel(t);
        if (!Constant.PASS.equals(msg)) {
            return msg;
        }
        if (FormatEmpty.isEmpty(t.getCode())) {
            return Constant.CODE_NULL;
        }
        if (FormatEmpty.isEmpty(t.getUserCode())) {
            return Constant.ACCOUNT_NULL;
        }
        if (FormatEmpty.isEmpty(t.getCreateTime())) {
            return Constant.CREATE_TIME_NULL;
        }
        if (FormatEmpty.isEmpty(t.getShippingId())) {
            return Constant.SHIPPING_ID_NULL;
        }
        if (t.getStatus() == null) {
            return Constant.STATUS_NULL;
        }
        return Constant.PASS;
    }

    /**
     * --创建订单
     * @param userCode
     */
    public void createOrder(String userCode) {
        String code = UUID.randomUUID().toString();
        String createTime = FormatDate.formatDateTime(LocalDateTime.now());
        orderMapper.insert(new OrderModel(code, userCode, createTime, 1));// 创建订单
        
        CartModel cart = new CartModel(userCode, null, true);
        List<CartModel> cartList = cartMapper.selectAll(cart);
        for (CartModel cm : cartList) {
        	// 订单项添加商品
            orderItemMapper.insert(new OrderItemModel(code, cm.getProductCode(), cm.getQuantity(), cm.getUnitPrice()));
            
            ProductModel pm = productMapper.selectId(cm.getProductCode());
            pm.setStock(pm.getStock() - cm.getQuantity());
            pm.setSales(pm.getSales() + 1);
            productMapper.updateActive(pm);// 修改库存、销量
        }
        cartMapper.deleteModel(cart);// 删除购物车记录
    }

    public List<OrderModel> selectOrder(OrderModel t) {
        if (Constant.OBJ_NULL.equals(formatModel(t))) {
            return null;
        }
        return orderMapper.selectOrder(t);
    }

    @Override
    public String canDel(Object[] ids) {
        for (Object id : ids) {
            OrderItemModel oim = new OrderItemModel();
            oim.setOrderCode(id.toString());
            if (orderItemMapper.selectCount(oim) > 0) {
                return Constant.CAN_NOT_DEL;
            } 
        }
        return Constant.PASS;
    }

	/**
	 * --模拟付款
	 * @param code
	 * @return
	 */
	public String pay(String code) {
		BigDecimal sum = new BigDecimal(0);
		for (OrderItemModel t : orderItemMapper.selectAll(new OrderItemModel(code, null, null, null))) {
			sum = sum.add(t.getTotalPrice());
		}
		int result = orderMapper.updateActive(new OrderModel(code, sum, 2));
		return result > 0 ? Constant.UPD_SUCCESS : Constant.UPD_DEFEATE;
	}
}
