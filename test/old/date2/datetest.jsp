<% request.setCharacterEncoding( response.getCharacterEncoding() ); %>
<%@ page language="java"  contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="error.jsp" %>
<script language="JavaScript" src="/js/calendar-eightysize-v1.1.js"></script>
<script language="JavaScript" src="/js/mootools-1.2.4-core.js"></script>
<script language="JavaScript" src="/js/mootools-1.2.4.4-more.js"></script>
<link rel="stylesheet" href="/css/calendar-eightysix-v1.1-osx-dashboard.css" media="screen, projection" />
<link rel="stylesheet" href="/css/page.css" media="screen, projection" />
<table>
        <tr>
            <th>Example V</th>
            <td><input type="text" id="exampleV" name="dateIV" maxlength="10" /></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="example-info">Datepicker with minimum date of 'tomorrow', so only dates in the future can be picked. The default date is set on 'next Wednesday'. Theme is Default, red style.<br />
           
           
            <pre class="code brush: javascript">new CalendarEightysix('exampleV', { 'theme': 'default red', 'defaultDate': 'next Wednesday', 'minDate': 'tomorrow' });</pre>
            
            
            </td>
        </tr>
</table>
