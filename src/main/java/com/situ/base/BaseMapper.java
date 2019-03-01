package com.situ.base;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface BaseMapper<T> {

    int insert(T t);
    
    int delete(@Param("id")Object id);
    
    int deleteModel(T t);
    
    int update(T t);

    int updateActive(T t);

    T selectId(@Param("id")Object id);

    int selectCount(T t);

    List<T> selectModel(T t);

    List<T> selectAll(T t);

}
