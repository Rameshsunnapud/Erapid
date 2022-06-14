<HTML>      
<HEAD> <TITLE>IWP Packing List Maint</TITLE></head>
<%@ page language="java" import="java.sql.*"  import="java.util.*" errorPage="error.jsp" %>
<%@ include file="db_con.jsp"%>

<%@ include file="db_con_bpcsusr.jsp"%>
<%//@ include file="db_con_bpcs_shockwave.jsp"%>
<%
int count=0;
ResultSet rs1=stmt.executeQuery("select count(*) from cs_iwp_pack_time");
if(rs1 != null){
	while(rs1.next()){
		count=rs1.getInt(1);
	}
}
rs1.close();
String[][] cs_iwp_pack_time = new String[count][18];
int count2=0;
ResultSet rs2=stmt.executeQuery("select * from cs_iwp_pack_time order by aprice");
if(rs2 != null){
	while(rs2.next()){
		for(int i=0; i<18; i++){
			if(rs2.getString(i+1)==null || rs2.getString(i+1).equals("null") || rs2.getString(i+1).trim().length()==0){
				cs_iwp_pack_time[count2][i]="";
			}
			else if(rs2.getString(i+1).trim().equals("0.0")||rs2.getString(i+1).trim().equals("0.00")){
				cs_iwp_pack_time[count2][i]="0";
			}
			else if(rs2.getString(i+1).trim().endsWith(".0")||rs2.getString(i+1).trim().endsWith(".00")){
				cs_iwp_pack_time[count2][i]=(rs2.getString(i+1).trim().substring(0,rs2.getString(i+1).trim().lastIndexOf("."))).trim();
			}			
			else{		
				cs_iwp_pack_time[count2][i]=rs2.getString(i+1).trim();
			}
		}
		count2++;
	}
}
rs2.close();
int count3=0;
ResultSet rs3=stmt_bpcsusr.executeQuery("select count(*) from oei031pf");
if(rs3 != null){
	while(rs3.next()){
		count3=rs3.getInt(1);
	}
}
rs3.close();
String[][] oei031pf = new String[count3][18];
int count4=0;
ResultSet rs4=stmt_bpcsusr.executeQuery("select * from oei031pf order by aprice");
if(rs4 != null){
	while(rs4.next()){		
		for(int i=0; i<18; i++){
			if(rs4.getString(i+1)==null || rs4.getString(i+1).equals("null") || rs4.getString(i+1).trim().length()==0){
				oei031pf[count4][i]="";
			}
			else if(rs4.getString(i+1).trim().equals("0.0")||rs4.getString(i+1).trim().equals("0.00")){
				oei031pf[count4][i]="0";
			}	
			else if(rs4.getString(i+1).trim().endsWith(".0")||rs4.getString(i+1).trim().endsWith(".00")){
				oei031pf[count4][i]=(rs4.getString(i+1).trim().substring(0,rs4.getString(i+1).trim().lastIndexOf("."))).trim();
			}	
			else{
				oei031pf[count4][i]=rs4.getString(i+1).trim();
			}
		}
		count4++;
	}
}
rs4.close();
int countx=0;
int countxx=0;
int countxxx=0;
for(int k=0; k<count3; k++){
	boolean isMatch3=false;
	for(int j=0; j<count; j++){	
		// first 8 fields are keys.  Checking for matching...
		boolean isMatch=true;	
		/*
		for(int q=0; q<12; q++){
			out.println(cs_iwp_pack_time[j][q]+"::");
		}
		out.println("<BR>");
		for(int qq=0; qq<12; qq++){
			//out.println(oei031pf[k][qq]+"::");
		}
		out.println("<BR>");
		*/
		for(int l=3; l<8; l++){	
			if(cs_iwp_pack_time[j][l].toUpperCase().equals(oei031pf[k][l].toUpperCase())&&isMatch){
				isMatch=true;
			}
			else{
				isMatch=false;
			}			
		}
		if(isMatch){
			boolean isMatch2=true;
			isMatch3=true;
			for(int n=8; n<12; n++){				
				if(!cs_iwp_pack_time[j][n].toUpperCase().equals(oei031pf[k][n].toUpperCase())){
					isMatch2=false;
				}
			}
			if(!isMatch2){		
				countxx++;
				String bpcsValues="";
				for(int o=0; o<18; o++){					
					bpcsValues=bpcsValues+"'"+oei031pf[k][o]+"',";
				}
				String deleteQuery="delete from cs_iwp_pack_time where aprice='"+cs_iwp_pack_time[j][3]+"' and aoption='"+cs_iwp_pack_time[j][4]+"' and aoper='"+cs_iwp_pack_time[j][5]+"' and awrkcntr='"+cs_iwp_pack_time[j][6]+"' and apkgtype='"+cs_iwp_pack_time[j][7]+"'";
				String insertQuery="insert into cs_iwp_pack_time values("+bpcsValues.substring(0,bpcsValues.length()-1)+")";
				//out.println(deleteQuery+"<BR>"+insertQuery+"<BR><BR>");
				
				myConn.setAutoCommit(false);
				try{
					stmt.executeUpdate(deleteQuery);
					stmt.executeUpdate(insertQuery);
				}
				catch(java.sql.SQLException e){
					out.println("Problem with Deleting from cs_iwp_pack_time or updating "+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					out.println(e.toString());
					myConn.rollback();
					return;
				}
				
				
			}
			else{
				countxxx++;
				//out.println("match<BR>");
			}
		}
	}
	if(!isMatch3){
		countx++;
		String insertQuery="insert into cs_iwp_pack_time values(";
		for(int m=0; m<18; m++){
			insertQuery=insertQuery+"'"+oei031pf[k][m]+"',";
		}
		insertQuery=insertQuery.substring(0,(insertQuery.length()-1))+")";			
		//out.println(insertQuery+"<BR>");
		
		myConn.setAutoCommit(false);
		try{
			stmt.executeUpdate(insertQuery);
		}
		catch(java.sql.SQLException e){
			out.println("Problem with insert into cs_iwp_pack_time<br>");
			out.println(insertQuery+"Illegal Operation try again/Report Error<br>");
			out.println(e.toString());
			myConn.rollback();
			return;
		}
		
		
	}
}
out.println(count+"::"+count3+"::"+countx+"::"+countxx+"::"+countxxx+"<BR><font size='6'>FINISHED</font>");
myConn.commit();
stmt_bpcsusr.close();
con_bpcsusr.close();
stmt.close();
myConn.close();
%>
</HTML>
