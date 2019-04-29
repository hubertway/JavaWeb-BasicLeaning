package dom4j;

import java.util.List;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class XpathDemo {
	public static void main(String[] args) throws Exception {
		//加载dom树
		Document doc = new SAXReader().read("web.xml");
		//获取节点
//		List<Element> list =  doc.selectNodes("/web-app/servlet/servlet-name");
//		Element ele = list.get(0);
		//获取单个节点
		Element ele = (Element) doc.selectSingleNode("//servlet/servlet-name");
		System.out.println(ele.getText());
	}
}
