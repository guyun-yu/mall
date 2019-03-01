package com.situ.mall;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.situ.tool.Constant;

@RunWith(SpringRunner.class)
@SpringBootTest
public class MallApplicationTests {

	@Test
	public void contextLoads() {
		System.out.println(Constant.getMessage(Constant.PASS));
	}

}

