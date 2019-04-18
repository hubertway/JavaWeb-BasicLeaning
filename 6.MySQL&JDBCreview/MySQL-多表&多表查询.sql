创建多表,可以描述出表于表之间的关系

一对多:
	用户和订单	
	-- 创建用户表
	create  table user(
		id int primary key auto_increment,
		username varchar(20)
	);
	
	-- 创建订单表
	create  table orders(
		id int primary key auto_increment,
		totalprice double,
		user_id int
	);
	
	为了保证数据的有效性和完整性,添加约束(外键约束).
		在多表的一方添加外键约束
			格式:
				alter table 多表名称 add foreign key(外键名称) references 一表名称(主键);
			例如:
				alter table orders add foreign key(user_id) references user(id);
	添加了外键约束之后有如下特点:★
		1.主表中不能删除从表中已引用的数据
		2.从表中不能添加主表中不存在的数据
	开发中处理一对多:★
		在多表中添加一个外键,名称一般为主表的名称_id,字段类型一般和主表的主键的类型保持一致,
		为了保证数据的有效性和完整性,在多表的外键上添加外键约束即可.
////////////////////////
多对多
	例子:商品和订单
		-- 创建商品表
	create table product(
		id int primary key auto_increment,
		name varchar(20),
		price double
	);

	-- 创建中间表
	create table orderitem(
		oid int,
		pid int
	);
		
	-- 添加外键约束
	alter table orderitem add foreign key(oid) references orders(id);
	alter table orderitem add foreign key(pid) references product(id);
	
	开发中处理多对多:★
		引入一张中间表,存放两张表的主键,一般会将这两个字段设置为联合主键,这样就可以将多对多的关系拆分
		成两个一对多了
		为了保证数据的有效性和完整性
			需要在中间表上添加两个外键约束即可.
///////////////////////////////////////////////////
多表查询

笛卡尔积:了解
	多张表无条件的联合查询.没有任何意思
		select a.*,b.* from a,b;
		
内连接:★
	格式1:显式的内连接
		select a.*,b.* from a [inner] join b on ab的连接条件
	格式2:隐式的内连接
		select a.*,b.* from a,b where ab的连接条件
外连接:★
	左外连接:★
		select a.*,b.* from a left [outer] join b on 连接条件;
		意思:
			先展示join左边的(a)表的所有数据,根据条件关联查询 join右边的表(b),符合条件则展示出来,不符合以null值展示.
	右外连接:
		select a.*,b.* from b right [outer] join a on 连接条件;
		意思:
			先展示jion右边的表(a)表的所有数据,根据条件关联查询join左边的表(b),符合条件则展示出来,不符合以null值展示.
子查询:★
	一个查询依赖另一个查询.
	


练习:
	查询用户的订单,没有订单的用户不显示
		隐式内连接:
			select user.*,orders.* from user ,orders where user.id=orders.user_id;
		显示内连接
			select user.*,orders.* from user join orders on user.id=orders.user_id;
	查询所有用户的订单详情
		左外连接: user在左
			select user.*,orders.* from user left join orders on user.id=orders.user_id;
	查询所有订单的用户详情
		右外连接:orders 在右
			select orders.*,user.* from user right join orders on user.id=orders.user_id;
			
练习:
	查看用户为张三的订单详情
		1.先查询张三的id
			select id from User where username = '张三';// 3
		2.select * from orders where user_id = ?;
		
		两个合二为一
			select * from orders where user_id = (select id from User where username = '张三');
	查询出订单的价格大于300的所有用户信息。
		1.先查询出订单价格>300的用户的id
			select user_id from orders where price >300;//(3,3,5,null)
		2.select * from user where id in(3,3,5,null);
		
		两个合二为一:
			select * from user where id in(select user_id from orders where price >300);
	查询订单价格大于300的订单信息及相关用户的信息。
		内连接:
			select orders.*,user.* from orders,user where user.id=orders.user_id  and orders.price>300 ;
		
		子查询:	是将一个查询的结果作为一张临时表		
			select user.*,tmp.* from user,(select * from orders where price>300) as tmp where user.id=tmp.user_id;
	
	给表起别名
		格式: 表 [as] 别名
//////////////////////////////////////////////////////////

	初始化数据:
	-- 用户表(user) 
	   create table `user` (                                  
			  `id` int auto_increment primary key,                
			  `username` varchar(50)  -- 用户姓名                                                
			);

	-- 订单表(orders)
	   create table `orders` (                                                  
			  `id` int  auto_increment primary key,                                  
			  `price` double,                                           
			  `user_id` int                                       
			);
	-- 给订单表添加外键约束
	alter table orders add constraint user_fk foreign key (user_id) references user(id); 

	-- 向user表中添加数据
			insert into user values(3,'张三');
			insert into user values(4,'李四');
			insert into user values(5,'王五');
			insert into user values(6,'赵六');

	-- 向orders 表中插入数据
			insert into orders values(1,1314,3);
			insert into orders values(2,1314,3);
			insert into orders values(3,15,4);
			insert into orders values(4,315,5);
			insert into orders values(5,1014,null);
