<META http-equiv=Content-Type content="text/html; charset=utf-8">


<%@ page language="java"  contentType="text/html; charset=UTF-8" import="jcifs.smb.*" import="java.nio.charset.Charset" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" import="org.zefer.pd4ml.PD4ML" import="org.zefer.pd4ml.PD4Constants" import="java.awt.Insets" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>
<%
	out.println("<font size='2' color='red'>Please do not close this window.  It will close itself when it is finished.</font>");
	String url=request.getParameter("url");	
	String order_no=request.getParameter("order_no");	
	out.println(url+"<BR><BR>"+order_no+"<BR>");
	url=url.replaceAll(" ","%");
	out.println(url+"<BR><BR>"+order_no);
	String counter="";
	String file_details="";
	String product_id="";
	boolean isInImsCounter=false;
	ResultSet rs1=stmt.executeQuery("select numFiles,file_details from cs_ims_counter where order_no='"+order_no.trim()+"'");
	if(rs1 != null){
		while(rs1.next()){
			counter=rs1.getString(1);
			file_details=rs1.getString(2);
			isInImsCounter=true;
		}
	}
	rs1.close();
	ResultSet rs2=stmt.executeQuery("select product_id from cs_project where order_no='"+order_no.trim()+"'");
	if(rs2 != null){
		while(rs2.next()){
			product_id=rs2.getString(1);
		}
	}
	rs2.close();
	
	if(counter == null || counter.equals("null") || counter.trim().length()<1){
		counter="00";
	}
	else if(counter.trim().length()<2){
		counter="0"+counter;
	}
	if(product_id.equals("GCP")){
		product_id="GCU";
	}
	else if(product_id.equals("GE")){
		product_id.equals("GRA");
	}
	else if(product_id.equals("GRILLE")){
		product_id.equals("GRL");
	}
	else if(product_id.equals("EJC")){
		product_id="TPG";
	}	
	String saveFile = product_id+order_no.trim()+counter+".pdf";
	String fileName="";

	
	
	String filepath="lebhq-csedev/word.quotes/rtfs/"+saveFile;

 	SmbFile s = new SmbFile("smb://c-sgroup;gsuisham:gre0215@"+filepath);
	SmbFileOutputStream fos = new SmbFileOutputStream(s);      	
      	
      	java.net.URL targetURL = new java.net.URL (url) ;      	
      	PD4ML html = new PD4ML(); 
      	html.protectPhysicalUnitDimensions();
	html.setPageSize(PD4Constants.LETTER);      	
      	html.render(targetURL, fos);  	
      	java.util.Date date=new java.util.Date();
      	file_details=file_details+"<tr><td>ORDER WRITE-UP</td><td>"+saveFile+"</td><td>ORDER WRITE-UP</td><td>NA</td><td>Clean</td><td>"+date+"</td></tr>";
   if(Integer.parseInt(counter)>0||isInImsCounter){
		counter=(""+(Integer.parseInt(counter)+1)).trim();
		try{						
			java.sql.PreparedStatement ps=myConn.prepareStatement("UPDATE cs_ims_counter SET numFiles =?,file_details=? WHERE Order_no =? ");
			ps.setString(1,counter.trim());
			ps.setString(2,file_details);
			ps.setString(3,order_no.trim());
			int re=ps.executeUpdate();
			ps.close();
		}
		catch (java.sql.SQLException e)	{
			out.println("Problem with updating cs_ims_counter table"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
	}
	else{
		counter=(""+(Integer.parseInt(counter)+1)).trim();
			try{
				String insert ="INSERT INTO cs_ims_counter(order_no,file_details,numFiles) VALUES(?,?,?) ";
				PreparedStatement insert_ims = myConn.prepareStatement(insert);
				insert_ims.setString(1,order_no.trim());
				insert_ims.setString(2,file_details); 
				insert_ims.setString(3,counter.trim());
				int rocount = insert_ims.executeUpdate();
				insert_ims.close();
			}
			catch (java.sql.SQLException e){
				out.println("Problem with ENTERING TO cs_ims_counter"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}			
					
	}
	
  	
%>


<body onload='javascript:window.close()'>