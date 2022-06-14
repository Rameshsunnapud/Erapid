<%@page import = "java.util.*" session="true"%>
<HTML>
  <HEAD>
    <TITLE>Using the Application Object</TITLE>
  </HEAD>

  <BODY>
    <H1>Using the Application Object</H1>
    <%
    Integer counter = (Integer)session.getAttribute("counter");
    String heading = null;
    if (counter == null) {
      counter = new Integer(1);
    } else {
      counter = new Integer(counter.intValue() + 1);
    }

    session.setAttribute("counter", counter);

    Integer applicationCounter = (Integer)application.getAttribute("applicationCounter");
    if (applicationCounter == null) {
      applicationCounter = new Integer(1);
    } else {
      applicationCounter = new Integer(applicationCounter.intValue() + 1);
    }

    application.setAttribute("applicationCounter", applicationCounter);
    %>

    You have visited this page <%=counter%> times.
    <BR>
    This page has been visited by all users <%=applicationCounter%> times.
  </BODY>
</HTML>