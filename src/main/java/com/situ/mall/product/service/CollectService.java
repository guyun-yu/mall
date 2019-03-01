package com.situ.mall.product.service;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.situ.base.BaseMapper;
import com.situ.base.BaseService;
import com.situ.mall.product.mapper.CollectMapper;
import com.situ.mall.product.model.CollectModel;
import com.situ.tool.Constant;

import yun.tool.FormatDate;
import yun.tool.FormatEmpty;

@Service
public class CollectService extends BaseService<CollectModel> {
	@Autowired
	private CollectMapper collectMapper;

	@Override
	public BaseMapper<CollectModel> getMapper() {
		return collectMapper;
	}

	@Override
	public String formatModel(CollectModel t) {
		if (t == null) {
			return Constant.OBJ_NULL;
		}
		String code = t.getCode();
		t.setCode(code == null ? null : code.trim());
		String productCode = t.getProductCode();
		t.setProductCode(productCode == null ? null : productCode.trim());
		String createTime = t.getCreateTime();
		t.setCreateTime(createTime == null ? null : createTime.trim());
		return Constant.PASS;
	}

	@Override
	public String checkModel(CollectModel t) {
		String msg = formatModel(t);
		if (!Constant.PASS.equals(msg)) {
			return msg;
		}
		if (FormatEmpty.isEmpty(t.getCode())) {
			return Constant.CODE_NULL;
		}
		if (FormatEmpty.isEmpty(t.getProductCode())) {
			return Constant.PRODUCT_CODE_NULL;
		}
		return Constant.PASS;
	}

	@Override
	public String canDel(Object[] id) {
		return Constant.PASS;
	}

	public String insert(CollectModel t) {
		String msg = checkModel(t);
		if (Constant.PASS.equals(msg)) {
			if (!FormatEmpty.isEmpty(selectModel(t))) {
				return Constant.COLLECT_EXIST;
			}
			t.setCreateTime(FormatDate.formatDateTime(LocalDateTime.now()));
			return getMapper().insert(t) > 0 ? Constant.ADD_SUCCESS : Constant.ADD_DEFEATE;
		}
		return msg;
	}
}
