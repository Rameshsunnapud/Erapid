<%
//Class.forName("com.newatlanta.jturbo.driver.Driver");
//Connection myConn = DriverManager.getConnection("jdbc:JTurbo://"+application.getInitParameter("DBHOST")+":1433/cse=false","erapid","erapid123");
//credit card database
//Connection myConn_ccf = DriverManager.getConnection("jdbc:JTurbo://"+"lebhq-actsql.c-sgroup.com\\prod"+":1433/CCF/sql70=true/sp=false","report","report123");
//Statement stmt_ccf=myConn_ccf.createStatement();
//stmt_ccf.executeUpdate( "set ANSI_warnings off");
//sqlserver://lebhq-actsql:1433\prod;databasename=CCF
Class.forName("net.sourceforge.jtds.jdbc.Driver");
Connection myConn_ccf = DriverManager.getConnection("jdbc:jtds:sqlserver://"+"lebhq-actsql"+":4493/CCF","report","report123");
Statement stmt_ccf=myConn_ccf.createStatement();
%>
