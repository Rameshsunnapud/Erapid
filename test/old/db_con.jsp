<%
Class.forName("net.sourceforge.jtds.jdbc.Driver");
Connection myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://"+application.getInitParameter("DBHOST")+":1433/cseintdev","erapid","erapid@382");
//Statement stmt=myConn.createStatement();
//stmt.executeUpdate( "set ANSI_warnings off");
%>
