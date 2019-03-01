package com.situ.mall.product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.situ.base.BaseController;
import com.situ.base.BaseService;
import com.situ.mall.product.model.CollectModel;
import com.situ.mall.product.service.CollectService;

@Controller
@RequestMapping("/collect")
public class CollectController extends BaseController<CollectModel> {
	@Autowired
	private CollectService collectService;

	@Override
	public BaseService<CollectModel> getService() {
		return collectService;
	}

	@Override
	public String getForwadUrl() {
		return "/404";
	}

	@Override
	public String getOrderBy() {
		return "create_time";
	}

}
