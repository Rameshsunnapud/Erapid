<%
Class.forName("net.sourceforge.jtds.jdbc.Driver");
Connection myConns = DriverManager.getConnection("jdbc:jtds:sqlserver://"+application.getInitParameter("DBHOST")+":1433/cseintdevsys","erapid","erapid@382");
Statement stmts=myConns.createStatement();
stmts.executeUpdate( "set ANSI_warnings off");
%>
