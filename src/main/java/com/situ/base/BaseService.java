package com.situ.base;

import java.util.List;

import com.situ.tool.Constant;

import yun.tool.FormatEmpty;

public abstract class BaseService<T extends FormatPage> {
    public abstract BaseMapper<T> getMapper();

    public String insert(T t) {
        String msg = checkModel(t);
        if (Constant.PASS.equals(msg)) {
            if (selectId(t.getCode()) != null) {
                return Constant.CODE_REPEAT;
            }
            return getMapper().insert(t) > 0 ? Constant.ADD_SUCCESS : Constant.ADD_DEFEATE;
        }
        return msg;
    }
    
    public String delete(String...codes) {
        if (FormatEmpty.isEmpty(codes)) {
            return Constant.CODE_NULL;
        }
        String msg = canDel(codes);
        if (!Constant.PASS.equals(msg)) {
            return msg;
        }
        StringBuffer code = new StringBuffer("('");
        code.append(codes[0]).append("'");
        for (int i = 1; i < codes.length; i++) {
            code.append(",'").append(codes[i]).append("'");
        }
        code.append(")");
        return getMapper().delete(code.toString()) == codes.length ? Constant.DEL_SUCCESS : Constant.DEL_DEFEATE;
    }
    
    public String deleteModel(T t) {
        String msg = formatModel(t);
        if (Constant.PASS.equals(msg)) {
            return getMapper().deleteModel(t) > 0 ? Constant.DEL_SUCCESS : Constant.DEL_DEFEATE;
        }
        return msg;
    }
    
    public String update(T t) {
        String msg = checkModel(t);
        if (Constant.PASS.equals(msg)) {
            return getMapper().update(t) > 0 ? Constant.UPD_SUCCESS : Constant.UPD_DEFEATE;
        }
        return msg;
    }
    
    public String updateActive(T t) {
        String msg = formatModel(t);
        if (Constant.PASS.equals(msg)) {
            return getMapper().updateActive(t) > 0 ? Constant.UPD_SUCCESS : Constant.UPD_DEFEATE;
        }
        return msg;
    }
    
    /**
     * @param id
     * @return T 或 null
     */
    public T selectId(Object id) {
        if (FormatEmpty.isEmpty(id)) {
            return null;
        }
        return getMapper().selectId(id);
    }
    
    /**
     * @param t
     * @return -1=OBJ_NULL
     */
    public int selectCount(T t) {
        String msg = formatModel(t);
        if (Constant.OBJ_NULL.equals(msg)) {
            return -1;
        }
        return getMapper().selectCount(t);
    }
    
    /**
     * @param t
     * @return list 或 null
     */
    public List<T> selectModel(T t) {
        String msg = formatModel(t);
        if (Constant.OBJ_NULL.equals(msg)) {
            return null;
        }
        return getMapper().selectModel(t);
    }
    
    public List<T> selectAll(T t) {
        return getMapper().selectAll(t);
    }

    /**
     * --格式数据，清除字符串两端空格
     * @param t
     * @return Constant
     */
    public abstract String formatModel(T t);

    /**
     * --检查数据是否合法
     * @param t
     * @return 合法=Constant.PASS
     */
    public abstract String checkModel(T t);
    
    /**
     * --判断是否可以删除
     * @param ids
     * @return 可以=Constant.PASS
     */
    public abstract String canDel(Object[] ids);
}
