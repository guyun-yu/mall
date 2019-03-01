package com.situ.mall.cart.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.situ.base.BaseMapper;
import com.situ.base.BaseService;
import com.situ.mall.cart.mapper.CartMapper;
import com.situ.mall.cart.model.CartModel;
import com.situ.mall.product.mapper.ProductMapper;
import com.situ.tool.Constant;

import yun.tool.FormatEmpty;

@Service
public class CartService extends BaseService<CartModel> {
    @Autowired
    private CartMapper cartMapper;
    @Autowired
    private ProductMapper productMapper;
    
    @Override
    public BaseMapper<CartModel> getMapper() {
        return cartMapper;
    }

    @Override
    public String formatModel(CartModel t) {
        if (t == null) {
            return Constant.OBJ_NULL;
        }
        String code = t.getCode();
        t.setCode(code == null ? null : code.trim());
        String productCode = t.getProductCode();
        t.setProductCode(productCode == null ? null : productCode.trim());
        return Constant.PASS;
    }

    @Override
    public String checkModel(CartModel t) {
        String msg = formatModel(t);
        if (!Constant.PASS.equals(msg)) {
            return msg;
        }
        if (FormatEmpty.isEmpty(t.getCode())) {
            return Constant.ACCOUNT_NULL;
        }
        if (FormatEmpty.isEmpty(t.getProductCode())) {
            return Constant.PRODUCT_CODE_NULL;
        }
        if (t.getQuantity() == null) {
            return Constant.QUANTITY_NULL;
        }
        return Constant.PASS;
    }

    @Override
    public String insert(CartModel t) {
        String msg = checkModel(t);
        if (!Constant.PASS.equals(msg)) {
            return msg;
        }
        List<CartModel> list = selectModel(new CartModel(t.getCode(), t.getProductCode(), null));
        if (FormatEmpty.isEmpty(list)) {
        	t.setChecked(false);
            msg = cartMapper.insert(t) > 0 ? Constant.ADD_SUCCESS : Constant.ADD_DEFEATE;
        } else {
            CartModel cm = list.get(0);
            cm.setQuantity(cm.getQuantity() + t.getQuantity());
            msg = cartMapper.updateActive(cm) > 0 ? Constant.ADD_SUCCESS : Constant.ADD_DEFEATE;
        }
        return msg;
    }

    /**
     * --判断库存
     * @param code
     * @return
     */
    public String isStockEnough(String code) {
        List<CartModel> list = cartMapper.selectAll(new CartModel(code, null, true));
        if (FormatEmpty.isEmpty(list)) {
            return Constant.CHECKED_PRODUCT_NULL;
        }
        
        for (CartModel cm : list) {
            boolean stockEnough = productMapper.selectProduct(cm.getProductCode()).getStock() >= cm.getQuantity();
            if (!stockEnough) {
                return Constant.LOW_STOCK;
            }
        }
        return Constant.PASS;
    }

    @Override
    public String canDel(Object[] ids) {
        return Constant.PASS;
    }
}
