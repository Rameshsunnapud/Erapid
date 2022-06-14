<% request.setCharacterEncoding(response.getCharacterEncoding()); %>
<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" %>
<%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");

Class.forName("net.sourceforge.jtds.jdbc.Driver");
Connection dataConn =DriverManager.getConnection("jdbc:jtds:sqlserver://lebhq-erdbdev:1433/sensors","sensors","Sensors2016");
Statement stmt=dataConn.createStatement();
stmt.executeUpdate( "set ANSI_warnings off");

String mac=request.getParameter("m");
String d1=request.getParameter("b");
String d2=request.getParameter("v");
String d3=request.getParameter("t");
String d4=request.getParameter("h");

java.util.Date uDate = new java.util.Date();
Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String tDate=formatter.format(uDate);

String d1_name = "n/a";
String d2_name = "n/a";
String d3_name = "n/a";
String d4_name = "n/a";

String sr_query = "SELECT * FROM AC_SENSOR_DEVICES where mac = '" + mac + "'";
java.sql.ResultSet rs_sensor_specs = stmt.executeQuery(sr_query);
if(rs_sensor_specs != null){
	while(rs_sensor_specs.next()){
		d1_name=rs_sensor_specs.getString("data1_name");
		d2_name=rs_sensor_specs.getString("data2_name");
		d3_name=rs_sensor_specs.getString("data3_name");
		d4_name=rs_sensor_specs.getString("data4_name");
	}
}
rs_sensor_specs.close();

String ps_query = "INSERT INTO AC_SENSOR_DATA (entry_date, mac, data1, data1_name, data2, data2_name, data3, data3_name, data4, data4_name) VALUES('"+tDate+"','"+mac+"','"+d1+"','"+d1_name+"','"+d2+"','"+d2_name+"','"+d3+"','"+d3_name+"','"+d4+"','"+d4_name+"')";
java.sql.PreparedStatement ps_sensor_data = dataConn.prepareStatement(ps_query);
int resultP = ps_sensor_data.executeUpdate();
ps_sensor_data.close();
dataConn.close();

logger.debug("Sensor board "+mac+" connected on "+tDate+" Data: "+d1+", "+d2+", "+d3+", "+d4+" "+resultP+" record(s)");
%>