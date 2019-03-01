package com.situ.mall.product.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.situ.base.BaseMapper;
import com.situ.base.BaseService;
import com.situ.mall.product.mapper.ProductImgMapper;
import com.situ.mall.product.model.ProductImgModel;
import com.situ.tool.Constant;

import yun.tool.FormatEmpty;

@Service
public class ProductImgService extends BaseService<ProductImgModel> {
    @Autowired
    private ProductImgMapper productImgMapper;
    
    @Override
    public BaseMapper<ProductImgModel> getMapper() {
        return productImgMapper;
    }
    
    /**
     * --设置主图
     * @param t
     * @return
     */
    public String setMain(ProductImgModel t) {
        String msg = checkModel(t);
        if (!Constant.PASS.equals(msg)) {
            return msg;
        }
        List<ProductImgModel> list = productImgMapper.selectAll(new ProductImgModel(t.getCode(), null, null));
        for (ProductImgModel pim : list) {
            if (Constant.MAIN_IMG.equals(pim.getType())) {
                pim.setType(Constant.ORTHER_IMG);
            } else if (t.getName().equals(pim.getName())) {
                pim.setType(Constant.MAIN_IMG);
            } else {
                continue;
            }
            productImgMapper.updateActive(pim);
        }
        return Constant.UPD_SUCCESS;
    }

    @Override
    public String formatModel(ProductImgModel t) {
        if (t == null) {
            return Constant.OBJ_NULL;
        }
        String code = t.getCode();
        t.setCode(code == null ? null : code.trim());
        String name = t.getName();
        t.setName(name == null ? null : name.trim());
        return Constant.PASS;
    }

    @Override
    public String checkModel(ProductImgModel t) {
        String msg = formatModel(t);
        if (Constant.OBJ_NULL.equals(msg)) {
            return msg;
        }
        if (FormatEmpty.isEmpty(t.getCode())) {
            return Constant.CODE_NULL;
        }
        if (FormatEmpty.isEmpty(t.getName())) {
            return Constant.NAME_NULL;
        }
        if (t.getType() == null) {
            return Constant.TYPE_NULL;
        }
        return Constant.PASS;
    }

    @Override
    public String canDel(Object[] ids) {
        for (Object id : ids) {
            ProductImgModel pim = productImgMapper.selectModel(new ProductImgModel(null, id.toString(), null)).get(0);
            if (pim.getType() == 1) {
                return Constant.CAN_NOT_DEL_MAIN_IMG;
            }
        }
        return Constant.PASS;
    }

    /**
     * --删除数据时，同时删除本地文件
     * @param id
     * @return
     */
    public String delete(Object id) {
        if (FormatEmpty.isEmpty(id)) {
            return Constant.CODE_NULL;
        }
        String msg = canDel(new Object[] {id});
        if (!Constant.PASS.equals(msg)) {
            return msg;
        }
        msg = getMapper().deleteModel(new ProductImgModel(null, id.toString(), null)) > 0 ? 
                Constant.DEL_SUCCESS : Constant.DEL_DEFEATE;
        if (Constant.DEL_SUCCESS.equals(msg)) {
            File fiel = new File(PATH + id.toString());
            if (fiel.exists()) {
                fiel.delete();
            }
        }
        return msg;
    }
    
    private static final String PATH = "H:/image/productImg/";
}
