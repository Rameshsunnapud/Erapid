<jsp:useBean id="erapidBean"		class="com.csgroup.general.ErapidBean"			scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

	
%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../db_con_bpcs.jsp"%>
<%

    String query="WITH temp_mbm (parent_part, child_part, qty, seq_no, iteration, usc_code, raw_qty, scrap_factor, op_no,override) AS  ";
    query=query+"(SELECT BPROD, BCHLD, cast(round(BQREQ*1,3) as decimal(10,3)), BSEQ, 1, BUSC, cast(BQREQ as decimal(10,3)), BMSCP, BOPNO, BMISS  ";
    query=query+" FROM BPCSFFG.mbm WHERE bprod IN ( '5700','4120','4125','6080','6085') and BMWHS='"+"CR"+"' and BMBOMM=''  UNION ALL SELECT temp_mbm.child_part, BPCSFFG.mbm.BCHLD,";
    query=query+" cast(round(BPCSFFG.mbm.BQREQ*temp_mbm.qty,3) as decimal(10,3)), BPCSFFG.mbm.BSEQ, temp_mbm.iteration+1, BPCSFFG.mbm.BUSC, ";
    query=query+" cast(BPCSFFG.mbm.BQREQ as decimal(10,3)), BPCSFFG.mbm.BMSCP, BPCSFFG.mbm.BOPNO, BPCSFFG.mbm.BMISS       FROM temp_mbm, BPCSFFG.mbm   ";
    query=query+" WHERE temp_mbm.child_part = BPCSFFG.mbm.BPROD and BPCSFFG.mbm.BMWHS='MU' and BPCSFFG.mbm.BMBOMM='')                SELECT *                FROM temp_mbm order by iteration, parent_part, seq_no, child_part";
    out.println(query+"<BR><BR><BR>");    
    Vector parentPart=new Vector();
    Vector childPart=new Vector();  
    Vector qty=new Vector(); 
    Vector seqNo=new Vector(); 
    Vector iteration=new Vector(); 
    Vector uscCode=new Vector(); 
    Vector rawQty=new Vector(); 
    Vector scrapFactor=new Vector(); 
    Vector opNo=new Vector(); 
    Vector override=new Vector(); 
    Vector iprod=new Vector(); 
    Vector idesc=new Vector(); 
    Vector idsce=new Vector(); 
    ResultSet rs1=stmt_bpcs.executeQuery(query);
    if (rs1 !=null) {
	while (rs1.next()) {
            parentPart.addElement(rs1.getString(1));
            childPart.addElement(rs1.getString(2));  
            qty.addElement(rs1.getString(3)); 
            seqNo.addElement(rs1.getString(4)); 
            iteration.addElement(rs1.getString(5)); 
            uscCode.addElement(rs1.getString(6)); 
            rawQty.addElement(rs1.getString(7)); 
            scrapFactor.addElement(rs1.getString(8)); 
            opNo.addElement(rs1.getString(9)); 
            override.addElement(rs1.getString(10)); 
            iprod.addElement(""); 
            idesc.addElement(""); 
            idsce.addElement(""); 
        }
    }
    rs1.close();
    for(int i=0; i<childPart.size(); i++){
        String query2="select iprod, idesc, idsce from bpcsffg.iim where iprod = '"+childPart.elementAt(i).toString()+"'";    
        ResultSet rs2 = stmt_bpcs.executeQuery(query2);
        if(rs2 != null){
            while(rs2.next()){                
                iprod.setElementAt(rs2.getString(1),i); 
                idesc.setElementAt(rs2.getString(2),i); 
                idsce.setElementAt(rs2.getString(3),i); 
            }
        }
        rs2.close();
    }
    out.println("<table border='1' width='100%'>");
    out.println("<tr>");
    out.println("<td>parent part</td>");
    //out.println("<td>child part</td>");
    out.println("<td>iprod</td>");
    out.println("<td>idesc</td>");
    out.println("<td>idsce</td>");
    out.println("<td>qty</td>");
    out.println("<td>seq_no</td>");
    out.println("<td>iteration</td>");
    out.println("<td>usc code</td>");
    out.println("<td>raw_qty</td>");
    out.println("<td>scrap factor</td>");
    out.println("<td>op_no</td>");
    out.println("<td>override</td>");
    out.println("</tr>"); 
    for(int i=0; i<childPart.size(); i++){
        out.println("<tr>");
        out.println("<td>"+parentPart.elementAt(i).toString()+"</td>");
       // out.println("<td>"+childPart.elementAt(i).toString()+"</td>");
        out.println("<td>"+iprod.elementAt(i).toString()+"</td>");
        out.println("<td>"+idesc.elementAt(i).toString()+"</td>");
        out.println("<td>"+idsce.elementAt(i).toString()+"</td>");
        out.println("<td>"+qty.elementAt(i).toString()+"</td>");
        out.println("<td>"+seqNo.elementAt(i).toString()+"</td>");
        out.println("<td>"+iteration.elementAt(i).toString()+"</td>");
        out.println("<td>"+uscCode.elementAt(i).toString()+"</td>");
        out.println("<td>"+rawQty.elementAt(i).toString()+"</td>");
        out.println("<td>"+scrapFactor.elementAt(i).toString()+"</td>");
        out.println("<td>"+opNo.elementAt(i).toString()+"</td>");
        out.println("<td>"+override.elementAt(i).toString()+"</td>");
        out.println("</tr>");
    }   
    out.println("</table>");
    stmt_bpcs.close();
    con_bpcs.close();
}
catch(Exception e){
    out.println("ErROR:"+e);
}%>