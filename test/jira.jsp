<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.io.*"  contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="error.jsp" %>
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<%

if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%@ include file="../db_con.jsp"%>
<%
out.println("<table border='1'>");
Vector columnNames=new Vector();


columnNames.addElement("Project");
columnNames.addElement("Key");
columnNames.addElement("Summary");
columnNames.addElement("Issue Type");
columnNames.addElement("Status");
columnNames.addElement("Priority");
columnNames.addElement("Resolution");
columnNames.addElement("Assignee");
//columnNames.addElement("Reporter");
//columnNames.addElement("Creator");
columnNames.addElement("Created");
//columnNames.addElement("Last Viewed");
columnNames.addElement("Updated");
columnNames.addElement("Resolved");
//columnNames.addElement("Affects Version/s");
//columnNames.addElement("Fix Version/s");
//columnNames.addElement("Component/s");
columnNames.addElement("Due Date");
//columnNames.addElement("Votes");
//columnNames.addElement("Watchers");
//columnNames.addElement("Images");
columnNames.addElement("Original Estimate");
//columnNames.addElement("Remaining Estimate");
//columnNames.addElement("Time Spent");
//columnNames.addElement("Work Ratio");
columnNames.addElement("Sub-Tasks");
columnNames.addElement("Linked Issues");
//columnNames.addElement("Environment");
columnNames.addElement("Description");
//columnNames.addElement("Security Level");
columnNames.addElement("Progress");
//columnNames.addElement("Σ Progress");
//columnNames.addElement("Σ Time Spent");
//columnNames.addElement("Σ Remaining Estimate");
//columnNames.addElement("Σ Original Estimate");
//columnNames.addElement("Labels");
//columnNames.addElement("Account");
//columnNames.addElement("Business Value");
//columnNames.addElement("Epic Color");
//columnNames.addElement("Epic Link");
columnNames.addElement("Epic Name");
columnNames.addElement("Epic Status");
//columnNames.addElement("Epic/Theme");
//columnNames.addElement("Flagged");
//columnNames.addElement("Iteration");
columnNames.addElement("Multiple Users");
//columnNames.addElement("Raised During");
//columnNames.addElement("Rank");
columnNames.addElement("Sprint");
columnNames.addElement("Story Points");
//columnNames.addElement("Team");
//columnNames.addElement("Test Sessions");
//columnNames.addElement("Testing Status");
//columnNames.addElement("[CHART] Date of First Response");

String select="";
out.println("<tr><th>#</th>");
for(int i=0; i<columnNames.size(); i++){
	out.println("<th>"+columnNames.elementAt(i).toString()+"</th>");
	//if(columnNames.elementAt(i).toString().indexOf(" ")<0){
	//	select=select+columnNames.elementAt(i).toString()+",";
	//}
	//else{
		select=select+"["+columnNames.elementAt(i).toString()+"],";
	//}
}
if(select.endsWith(",")){
	select=select.substring(0,select.length()-1);
}
//out.println(select);
out.println("</tr>");
String query="select "+select+" from jira order by sprint desc, project,status";
//out.println("<BR>"+query+"<BR>");
int a=1;
ResultSet rs1=stmt.executeQuery(query);
if(rs1 != null){
	while(rs1.next()){
		out.println("<tr><th>"+a+"</th>");
		a++;
		for(int i=0; i<columnNames.size(); i++){
		//out.println("::"+i+"::");
			String temp="&nbsp;";
			if(rs1.getString(i+1)!=null){
				temp=rs1.getString(i+1);
}


			out.println("<td>"+temp+"</td>");
		}
		out.println("</tr>");
	}
}
rs1.close();
out.println("</table>");
Vector projectName=new Vector();
Vector sprintName=new Vector();
Vector totalStoryPoints=new Vector();
Vector completedStoryPoints=new Vector();
ResultSet rs2=stmt.executeQuery("select project,sprint,sum(cast([story points] as numeric)) from jira group by sprint,project order by sprint desc");
if(rs2 != null){
	while(rs2.next()){

		String temp="&nbsp;";
		if(rs2.getString(1)!=null){
			temp=rs2.getString(1);
		}
		projectName.addElement(temp);

		temp="&nbsp;";
		if(rs2.getString(2)!=null){
			temp=rs2.getString(2);
		}
		sprintName.addElement(temp);
		temp="&nbsp;";
		if(rs2.getString(3)!=null){
			temp=rs2.getString(3);
		}
		totalStoryPoints.addElement(temp);
		completedStoryPoints.addElement(temp);

	}
}
rs2.close();
out.println("<table border='1'><tr><th>Project</th><th>Sprint</th><th>Sprint total story points</th><th>Sprint completed story points</th></tr>");
double storyPointAverage=0;
double numSprints=0;
for(int i=0; i<projectName.size(); i++){
	query="select sum(cast([story points] as numeric)) from jira where project='"+projectName.elementAt(i).toString()+"' and sprint='"+sprintName.elementAt(i).toString()+"' and status='done'";
	//out.println(query+"<BR>");
	ResultSet rs3=stmt.executeQuery(query);
	if(rs3 != null){
		while(rs3.next()){
			//out.println(rs3.getString(1)+"<BR>");
			String temp="&nbsp;";
			if(rs3.getString(1)!=null){
				temp=rs3.getString(1);
			}
			completedStoryPoints.setElementAt(temp,i);
		}

	}
	rs3.close();
	out.println("<tr>");
	out.println("<td>"+projectName.elementAt(i).toString()+"</td>");
	out.println("<td>"+sprintName.elementAt(i).toString()+"</td>");
	out.println("<td>"+totalStoryPoints.elementAt(i).toString()+"</td>");
	out.println("<td>"+completedStoryPoints.elementAt(i).toString()+"</td>");
	out.println("</tr>");
	if(!sprintName.elementAt(i).toString().equals("&nbsp;") && sprintName.elementAt(i).toString().trim().length()>0&&completedStoryPoints.elementAt(i).toString()!=null && completedStoryPoints.elementAt(i).toString().trim().length()>=0){
		storyPointAverage=storyPointAverage+new Double(completedStoryPoints.elementAt(i).toString()).doubleValue();
		numSprints++;
	}
}
out.println("<tr>");
out.println("<td colspan='3' align='right'>AVERAGE SPRINT VELOCITY</td>");
out.println("<td>"+storyPointAverage/numSprints+"</td>");
out.println("</tr>");



out.println("</table>");
}
catch(Exception e){
out.println(e);
}
%>
