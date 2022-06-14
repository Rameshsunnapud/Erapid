<%
		
		DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
	    Connection con_bpcs=DriverManager.getConnection("jdbc:as400://csas400tcpip/BPCSFFG;naming=sql;errors=full","logiasrv","logiasrv");
		Statement stmt_bpcs = con_bpcs.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);                        
		
	%>