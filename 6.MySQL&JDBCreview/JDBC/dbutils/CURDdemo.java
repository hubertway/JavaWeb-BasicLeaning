package dbutils;

import org.apache.commons.dbutils.QueryRunner;
import org.junit.Test;

import utils.DataSourceUtils;

public class CURDdemo {
	
	@Test
	public void insert() throws Exception {
		//创建QueryRunner类
		QueryRunner qr = new QueryRunner(DataSourceUtils.getDataSource());
		//编写sql
		String sql = "INSERT INTO category VALUES(?,?);";
		//执行sql
		qr.update(sql, "c201","厨电");
	}
	
	@Test
	public void update() throws Exception {
		QueryRunner qr = new QueryRunner(DataSourceUtils.getDataSource());
		String sql="update category set cname=? where cid=?;";
		qr.update(sql, "平板电脑","c001");
	}
}
