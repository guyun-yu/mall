package com.situ.mall.product.service;

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
public class ProductService extends BaseService<ProductModel> {
    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private OrderItemMapper orderItemMapper;
    
    @Override
    public BaseMapper<ProductModel> getMapper() {
        return productMapper;
    }

    @Override
    public String formatModel(ProductModel pm) {
        if (pm == null) {
            return Constant.OBJ_NULL;
        }
        String code = pm.getCode();
        pm.setCode(code == null ? null : code.trim());
        String name = pm.getName();
        pm.setName(name == null ? null : name.trim());
        String descr = pm.getDescr();
        pm.setDescr(descr == null ? null : descr.trim());
        String dictCode = pm.getDictCode();
        pm.setDictCode(dictCode == null ? null : dictCode.trim());
        return Constant.PASS;
    }

    @Override
    public String checkModel(ProductModel pm) {
        String msg = formatModel(pm);
        if (Constant.OBJ_NULL.equals(msg)) {
            return msg;
        }
        if (FormatEmpty.isEmpty(pm.getCode())) {
            return Constant.CODE_NULL;
        }
        if (FormatEmpty.isEmpty(pm.getName())) {
            return Constant.NAME_NULL;
        }
        if (FormatEmpty.isEmpty(pm.getDictCode())) {
            return Constant.CATEGORY_NULL;
        }
        if (pm.getUnitPrice() == null) {
            return Constant.PRICE_NULL;
        }
        if (pm.getStock() == null) {
            return Constant.STOCK_NULL;
        }
        if (pm.getStatus() == null) {
            return Constant.STATUS_NULL;
        }
        return Constant.PASS;
    }

    /**
     * --查询某件商品详细信息
     * @param code
     * @return
     */
    public ProductModel selectProduct(String code) {
        if (FormatEmpty.isEmpty(code)) {
            return null;
        }
        ProductModel pm = productMapper.selectProduct(code);
        productMapper.updateActive(new ProductModel(pm.getCode(), pm.getClickQuantity() + 1, null));// 修改点击量
        return pm;
    }

    @Override
    public String canDel(Object[] ids) {
        for (Object id : ids) {
            if (orderItemMapper.selectCount(new OrderItemModel(null, id.toString(), null, null)) > 0) {
                return Constant.CAN_NOT_DEL_EXIST_ORDER;
            }
        }
        return Constant.PASS;
    }

	/**
	 * --查询高点击量商品
	 * @param pm
	 * @return
	 */
	public List<ProductModel> selectHotProduct(ProductModel pm) {
		String msg = formatModel(pm);
		if (!Constant.PASS.equals(msg)) {
			return null;
		}
		pm.setPageOn(true);
        pm.setOrderBy("click_quantity desc");
		return productMapper.selectModel(pm);
	}
}
