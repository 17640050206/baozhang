package com.erp.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;

public class StringDateConvertor implements Converter<String,Date>{

	public Date convert(String source) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			//转换成功直接返回
			return format.parse(source);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		//转换失败返回null
		return null;
	}

}
