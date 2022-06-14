<% request.setCharacterEncoding( response.getCharacterEncoding() ); %>
<SCRIPT language="JavaScript">
	var counter=20;
	function doThis(){
		if(counter>0){
			setTimeout("doThis2();",1000);
		}
	}
	function doThis2(){
		counter--;
		document.getElementById('countLabel').innerHTML=""+counter;
		doThis();
		if(counter<=0){
			//alert("count down done");
			window.close();
		}

	}
</script>
<jsp:useBean id="convert" class="com.csgroup.general.Convertor" scope="page"/>
<%@ page language="java" import="java.text.*" import="java.util.*" import="java.io.*"   contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="error.jsp" %>
<%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String url=request.getParameter("urlx");
String urlAdd=request.getParameter("urlAddx");
String orderNo=request.getParameter("orderNo");
String action=request.getParameter("action");
String imstype=request.getParameter("imstype");

String rep_no=request.getParameter("rep_no");
String userId=request.getParameter("userId");
String product=request.getParameter("product");
String sections=request.getParameter("sections");

//&rep_no=347&userId=jmik347&product=GCP&totmat_price=3866&sections=,

if(url.contains("new_ows"))
{
	url=url+"?orderNo="+orderNo+"&rep_no="+rep_no+"&userId="+userId+"&product="+product+"&sections="+sections;
}

String env="";
	if(request.getParameter("env") != null && !request.getParameter("env").isEmpty()){
		 env=request.getParameter("env");
	}
	
	//out.println("env :: "+request.getParameter("env"));
	logger.debug("env :: "+request.getParameter("env"));
if(url.indexOf("orderNo")<0){
	url=""+application.getInitParameter("HOST")+"/erapid/us/"+url+"?orderNo="+orderNo+"&action="+action+"&env="+env;
}
else{
		url=""+application.getInitParameter("HOST")+"/erapid/us/"+url+"&action="+action+"&env="+env;
}
//out.println(urlAdd);
if(urlAdd != null && urlAdd.trim().length()>0){
        urlAdd=urlAdd.replaceAll("!","&");
        urlAdd=urlAdd.replaceAll("@","=");
	url=url+urlAdd;
}
logger.debug(url);
String path="";
if(action.equals("rtf")){
	path=convert.htmlToRtf(url,"",orderNo,"","", "");
}
if(action.equals("pdf")){
	//out.println("<script>alert('Testing IMS for documents for Rep portal please clicl ok to proceed : '"+url+"')</script>");
	path=convert.htmlToPdf(url,"",orderNo,"","", "");
	//out.println("<script>alert('"+url+"')</script>");
}
if(action.equals("ims")){
	//out.println("<script>alert('Testing IMS for documents for Rep portal please clicl ok to proceed')</script>");
	path=convert.htmlToIMS(url,"",orderNo,"","", "",imstype);
	//out.println("<script>alert('"+path+"')</script>");
}
out.println(url);
out.println(" "+path);

if(action.equals("ims")){
	//out.println("IMS");
	out.println("<body onload='window.close()'>");
}
else{
	String browserType = request.getHeader("User-Agent");
	String testgreg="https://"+application.getInitParameter("HOST")+"/erapid/shared/"+path;
	//if(!path.toLowerCase().endsWith(".pdf")){
out.println("<body onload='doThis()'><FONT COLOR='red' size='4'>THIS WINDOW WILL CLOSE IN <label id='countLabel'>x</label> SECONDS");
		if(browserType.toUpperCase().indexOf("FIREFOX")>0||browserType.toUpperCase().indexOf("CHROME")>0||browserType.toUpperCase().indexOf("SAFARI")>0){
			out.println("<META HTTP-EQUIV='REFRESH' Content='0;"+testgreg+"'>");
		}
		else{
			testgreg="URL=https:\\\\"+application.getInitParameter("HOST")+"\\erapid\\shared\\"+path;
			out.println("<META HTTP-EQUIV='REFRESH' Content='0;"+testgreg+"'>");
		}
/*
	}
	else{
		if(browserType.toUpperCase().indexOf("FIREFOX")<0&&browserType.toUpperCase().indexOf("CHROME")<0&&browserType.toUpperCase().indexOf("SAFARI")<0){
			testgreg="https:\\\\"+application.getInitParameter("HOST")+"\\erapid\\shared\\"+path;
		}
%>
<object data="<%=testgreg%>" type="application/pdf" width="100%" height="100%">
	<p>You don not have a PDF plugin for this browser.
		You can <a href="<%=testgreg%>">click here to
			download the PDF file.</a></p>
</object>
<%
}
*/
}
%>