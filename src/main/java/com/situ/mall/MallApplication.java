package com.situ.mall;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(value= {"com.situ.mall.*.controller", "com.situ.base,com.situ.mall.*.service"})
@MapperScan(value="com.situ.mall.*.mapper")
@ServletComponentScan(value={"com.situ.base.filter", "com.situ.base.listener"})
public class MallApplication {

	public static void main(String[] args) {
		SpringApplication.run(MallApplication.class, args);
	}

}

