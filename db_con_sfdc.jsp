<%
String dbSFDCServerName=erapidBean.getDbSFDCServerName();
String dbSFDCServerPort=erapidBean.getDbSFDCServerPort();
String SFDCDB="";
String SFDCDBUserName=erapidBean.getSFDCDBUsername();
String SFDCDBPassword=erapidBean.getSFDCDBPassword();

String env2="";
	if(request.getParameter("env") != null && !request.getParameter("env").isEmpty()){
		 env2=request.getParameter("env");

		 if(env2.equalsIgnoreCase("SIT")){
		  SFDCDB="SalesforceSIT";
		 }
		 else if(env2.equalsIgnoreCase("DEV")){
			  SFDCDB="SalesforceDEV";
			 }
		 else if(env2.equalsIgnoreCase("UAT")){
				  SFDCDB="SalesforceUAT";
			 }
		 else{
		    SFDCDB=erapidBean.getSFDCDB();
			}
	    }else{
	    SFDCDB=erapidBean.getSFDCDB();
		}


Class.forName("net.sourceforge.jtds.jdbc.Driver");
Connection myConn_sfdc = DriverManager.getConnection("jdbc:jtds:sqlserver://"+dbSFDCServerName+":"+dbSFDCServerPort+"/"+SFDCDB,SFDCDBUserName,SFDCDBPassword);
Statement stmt_sfdc=myConn_sfdc.createStatement();
stmt_sfdc.executeUpdate( "set ANSI_warnings off");

 // myConn_sfdc.setNetworkTimeout(Executors.newFixedThreadPool(20),executor, 3000);
%>
