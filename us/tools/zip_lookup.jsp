<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
//if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
//        erapidBean.setServerName("server1");
//}
try{

%>
<HTML>
	<HEAD>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<TITLE>Zip Lookup</TITLE>
		<link rel='stylesheet' href='../../css/styleMain.css' type='text/css' />
	</HEAD>
	<body align='center' >
		<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.io.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con_rep_data.jsp"%>
		<%@ include file="../../../db_con_bpcs.jsp"%>
		<%
		String tax_zip=request.getParameter("tax_zip");
		String tax_code="";
		String tax_exempt_code="";
		String tax_perc="";
		out.println("<h1>tax percent/codes FOR ZIP code:: "+tax_zip+"</h1><BR>");
		try{
			if(tax_zip != null && tax_zip.trim().length()>0){
				int taxperccount=0;
				ResultSet rsTaxPerc=stmtRepData.executeQuery("select taxcode,taxpercentage,taxexemptcode from tax_rep2 where zip='"+tax_zip+"'");
				if(rsTaxPerc != null){
					while(rsTaxPerc.next()){
						taxperccount++;
						tax_exempt_code=rsTaxPerc.getString("taxexemptcode");
						tax_code=rsTaxPerc.getString("taxcode");
					}
				}
				rsTaxPerc.close();
				if(taxperccount<=0){
					out.println("<CENTER><font color='red' size='3'><B>Zip code not found</b></font></center><br>");
					out.println("<CENTER>Please <a href='zip_lookup_init.jsp'> click here </a> to try a valid zip code.</center>");
					tax_code="";
					tax_zip="";
					tax_perc="";
				}
				else{
					out.println("<p class='important'><b> Tax code:: "+tax_code+"</b></p>");
					out.println("<table width='50%' border='1' bordercolor='#E9F2F7' width='65%' cellspacing='0'><tr><td class='important'><b>Description</b></td><td class='important'><b>Tax rate code</b></td><td class='important'><b>tax %</b></td></tr>");
					String tax_code_temp="'";
					double temp_tax_perc=0;	double final_tax_perc=0;
					ResultSet rsbpcs=stmt_bpcs.executeQuery("select RTRC01,RTRC02,RTRC03,RTRC04,RTRC05,RTRC06,RTRC07,RTRC08,RTRC09,RTRC10 from ZRT where RTICDE='PROD' and RTCVCD='"+tax_code+"'");
					if(rsbpcs != null){
						while(rsbpcs.next()){
							for(int v=1; v<=10; v++){
								if(rsbpcs.getString(v) != null && rsbpcs.getString(v).trim().length()>0){
									tax_code_temp=tax_code_temp+rsbpcs.getString(v)+"','";
								}
							}
						}
					}
					rsbpcs.close();
					if(tax_code_temp.trim().length()>1){
						tax_code_temp=tax_code_temp.substring(0,tax_code_temp.length()-2);
					}
					ResultSet rsbpcs2=stmt_bpcs.executeQuery("select RCCRTE,RCRTCD,RCDESC from ZRC where RCRTCD in ("+tax_code_temp+") order by 3,1");
					if(rsbpcs2 != null){
						while(rsbpcs2.next()){
							if(rsbpcs2.getString(1) != null && rsbpcs2.getString(1).trim().length()>0){
								out.println("<tr><td>"+rsbpcs2.getString(3)+"</td><td>"+rsbpcs2.getString(2)+"</td><TD>"+rsbpcs2.getString(1)+"</td></tr>");
								final_tax_perc=final_tax_perc+new Double(rsbpcs2.getString(1)).doubleValue();
							}
						}
					}
					rsbpcs2.close();
					tax_perc=""+temp_tax_perc;
					out.println("<tr><td colspan='3' >&nbsp;</td></tr>");
					out.println("<tr><td colspan='1' >&nbsp;</td><td colspan='1' ><b>Total tax %</b></td><td colspan='1'><b>"+final_tax_perc+"</b></td></tr>");
					out.println("<tr><td colspan='3' >Tax exempt code="+tax_exempt_code+"</td></tr>");
					out.println("<tr><td colspan='3' >&nbsp;</td></tr>");
					out.println("<tr><td colspan='3' >To try a different zip code please <a href='zip_lookup_init.jsp'> click here </a></td></tr>");
				}

			}
		}
		catch(Exception etax){
			out.println(etax);
		}
		%>
	</table>
</body>
</HTML>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>