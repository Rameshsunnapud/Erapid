<%@ page language="java" import="java.text.*" %>
<%
String ol="";
//out.println("Hello world"+ol);

for (int nb=1; nb<=16; nb++){
	int nc=0;
	for (int i=4; i>0; i--){
		if(nb%i==0 || (i-(nb%i) <2)){
			nc=i;
			out.println(nb+" - "+nc+"<br>");
			i=0;
		}
	}
}
%>
