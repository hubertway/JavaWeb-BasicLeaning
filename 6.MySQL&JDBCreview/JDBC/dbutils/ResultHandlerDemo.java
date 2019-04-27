package dbutils;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ArrayHandler;
import org.apache.commons.dbutils.handlers.ArrayListHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import org.junit.Test;

import domain.CategoryBean;
import utils.DataSourceUtils;


public class ResultHandlerDemo {
	
	@Test
	public void arryHandler() throws Exception {
		QueryRunner qr = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT * FROM category;";
		Object[] query= qr.query(sql, new ArrayHandler());
		System.out.println(Arrays.toString(query));
	}
	
	@Test
	public void arryListHandler() throws Exception {
		QueryRunner qr = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT * FROM category;";
		List<Object[]> list= qr.query(sql, new ArrayListHandler());
		for(Object[] obj:list) {
			System.out.println(Arrays.toString(obj));
		}
	}
	
	@Test
	public void beanHandler() throws Exception {
		QueryRunner qr = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT * FROM category;";
		CategoryBean bean = qr.query(sql, new BeanHandler<>(CategoryBean.class));
		System.out.println(bean);
	}
	
	@Test
	public void beanListHandler() throws Exception {
		QueryRunner qr = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT * FROM category;";
		List<CategoryBean> list = qr.query(sql, new BeanListHandler<>(CategoryBean.class));
		for(CategoryBean bean:list) {
			System.out.println(bean);
		}
	}
	
	@Test
	public void mapHandler() throws Exception {
		QueryRunner qr = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT * FROM category;";
		Map<String, Object> map=qr.query(sql, new MapHandler());
		System.out.println(map);
	}
	
	@Test
	public void mapListHandler() throws Exception {
		QueryRunner qr = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT * FROM category;";
		List<Map<String, Object>>list=qr.query(sql, new MapListHandler());
		for(Map<String, Object> map:list) {
			System.out.println(map);
		}
	}
	
	@Test
	public void scalarHandler() throws Exception {
		QueryRunner qr = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT COUNT(*) FROM category;";
		Object obj=qr.query(sql, new ScalarHandler());
		System.out.println(obj+" "+obj.getClass().getName());
	}
	
}
