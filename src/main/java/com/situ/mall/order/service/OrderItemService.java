package com.situ.mall.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.situ.base.BaseMapper;
import com.situ.base.BaseService;
import com.situ.mall.order.mapper.OrderItemMapper;
import com.situ.mall.order.model.OrderItemModel;
import com.situ.mall.product.mapper.ProductMapper;
import com.situ.mall.product.model.ProductModel;
import com.situ.tool.Constant;

import yun.tool.FormatEmpty;

@Service
public class OrderItemService extends BaseService<OrderItemModel> {
    @Autowired
    private OrderItemMapper orderItemMapper;
    @Autowired
    private ProductMapper productMapper;

    @Override
    public BaseMapper<OrderItemModel> getMapper() {
        return orderItemMapper;
    }
    
    @Override
    public String insert(OrderItemModel t) {
        String msg = checkModel(t);
        if (!Constant.PASS.equals(msg)) {
            return msg;
        }
        
        ProductModel pm = productMapper.selectId(t.getProductCode());
        if (pm == null) {
            return Constant.PRODUCT_NOT_EXIST;
        }
        if (t.getQuantity() > pm.getStock()) {
            return Constant.LOW_STOCK;
        }
        
        List<OrderItemModel> list = orderItemMapper.selectModel(
                new OrderItemModel(t.getOrderCode(), t.getProductCode(), null, t.getUnitPrice()));
        pm.setStock(pm.getStock() - t.getQuantity());
        if (list.isEmpty()) {
            t.setUnitPrice(pm.getUnitPrice());
            msg =  orderItemMapper.insert(t) > 0 ? Constant.ADD_SUCCESS : Constant.ADD_DEFEATE;
        } else {
            OrderItemModel oim = list.get(0);
            oim.setQuantity(t.getQuantity() + oim.getQuantity());
            msg = orderItemMapper.updateActive(oim) > 0 ? Constant.ADD_SUCCESS : Constant.ADD_DEFEATE;
        }
        if (Constant.ADD_SUCCESS.equals(msg)) {
            productMapper.updateActive(pm);
        }
        return msg;
    }

    @Override
    public String formatModel(OrderItemModel t) {
        if (t == null) {
            return Constant.OBJ_NULL;
        }
        String orderCode = t.getOrderCode();
        t.setOrderCode(orderCode == null ? null : orderCode.trim());
        String productCode = t.getProductCode();
        t.setProductCode(productCode == null ? null : productCode.trim());
        return Constant.PASS;
    }

    @Override
    public String checkModel(OrderItemModel t) {
        String msg = formatModel(t);
        if (!Constant.PASS.equals(msg)) {
            return msg;
        }
        if (FormatEmpty.isEmpty(t.getOrderCode())) {
            return Constant.ORDER_CODE_NULL;
        }
        if (FormatEmpty.isEmpty(t.getProductCode())) {
            return Constant.PRODUCT_CODE_NULL;
        }
        return Constant.PASS;
    }

    @Override
    public String canDel(Object[] ids) {
        return Constant.PASS;
    }

}
