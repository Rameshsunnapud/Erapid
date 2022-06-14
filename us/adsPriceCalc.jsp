<div id='pricecalc' class='pricecalc'>
	<iframe id='adsIframe' height='95%' width='100%' frameborder="0" src="https://<%=application.getInitParameter("HOST")%>/erapid/us/legacy/order_transfer_home.jsp?orderNo=<%=orderNo %>&cmd=1"></iframe>

</div>
<div id='pricecalc2' class='pricecalc'>
	<form name='priceCalcForm2'>

	</form>
	<div id='buttonsDiv' ></div>
</div>
<div id='mailDiv' ><%@ include file="email.jsp"%>    </div>
</div>