package com.situ.mall.order.mapper;

import java.util.List;

import com.situ.base.BaseMapper;
import com.situ.mall.order.model.OrderModel;

public interface OrderMapper extends BaseMapper<OrderModel> {

    /**
     * --3表关联，查出订单及对应的订单商品，和相应的商品信息
     * @param t
     * @return
     */
    List<OrderModel> selectOrder(OrderModel t);

}
