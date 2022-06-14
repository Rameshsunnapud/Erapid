<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>
<% 		String order_no = request.getParameter("sp-q");//	
 		String edit = request.getParameter("eh-q");//	
		Class.forName("com.sybase.jdbc2.jdbc.SybDriver");
	   	Connection myConn = DriverManager.getConnection("jdbc:sybase:Tds:"+application.getInitParameter("HOST")+":2638/csedev?SERVICENAME=csedevsys", "dba", "sql");//
		Statement stmt=myConn.createStatement();

Vector it_key=new Vector();Vector it_values=new Vector();
//vars for editing the header info
		Properties properties = new Properties(); 
		String project_name="";
		ResultSet rs_project = stmt.executeQuery("SELECT * FROM logia_group where group_id like 'rep' ");
  		if (rs_project !=null) {
		while (rs_project.next()){						
		ObjectInputStream objectinputstream = new ObjectInputStream(new ByteArrayInputStream(rs_project.getBytes(4)));
        properties = (Properties)objectinputstream.readObject();				
	//	out.println("the stest<br>"+properties.size()+"<br>");
								 }
							   }			
							   
  Enumeration e = properties.propertyNames();
  String key="";  String value="";
  while (e.hasMoreElements())
    {
    key = (String) e.nextElement();
    value = properties.getProperty (key);
    out.println ("Key :" + key +": = :" + value + ":<br>");
	it_key.addElement(key);
	it_values.addElement(value);	
    }
	
out.println ("THe sizse are key:"+it_key.size()+"THe sizse are values:"+it_key.size());

for (int i=0; i<it_key.size();i++){
if (it_values.elementAt(i).equals("D")){
    out.println ("Key :" + it_key.elementAt(i) +": = :" + it_values.elementAt(i) + ":<br>");
}// if loop
}// for loop

%>