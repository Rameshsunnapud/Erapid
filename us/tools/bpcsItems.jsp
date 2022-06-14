<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
//if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
//        erapidBean.setServerName("server1");
//}
try{

%>
<SCRIPT LANGUAGE="JavaScript">
	function forwarding(){
		document.location.href='ge_maint_home.jsp';
	}
</script>
<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../../db_con_bpcs.jsp"%>
<%@ include file="../../../db_con.jsp"%>
<%
out.println("Update started.  Please wait.");
java.util.Date today=new java.util.Date();
//out.println(today+"<BR>");
String date=today.getMonth()+1+"/"+today.getDate()+"/"+(String.valueOf(today.getYear()).substring(1));
//out.println(date+"<BR>");
int count=0;

Vector partNo=new Vector();
Vector itemName=new Vector();
Vector partCost=new Vector();
Vector partUm=new Vector();
Vector warehouse=new Vector();
Vector description=new Vector();
Vector partNoNew=new Vector();
Vector itemNameNew=new Vector();
Vector partCostNew=new Vector();
Vector partUmNew=new Vector();
Vector vendorCodeNew=new Vector();
Vector vendorNameNew=new Vector();
Vector warehouseNew=new Vector();
Vector descriptionNew=new Vector();
//out.println("<table border='1'><tr><td colspan='6'>BPCS</td></tr>");
//ResultSet rs1=stmt_bpcs.executeQuery("select IIM.IPROD, IIM.IDESC, CMF.CFTLVL,IIM.IVEND,IIM.IUMS,CMF.CFPLVL, CIC.ICFAC, CIC.ICSTK,IIM.IDSCE from IIM LEFT join CMF on IIM.IPROD = CMF.CFPROD AND CMF.CFFAC='GE' AND CMF.CFCSET='2' AND CMF.CFCBKT='0' join CIC ON CIC.ICPROD=IIM.IPROD AND CIC.ICPROD=CMF.CFPROD AND CIC.ICFAC='GE' GROUP BY IIM.IID, IIM.IPROD, IIM.IDESC, IIM.ICLAS, IIM.IUMS, IIM.IUMP, IIM.IUMCN, IIM.ISCST, IIM.IABBT, IIM.IUMR, IIM.IUMRC, IIM.TAXC1, IIM.IWHS, IIM.IMCOM, IIM.IID, CMF.CFFAC, CMF.CFCSET, CMF.CFCBKT, CMF.CFTLVL, CMF.CFpLVL, CIC.ICFAC,IIM.IVEND,CIC.ICFAC, CIC.ICSTK, IIM.IDSCE  HAVING IIM.IID<>'IZ' AND (IIM.IWHS='3' Or IIM.IWHS='GG' or IIM.IWHS='GE' Or IIM.IWHS='73' Or IIM.IWHS='1G' Or IIM.IWHS='4N' Or IIM.IWHS='1' Or IIM.IWHS='7A' Or IIM.IWHS='OP')");
//ResultSet rs1=stmt_bpcs.executeQuery("select icprod,  idesc, cftlvl,  icpvnd, iums, cfplvl, icfac, icstk,idsce from bpcsffg.cic	join bpcsffg.iim on iprod = icprod left join bpcsffg.cmf on cffac = icfac and cfprod = icprod where icstk = '4N' AND cfcset = 2 and cfcbkt = 0");
  ResultSet rs1=stmt_bpcs.executeQuery("select icprod,  idesc, cftlvl,  icpvnd, iums, cfplvl, icfac, icstk,idsce from bpcsffg.cic       join bpcsffg.iim on iprod = icprod left join bpcsffg.cmf on cfprod = icprod where icstk in ('4N', 'OP', '7A') and icfac = 'MU' AND cffac = 'GE' AND cfcset = 2 and cfcbkt = 0");

if(rs1 != null){
	while(rs1.next()){
		//out.println(".");
		partNo.addElement(rs1.getString(1).trim());
		itemName.addElement(rs1.getString(2));
		partCost.addElement(""+(new Double(rs1.getString(3)).doubleValue()+new Double(rs1.getString(6)).doubleValue()));
		partUm.addElement(rs1.getString(5));
		//out.println(rs1.getString(7)+"::<BR>");
		warehouse.addElement(rs1.getString(8));
		count++;
		description.addElement(rs1.getString(9));
		//out.println("<tr><td>"+rs1.getString(1)+"</td><td>"+"<td>"+rs1.getString(2)+"</td><td>"+"<td>"+rs1.getString(9)+"</td><td>"+"<td>"+rs1.getString(4)+"</td><td>"+"<td>"+rs1.getString(5)+"</td><td>"+"<td>"+rs1.getString(6)+"</td><td></tr>");
		//out.println(rs1.getString(1)+"::"+rs1.getString(2)+"::"+rs1.getString(9)+"::<BR>");
	}
	//out.println("<tr><td colspan='6'> BPCS this is the number of records"+count+"</td></tr>");
}
//out.println("</table><BR><BR><BR>");
count=0;

//out.println("<table border='1'><tr><td colspan='6'>GE VENDOR ITEMS</td></tr>");
ResultSet rs2=stmt.executeQuery("Select part_no,item_name,part_cost,part_um,vendor_code,vendor_name,whse,description from cs_ge_vendor_items");
if(rs2 != null){
	while(rs2.next()){
		//out.println(".");
		if(rs2.getString(1) != null){
			partNoNew.addElement(rs2.getString(1).trim());
		}
		else{
			partNoNew.addElement("");
		}
		if(rs2.getString(2) != null){
			itemNameNew.addElement(rs2.getString(2));
		}
		else{
			itemNameNew.addElement("");
		}
		if(rs2.getString(3) != null){
			partCostNew.addElement(rs2.getString(3));
		}
		else{
			partCostNew.addElement("");
		}
		if(rs2.getString(4) != null){
			partUmNew.addElement(rs2.getString(4));
		}
		else{
			partUmNew.addElement("");
		}
		if(rs2.getString(5) != null){
			vendorCodeNew.addElement(rs2.getString(5));
		}
		else{
			vendorCodeNew.addElement("0");
		}
		if(rs2.getString(6) != null){
			vendorNameNew.addElement(rs2.getString(6));
		}
		else{
			vendorNameNew.addElement("");
		}
		if(rs2.getString(7) != null){
			warehouseNew.addElement(rs2.getString(7));
		}
		else{
			warehouseNew.addElement("");
		}
		if(rs2.getString(8) != null){
			descriptionNew.addElement(rs2.getString(8));
		}
		else{
			descriptionNew.addElement("");
		}
		count++;

		//out.println("<tr><td>"+rs2.getString(1)+"</td><td>"+"<td>"+rs2.getString(2)+"</td><td>"+"<td>"+rs2.getString(3)+"</td><td>"+"<td>"+rs2.getString(4)+"</td><td>"+"<td>"+rs2.getString(5)+"</td><td>"+"<td>"+rs2.getString(6)+"</td><td></tr>");
	}
	//out.println("<tr><td colspan='6'> ERAPID this is the number of records"+count+"</td></tr>");
}
rs1.close();
rs2.close();

for(int a=0; a<partNo.size(); a++){
	boolean isEqual=false;
	for(int b=0; b<partNoNew.size(); b++){
		//out.println(".");
		//out.println(partNoNew.elementAt(b).toString()+"::<BR>");
		if(partNo.elementAt(a).toString().trim().equals(partNoNew.elementAt(b).toString().trim())){
			//out.println(partNo.elementAt(a).toString()+"::"+partNoNew.elementAt(b).toString()+"::"+a+"<BR>");
			isEqual=true;
			boolean update=false;

			if(!(itemName.elementAt(a).toString().trim().equals(itemNameNew.elementAt(b).toString().trim()))|!(description.elementAt(a).toString().trim().equals(descriptionNew.elementAt(b).toString().trim()))|!(warehouse.elementAt(a).toString().trim().equals(warehouseNew.elementAt(b).toString().trim()))|!(new Double(partCost.elementAt(a).toString().trim()).doubleValue()==new Double(partCostNew.elementAt(b).toString().trim()).doubleValue())|!(partUm.elementAt(a).toString().trim().equals(partUmNew.elementAt(b).toString().trim())) ){
				//out.println(partNoNew.elementAt(b).toString()+"::"+itemName.elementAt(a).toString().trim()+"::"+itemNameNew.elementAt(b).toString().trim()+"::<BR>");
				//out.println(partNoNew.elementAt(b).toString()+"::"+itemName.elementAt(a).toString().trim()+"::"+itemNameNew.elementAt(b).toString().trim()+"::<BR>");
				//out.println(descriptionNew.elementAt(b).toString()+"::"+description.elementAt(a).toString()+"::<BR>");

				out.println(".");
				myConn.setAutoCommit(false);
				try{
					String insert ="update cs_ge_vendor_items set item_name=?,part_cost=?,part_um=?,date_updated=?,whse=?,description=? WHERE part_no=?";
					PreparedStatement update_vend = myConn.prepareStatement(insert);
					update_vend.setString(1, itemName.elementAt(a).toString());
					update_vend.setString(2, partCost.elementAt(a).toString());
					update_vend.setString(3, partUm.elementAt(a).toString());
					update_vend.setString(4, date);
					update_vend.setString(5, warehouse.elementAt(a).toString());
					update_vend.setString(6, description.elementAt(a).toString().trim());
					update_vend.setString(7, partNoNew.elementAt(b).toString().trim());
					int rocount = update_vend.executeUpdate();
					//out.println(partNoNew.elementAt(b).toString().trim()+"::"+description.elementAt(a).toString().trim());
					//out.println(rocount+"<BR>");
					update_vend.close();
					myConn.commit();
				}
				catch (java.sql.SQLException e){
					myConn.rollback();
					out.println(e.toString()+"<BR>");
					return;
				}
				//out.println("<BR><BR>");
				myConn.commit();


			}

		}

	}
	if(!isEqual){
		out.println(".");
		myConn.setAutoCommit(false);
		try{
			String updateString ="INSERT INTO cs_ge_vendor_items (item_name,part_cost,part_um,part_no,date_updated,vendor_code,whse,description)VALUES(?,?,?,?,?,?,?,?) ";
			java.sql.PreparedStatement updateVend = myConn.prepareStatement(updateString);
			updateVend.setString(1,itemName.elementAt(a).toString());
			updateVend.setString(2,partCost.elementAt(a).toString());
			updateVend.setString(3,partUm.elementAt(a).toString());
			updateVend.setString(4,partNo.elementAt(a).toString());
			updateVend.setString(5,date);
			updateVend.setString(6,"0");
			updateVend.setString(7,warehouse.elementAt(a).toString());
			updateVend.setString(8,description.elementAt(a).toString());
			int rocount=updateVend.executeUpdate();
			updateVend.close();
		}
		catch (java.sql.SQLException e){
			//out.println("Problem with entering into cs_ge_vendor table");
			//out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			//out.println(e.toString());
			return;
		}
		myConn.commit();

	}

}
int countx=0;
for(int c=0; c<partNoNew.size(); c++){

	//out.println(".");
	//out.println(partNoNew.elementAt(c).toString()+"::<BR>");
	boolean isMatch=false;
	for(int d=0; d<partNo.size(); d++){
		//out.println(partNoNew.elementAt(c).toString()+"<br>");
		//out.println(".");
		//out.println(partNoNew.elementAt(c).toString()+"::"+partNo.elementAt(d).toString()+"::<BR>");
		if(partNoNew.elementAt(c).toString().trim().equals(partNo.elementAt(d).toString().trim())){
			//out.println(partNoNew.elementAt(c).toString()+"::"+partNo.elementAt(d).toString()+"::<BR>");
			isMatch=true;
			countx++;
			if(isMatch){
				//out.println("<font color='red'>FOUND<BR></font>");
			}
		}
	}
	if(!isMatch){
		out.println(".");
		//out.println("delete from cs_ge_vendor_items where part_no='"+partNoNew.elementAt(c).toString()+"' <BR>");
		myConn.setAutoCommit(false);
		try{
			stmt.executeUpdate("delete from cs_ge_vendor_items where part_no='"+partNoNew.elementAt(c).toString()+"' ");
		}
		catch (java.sql.SQLException e){
			out.println("Problem with deleting from cs_ge_vendor_items table");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
		myConn.commit();

	}
	isMatch=false;

}
int counte=0;
for(int e=0; e<vendorCodeNew.size(); e++){
		//out.println(".");
	try{
		Integer.parseInt(vendorCodeNew.elementAt(e).toString());
		if((!vendorCodeNew.elementAt(e).toString().trim().equals("0")&&!vendorCodeNew.elementAt(e).toString().equals("NA"))&&(vendorNameNew.elementAt(e).toString() == null||vendorNameNew.elementAt(e).toString().trim().length()<1) ){
			//out.println(vendorCodeNew.elementAt(e).toString()+"<BR>");
			String vendor="";
			ResultSet rs3=stmt_bpcs.executeQuery("SELECT VNDNAM FROM AVM WHERE VENDOR='"+vendorCodeNew.elementAt(e).toString().trim()+"'");
			if(rs3 != null){
				while(rs3.next()){
					out.println(".");
					if(rs3.getString(1) != null){
						vendor=rs3.getString(1);
					}
				}
			}
			rs3.close();
			//out.println(vendor+"::"+vendor.length()+"::"+vendorCodeNew.elementAt(e).toString()+"<BR>");

			myConn.setAutoCommit(false);
			try{
		out.println(".");
				String insert ="update cs_ge_vendor_items set vendor_name=?,date_updated=? WHERE part_no=?";
				PreparedStatement update_vend = myConn.prepareStatement(insert);
				update_vend.setString(1, vendor);
				update_vend.setString(2, date);
				update_vend.setString(3, partNoNew.elementAt(e).toString());
				int rocount = update_vend.executeUpdate();
				update_vend.close();
			}
			catch (java.sql.SQLException ee){
				out.println("Problem with Updating ge vendor TABLE"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(ee.toString());
				return;
			}
			myConn.commit();


		}
	}
	catch(Exception exc){

	}
}

out.println("<br> Update Complete<BR>");
stmt.close();
stmt_bpcs.close();
myConn.close();
con_bpcs.close();
%>
<input type='button' name='x' onclick='forwarding()' value='GE MAINTENANCE HOME'>
</body>
</html>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>