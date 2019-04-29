package dom4j;

import java.util.List;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;


public class Demo {
	public static void main(String[] args) throws Exception {
		//创建核心对象
		SAXReader reader = new SAXReader();
		//获取dom数
		Document doc= reader.read("web.xml");
		//获取根节点
		Element root = doc.getRootElement();
		//获取其他节点
		List<Element>list =   root.elements();
		
		//遍历集合
		for(Element ele:list) {
			//获取servlet-name的标签体
//			String text = ele.elementText("servlet-name");
//			System.out.println(text);
			
			//获取url-pattern标签体
//			System.out.println(ele.elementText("url-pattern"));
			
		}
		//获取root的version属性
		String value=root.attributeValue("version");
		System.out.println(value);
	}
}
