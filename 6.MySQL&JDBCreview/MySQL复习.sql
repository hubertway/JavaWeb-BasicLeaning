数据库:
	本质上就是一个文件系统.通过标准的sql对数据进行curd操作
安装 数据库管理系统:
	数据库管理系统大白话就是一个软件
常见的关系型数据库:
	关系型数据库:
		存放实体与实体之间的关系的数据库(就是二维表)
		实体:
			用户 	订单	商品
		关系:
			用户拥有订单
			订单包含商品
	非关系型数据库:存放的是对象(redis) NO-sql(not only sql)
	
	软件名		厂商		特点
	mysql		oracle		开源的数据库
	oracle		oracle		大型的收费的数据库
	DB2			IBM			大型的收费的数据库
	sqlserver	微软		中大型的收费的数据库
	sybase		sybase(powerdesigner)

安装了数据库管理系统的计算机称之为数据库服务器
	服务器:给别人提供提供服务器(软件服务器)
我们可以通过标准的sql在服务器创建数据库(database)
有了数据库之后,就可以在数据库上创建表了
有了表之后,就可以在里面存放数据了.
SQL:
	结构化查询语句
	作用:
		管理数据库.
sql的分类:
	DDL:数据定义语言
		操作对象:数据库和表
		关键词:create alter drop
	DML:数据操作语言
		操作对象:记录
	DQL:数据查询语言(非官方)
	DCL:数据控制语言
		操作对象:用户 事务 权限
/////////////////////////////
登录数据库:
	mysql -uroot  -p密码
DDL:数据定义语言
		操作对象:数据库和表
		关键词:create alter drop	
	操作数据库:
		创建:
			格式:
				create database 数据库名称;
		删除:
			格式:
				drop database 数据库名称;
		常用的命令:
			查看所有的数据库: show databases;
	操作表:
		创建表
			格式:
				create table 表名(字段描述,字段描述);
				字段描述:
					字段名称 字段类型 [约束]
				例如:
					create table user(
						id int primary key auto_increment,
						username varchar(20)
					);
					
					create table user1(
						id int primary key auto_increment,
						username varchar(20)
					);
		修改表
			格式:
				alter table 表名 ....
			修改表名:
				alter table 旧表名 rename to 新表名;
				例如:
					alter table user1 rename to user10;
			添加字段:
				alter table 表名 add [column] 字段描述;
				例如:
					alter table user add password varchar(20);
			修改字段名:
				alter table 表名 change 字段名称 新字段描述;
				例如:
					alter table user change password pwd varchar(20);
			修改字段描述:
				alter table 表名 modify 字段名称 字段类型 [约束];
				例如:
					alter table user modify pwd int;
			删除字段:
				alter table 表名 drop 字段名;
				例如:
					alter table user drop pwd;
			
		删除表:
			格式:
				drop table 表名;
				
		常用命令:
			切换或者进入数据库: use 数据库名称;
			查看当前数据库下所有表: show tables;
			查看表结构:desc 表名;
			查看建表语句:show create table 表名;
/////////////////////////////////////////////////
DML:数据操作语言
	操作对象:记录(行)
	关键词:insert update delete
	插入:
		格式1:
			insert into 表名 values(字段值1,字段值2...,字段值n);
			注意:
				默认插入全部字段,
				必须保证values后面的内容的类型和顺序和表结构中的一致
				若字段类型为数字,可以省略引号
			例如:
				insert into user values(1,'tom');
				insert into user values('2','tom');
				insert into user values('3');-- 错误的  
		
		格式2:
			insert into 表名(字段名,字段名1...) values(字段值,字段值1...);
			注意:
				插入指定的字段
				必须保证values后面的内容的类型和顺序和表名后面的字段的类型和顺序保持一致.
			例如:
				insert into user (username,id) values('jack',4);
				insert into user (username) values('jack',5);-- 错误的
			
	修改:
		格式:
			update 表名 set 字段名=字段值,字段名1=字段值1... [where 条件];
		例如:
			update user set username='jerry' where username='jack';
	删除:
		格式:
			delete from 表名 [where 条件];
		例如:
			delete from user where id = '2';
///////////////////////////////////
DQL:数据查询语言
		关键词:select
	格式:
		select ... from 表名 where 条件 group by 分组字段 having 条件 order by 排序字段 ase|desc
	
	初始化环境:
		-- 创建商品表
		create table products(
			pid int primary key auto_increment,
			pname varchar(20),
			price double,
			pnum int,
			cno int,
			pdate timestamp
		);

		insert into products values (null,'泰国大榴莲',98,12,1,null);
		insert into products values (null,'新疆大枣',38,123,1,null);
		insert into products values (null,'新疆切糕',68,50,2,null);
		insert into products values (null,'十三香',10,200,3,null);
		insert into products values (null,'老干妈',20,180,3,null);
		insert into products values (null,'豌豆黄',20,120,2,null);
	练习:
		简单查询:
		练习:
		1.查询所有的商品
			select * from products;
		2.查询商品名和商品价格.
			-- 查看指定的字段 
			-- 格式: select 字段名1,字段名2 from 表名
			select pname,price from products;
		3.查询所有商品都有那些价格.
			-- 去重操作 distinct
			-- 格式: select distinct 字段名,字段名2 from 表名
			select price from products;
			select distinct price from products;
		4.将所有商品的价格+10元进行显示.(别名)
			-- 可以在查询的结果之上进行运算,不影响数据库中的值
			-- 给列起别名 格式: 字段名 [as] 别名
			select price+10 from products;
			select price+10 新价格 from products;
			select price+10 '新价格' from products;
			select price+10 新 价 格 from products;-- 错误
			select price+10 '新 价 格' from products;
			select price+10 `新 价 格` from products;


		条件查询:
		练习:
		1.查询商品名称为十三香的商品所有信息：
			select * from products where pname = '十三香';
		2.查询商品价格>60元的所有的商品信息:
			select * from products where price>60;
		3.查询商品名称中包含”新”的商品
			-- 模糊匹配 
			--	格式: 字段名 like "匹配规则";
			--		匹配内容 %
							"龙"	值为龙
							"%龙"	值以"龙"结尾
							"龙%"	值以"龙"开头
							"%龙%" 	值包含"龙"
			--		匹配个数 "__" 占两个位置
			
			select * from products where pname like "%新%";
		4.查询价格为38,68,98的商品
			select * from products where price = 38 or price = 68 or price=98;
			select * from products where price in(38,68,98);
			
			where后的条件写法：
				* > ,<,=,>=,<=,<>,!=
				* like 使用占位符 _ 和 %  _代表一个字符 %代表任意个字符. 
					* select * from product where pname like '%新%';
				* in在某个范围中获得值.
					* select * from product where pid in (2,5,8);
				* between 较小值 and 较大值
					select * from products where price between 50 and 70;
	
		排序查询:
		1.查询所有的商品，按价格进行排序.(asc-升序,desc-降序)
			select * from products order by price desc;
		2.查询名称有新的商品的信息并且按价格降序排序.
			select * from products where pname like '%新%' order by price  desc;


		聚合函数:
			对一列进行计算 返回值是一个,忽略null值
		* sum(),avg(),max(),min(),count();
		1.获得所有商品的价格的总和：
			select sum(price) from products;
		2.获得商品表中价格的平均数：
			select avg(price) from products;
			-- round(值,保留小数位)
			select round(avg(price),2) from products;
		3.获得商品表中有多少条记录：
			select count(*) from products;

		分组：使用group by
		1.根据cno字段分组，分组后统计商品的个数.
			select cno,count(*) from products group by cno;
		2.根据cno分组，分组统计每组商品的总数量，并且总数量> 200;
			select cno,sum(pnum) from products  group by cno;
			select cno,sum(pnum) from products  group by cno having sum(pnum)>200;
			注意:
				where和having区别:
					1.where 是对分组前的数据进行过滤 ;having 是对分组后的数据进行过滤 
					2.where 后面不能使用聚合函数,having可以
/////////////////////////////////
数据类型:(了解)
java			mysql		
byte			tinyint			
short			smallint
int				int(★)
long			bigint
char/String		varchar(★)|char
					varchar:可变长度 mysql的方言  varchar(20):  存放abc 只会占用三个
					char:固定长度 char(20) 存放abc 占用20个
boolean			tinyint|int 代替
float|double	float|double
					注意:
						double(5,2):该小数长度为5个,小数占2个  最大值:999.99


java.sql.Date		date 日期
java.sql.Time		time 时间
java.sql.Timestamp	timestamp(★) 时间戳 若给定值为null,数据库会把当前的系统时间存放到数据库中
					datetime(★) 日期+时间
					
java.sql.Clob(长文本)	mysql的方言(text)
java.sql.Blob(二进制)	blob
//////////////////////////////////
约束:
	作用:
		为了保证数据的有效性和完整性
	mysql中常用的约束:主键约束(primary key)  唯一约束(unique) 非空约束(not null) 外键约束(foreign key)
	主键约束:被修饰过的字段唯一非空
		注意:一张表只能有一个主键,这个主键可以包含多个字段
		方式1:建表的同时添加约束 格式: 字段名称 字段类型 primary key
		方式2:建表的同时在约束区域添加约束 
			所有的字段声明完成之后,就是约束区域了
			格式: primary key(字段1,字段2)
			
			create table pk01(
				id int,
				username varchar(20),
				primary key (id)
			);
			
			insert into pk01 values(1,'tom');-- 成功
			insert into pk01 values(1,'tom');-- 失败 Duplicate entry '1' for key 'PRIMARY'
			insert into pk01 values(null,'tom');-- 失败  Column 'id' cannot be null
			
			create table pk01(
				id int primary key,
				username varchar(20),
				primary key (id)
			);-- 错误的 一张表只能有一个主键
			
		方式3:建表之后,通过修改表结构添加约束
			create table pk02(
				id int,
				username varchar(20)
			);
			
			alter table pk02 add primary key(字段名1,字段名2..);
			alter table pk02 add primary key(id,username);
			
			insert into pk02 values(1,'tom');-- 成功
			insert into pk02 values(1,'tomcat');-- 成功
			insert into pk02 values(1,'tomcat');-- 失败
		
	唯一约束:(了解)
		被修饰过的字段唯一,对null不起作用
		方式1:建表的同时添加约束 格式: 字段名称 字段类型 unique
			create table un(
				id int unique,
				username varchar(20) unique
			);
			
			insert into un value(10,'tom');-- 成功
			insert into un value(10,'jack');-- 错误 Duplicate entry '10' for key 'id'
			insert into un value(null,'jack');-- 成功
			insert into un value(null,'rose');-- 成功
			
		方式2:建表的同时在约束区域添加约束 
			所有的字段声明完成之后,就是约束区域了
			unique(字段1,字段值2...)
		方式3:建表之后,通过修改表结构添加约束
			alter table 表名 add unique(字段1,字段2);-- 添加的联合唯一
			alter table 表名 add unique(字段1);-- 给一个添加唯一
			alter table 表名 add unique(字段2);-- 给另一个添加唯一
			
			////////////////
				create table un01(
					id int,
					username varchar(20)
				); 
				alter table un01 add unique(id,username);
				insert into un01 values(1,'tom');-- 成功
				insert into un01 values(1,'jack');-- 成功
				insert into un01 values(1,'tom');-- 失败  Duplicate entry '1-tom' for key 'id'
			/////////////////////
	非空约束(了解)
		特点:被修饰过的字段非空
		方式:
			create table nn(
				id int not null,
				username varchar(20) not null
			);
			
			insert into nn values(null,'tom');--  错误的 Column 'id' cannot be null
///////////////////////////////
truncate 清空表 ★
	格式:
		truncate 表名; 干掉表,重新创建一张空表
	和delete from 区别:
		delete属于DML语句  truncate属于DDL语句
		delete逐条删除	truncate干掉表,重新创建一张空表
		-- delete删除后，主键编号还是会延续，truncate删除后，主键也从头开始了。
		
auto_increment 自增
	要求:
		1.被修饰的字段类型支持自增. 一般int
		2.被修饰的字段必须是一个key 一般是primary key
	
	create table ai01(
		id varchar(10) auto_increment
	);-- 错误 Incorrect column specifier for column 'id'
	
	create table ai01(
		id int auto_increment
	);-- 错误 Incorrect table definition; there can be only one auto column and it must be defined as a key
