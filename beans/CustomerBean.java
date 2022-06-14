package com.csgroup.general;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import org.w3c.dom.*;

import java.io.*;
import java.sql.*;
import java.util.*;


public class CustomerBean{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String dbServerName = "";
	String dbServerPort = "";
	String erapidDB = "";
	String erapidSysDB = "";
	String erapidDBUsername = "";
	String erapidDBPassword = "";

	String query = "";
	String query2 = "";
	String queryback = "";

	String custNo = "";
	String custName1 = "";
	String custName2 = "";
	String custAddr1 = "";
	String custAddr2 = "";
	String attention = "";
	String salutation = "";
	String city = "";
	String state = "";
	String zipCode = "";
	String country = "";
	String phone = "";
	String countryCode = "";
	String currency = "";
	String shippingCity = "";
	String fax = "";
	String email = "";
	String custNoText = "";
	String createdRepNo = "";
	String billCust = "";
	String marketType = "";
	String contactName = "";
	String bpcsCustNo = "";
	String dormant = "";

	//search variables
	String searchRepNo = "";
	String searchRepGroup = "";
	String searchRepCountry = "";
	String searchCustomerName = "";
	String searchCustomerCity = "";
	String searchCustomerBpcsNo = "";
	String editCustNo = "";
	String editCountryCode = "";
	String functionName = "";
	String firstOrderNo = "";
	String lastOrderNo = "";

	public void setEditCountryCode(String x){
		this.editCountryCode = x;
	}

	public void setEditCustNo(String x){
		this.editCustNo = x;
	}

	public void setSearchRepNo(String x){
		this.searchRepNo = x;
	}

	public void setSearchRepGroup(String x){
		this.searchRepGroup = x;
	}

	public void setSearchRepCountry(String x){
		this.searchRepCountry = x;
	}

	public void setSearchCustomerName(String x){
		this.searchCustomerName = x;
	}

	public void setSearchCustomerCity(String x){
		this.searchCustomerCity = x;
	}

	public void setSearchCustomerBpcsNo(String x){
		this.searchCustomerBpcsNo = x;
	}

	public void setCountryCode(String x){
		this.countryCode = x;
		setCustomerInfo();
	}

	public void setCustNo(String x){
		this.custNo = x;
		setCustomerInfo();
	}

	public void setCustomerInfo(){
		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("d:\\erapid\\erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					dbServerName = "" + getTagValue("dbServerName",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
				}
			}
			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			query = "select * from cs_customers where cust_no='" + custNo + "' and country_code='" + countryCode + "'";
			ResultSet rs1 = stmt.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					this.custName1 = rs1.getString("cust_name1");
					this.custName2 = rs1.getString("cust_name2");
					this.custAddr1 = rs1.getString("cust_addr1");
					this.custAddr2 = rs1.getString("cust_addr2");
					this.attention = rs1.getString("attention");
					this.salutation = rs1.getString("salutation");
					this.city = rs1.getString("city");
					this.state = rs1.getString("state");
					this.zipCode = rs1.getString("zip_code");
					this.country = rs1.getString("country");
					this.phone = rs1.getString("phone");
					this.currency = rs1.getString("currency");
					this.shippingCity = rs1.getString("shipping_city");
					this.fax = rs1.getString("fax");
					this.email = rs1.getString("email");
					this.custNoText = rs1.getString("cust_no_text");
					this.createdRepNo = rs1.getString("created_rep_no");
					this.billCust = rs1.getString("bill_cust");
					this.marketType = rs1.getString("market_type");
					this.contactName = rs1.getString("contact_name");
					this.bpcsCustNo = rs1.getString("bpcs_cust_no");
					this.dormant = rs1.getString("dormant");
				}
			}
			rs1.close();

		}
		catch(Exception e){
			logger.debug("CustomerBean.setCustNo");
			logger.debug(e.getMessage());
			logger.debug("CustomerBean.setCustNo END");
		}
		finally{
			try{
				stmt.close();
				myConn.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
	}

	public String getCustNo(){
		return custNo;
	}

	public String getCustName1(){
		return custName1;
	}

	public String getCustName2(){
		return custName2;
	}

	public String getCustAddr1(){
		return custAddr1;
	}

	public String getCustAddr2(){
		return custAddr2;
	}

	public String getAttention(){
		return attention;
	}

	public String getSalutation(){
		return salutation;
	}

	public String getCity(){
		return city;
	}

	public String getState(){
		return state;
	}

	public String getZipCode(){
		return zipCode;
	}

	public String getCountry(){
		return country;
	}

	public String getPhone(){
		return phone;
	}

	public String getCountryCode(){
		return countryCode;
	}

	public String getCurrency(){
		return currency;
	}

	public String getShippingCity(){
		return shippingCity;
	}

	public String getFax(){
		return fax;
	}

	public String getEmail(){
		return email;
	}

	public String getCustNoText(){
		return custNoText;
	}

	public String getCreatedRepNo(){
		return createdRepNo;
	}

	public String getBillCust(){
		return billCust;
	}

	public String getMarketType(){
		return marketType;
	}

	public String getContactName(){
		return contactName;
	}

	public String getBpcsCustNo(){
		return bpcsCustNo;
	}

	public String getDormant(){
		return dormant;
	}

	public String checkCustomer(String checkAddr1,String checkCity,String checkCreatedRepNo){
		String resultx = "";
		String div = "";
		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("d:\\erapid\\erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					dbServerName = "" + getTagValue("dbServerName",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
				}
			}
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("search");
			doc2.appendChild(resultList);
			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			ResultSet rs = stmt.executeQuery("select top 5 * from cs_customers where cust_addr1='" + checkAddr1 + "' and city='" + checkCity + "' and created_rep_no='" + checkCreatedRepNo + "'");
			if(rs != null){
				while(rs.next()){

					String temp1 = rs.getString("cust_name1");
					if(temp1 == null || temp1.equals("null")){
						temp1 = "";
					}
					String temp2 = rs.getString("cust_name2");
					if(temp2 == null || temp2.equals("null")){
						temp2 = "";
					}
					resultx = resultx + temp1 + " " + temp2 + "\n\r";
				}
			}
			rs.close();
			Element resulty = doc2.createElement("searchresult");
			resultList.appendChild(resulty);
			Element isDup = doc2.createElement("isDup");
			isDup.appendChild(doc2.createTextNode(resultx.trim() + "#"));
			resulty.appendChild(isDup);
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult result = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,result);
			div = writer.toString().trim();

		}
		catch(Exception e){
			logger.debug("CustomerBean.checkCustomer()");
			logger.debug(e.getMessage());
			logger.debug("CustomerBean.checkCustomer() END");
		}
		finally{
			try{
				stmt.close();
				myConn.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
		return div;
	}

	public String saveCustomer(String custNo,String custName1,String custName2,String custAddr1,String custAddr2,String city,String state,String zipCode,String country,String countryCode,String bpcsCustNo,String attention,String salutation,String phone,String currency,String shippingCity,String fax,String email,String custNoText,String createdRepNo,String billCust,String marketType,String contactName,String dormant){
		if(custNo == null){
			custNo = "";
		}
		if(custName1 == null){
			custName1 = "";
		}
		if(custName2 == null){
			custName2 = "";
		}
		if(custAddr1 == null){
			custAddr1 = "";
		}
		if(custAddr2 == null){
			custAddr2 = "";
		}
		if(attention == null){
			attention = "";
		}
		if(salutation == null){
			salutation = "";
		}
		if(city == null){
			city = "";
		}
		if(state == null){
			state = "";
		}
		if(zipCode == null){
			zipCode = "";
		}
		if(country == null){
			country = "";
		}
		if(phone == null){
			phone = "";
		}
		if(countryCode == null){
			countryCode = "";
		}
		if(currency == null){
			currency = "";
		}
		if(shippingCity == null){
			shippingCity = "";
		}
		if(fax == null){
			fax = "";
		}
		if(email == null){
			email = "";
		}
		if(custNoText == null){
			custNoText = "";
		}
		if(createdRepNo == null){
			createdRepNo = "";
		}
		if(billCust == null){
			billCust = "";
		}
		if(marketType == null){
			marketType = "";
		}
		if(contactName == null){
			contactName = "";
		}
		if(bpcsCustNo == null){
			bpcsCustNo = "";
		}
		if(dormant == null){
			dormant = "";
		}
		if(dormant.equals("true")){
			dormant = "y";
		}
		else{
			dormant = "";
		}
		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("d:\\erapid\\erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");

			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					dbServerName = "" + getTagValue("dbServerName",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
				}
			}

			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();

			if(custNo.trim().length() > 0){

				try{
					java.sql.PreparedStatement updateCsCustomers = myConn.prepareStatement("UPDATE cs_customers set cust_name1=?,cust_name2=?,cust_addr1=?,cust_addr2=?,city=?,state=?,zip_code=?,country=?,bpcs_cust_no=?,attention=?,salutation=?,phone=?,currency=?,shipping_city=?,fax=?,email=?,cust_no_text=?,created_rep_no=?,bill_cust=?,market_type=?,contact_name=?,dormant=? WHERE cust_no=? and country_code=?");
					updateCsCustomers.setString(1,custName1);
					updateCsCustomers.setString(2,custName2);
					updateCsCustomers.setString(3,custAddr1);
					updateCsCustomers.setString(4,custAddr2);
					updateCsCustomers.setString(5,city);
					updateCsCustomers.setString(6,state);
					updateCsCustomers.setString(7,zipCode);
					updateCsCustomers.setString(8,country);
					updateCsCustomers.setString(9,bpcsCustNo);
					updateCsCustomers.setString(10,attention);
					updateCsCustomers.setString(11,salutation);
					updateCsCustomers.setString(12,phone);
					updateCsCustomers.setString(13,currency);
					updateCsCustomers.setString(14,shippingCity);
					updateCsCustomers.setString(15,fax);
					updateCsCustomers.setString(16,email);
					updateCsCustomers.setString(17,custNoText);
					updateCsCustomers.setString(18,createdRepNo);
					updateCsCustomers.setString(19,billCust);
					updateCsCustomers.setString(20,marketType);
					updateCsCustomers.setString(21,contactName);
					updateCsCustomers.setString(22,dormant);
					updateCsCustomers.setInt(23,Integer.parseInt(custNo.trim()));
					updateCsCustomers.setString(24,countryCode);
					int rocount = updateCsCustomers.executeUpdate();
					updateCsCustomers.close();
				}
				catch(SQLException ee){
					logger.debug(" customerbean.savecustomer");
					logger.debug(" edit existing customer");
					logger.debug(" cs_customer sqlexception ");
					logger.debug(ee.getMessage());
					logger.debug(" customerbean.savecustomer END");
				}
				catch(Exception e){
					logger.debug(" customerbean.savecustomer");
					logger.debug(" edit exiting customer");
					logger.debug(" cs_customer");
					logger.debug(e.getMessage());
					logger.debug("customerbean.savecustomerr END");
				}
			}
			else{
				int newCustNo = 0;
				try{
					//int newCustNo=0;
					// find customer number
					ResultSet rsCustNo = stmt.executeQuery("SELECT counter FROM cs_country_codes where code = '" + countryCode + "'");
					if(rsCustNo != null){
						while(rsCustNo.next()){
							newCustNo = rsCustNo.getInt("counter");
						}
					}
					rsCustNo.close();
					String newCustNoText = "" + newCustNo;
					if(countryCode.equals("GB")){
						newCustNoText = "" + newCustNo;
					}

					java.sql.PreparedStatement insertCsCustomers = myConn.prepareStatement("insert into cs_customers (cust_name1,cust_name2,cust_addr1,cust_addr2,city,state,zip_code,country,bpcs_cust_no,attention,salutation,phone,currency,shipping_city,fax,email,cust_no_text,created_rep_no,bill_cust,market_type,contact_name,dormant,cust_no,country_code) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					insertCsCustomers.setString(1,custName1);
					insertCsCustomers.setString(2,custName2);
					insertCsCustomers.setString(3,custAddr1);
					insertCsCustomers.setString(4,custAddr2);
					insertCsCustomers.setString(5,city);
					insertCsCustomers.setString(6,state);
					insertCsCustomers.setString(7,zipCode);
					insertCsCustomers.setString(8,country);
					insertCsCustomers.setString(9,bpcsCustNo);
					insertCsCustomers.setString(10,attention);
					insertCsCustomers.setString(11,salutation);
					insertCsCustomers.setString(12,phone);
					insertCsCustomers.setString(13,currency);
					insertCsCustomers.setString(14,shippingCity);
					insertCsCustomers.setString(15,fax);
					insertCsCustomers.setString(16,email);
					insertCsCustomers.setString(17,newCustNoText);
					insertCsCustomers.setString(18,createdRepNo);
					insertCsCustomers.setString(19,billCust);
					insertCsCustomers.setString(20,marketType);
					insertCsCustomers.setString(21,contactName);
					insertCsCustomers.setString(22,dormant);
					insertCsCustomers.setInt(23,newCustNo);
					insertCsCustomers.setString(24,countryCode);
					int rocount = insertCsCustomers.executeUpdate();
					insertCsCustomers.close();
					custNo = "" + newCustNo;
					newCustNo++;
					int nrow = stmt.executeUpdate("UPDATE cs_country_codes SET counter =" + newCustNo + " WHERE code ='" + countryCode + "'");
				}
				catch(SQLException ee){
					logger.debug(" customerbean.savecustomer");
					logger.debug(" add new customer");
					logger.debug(newCustNo + "::" + countryCode + ":: cs_customer sqlexception ");
					logger.debug(ee.getMessage());
					logger.debug(" customerbean.savecustomer END");
				}
				catch(Exception e){
					logger.debug(" customerbean.savecustomer");
					logger.debug(" add new customer");
					logger.debug(" cs_customer");
					logger.debug(e.getMessage());
					logger.debug("customerbean.savecustomerr END");
				}

			}

		}
		catch(Exception e){
			logger.debug("CustomerBean.saveCustomer start");
			logger.debug(" start db connections");
			logger.debug(e.getMessage());
			logger.debug("CustomerBean.saveCustomer start");
		}
		finally{
			try{
				stmt.close();
				myConn.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
		return custNo;
	}

	public void setFirstOrderNo(String x){
		this.firstOrderNo = x;
	}

	public void setLastOrderNo(String x){
		this.lastOrderNo = x;
	}

	public void setFunctionName(String x){
		this.functionName = x;
	}

	public String getCustomerSearchDiv(){
		//logger.debug("GetCustomerSearchDiv()");
		String div = "";
		String tempGroup = "";
		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("d:\\erapid\\erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					dbServerName = "" + getTagValue("dbServerName",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
				}
			}
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("search");
			doc2.appendChild(resultList);
			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");

			ResultSet rsCsReps = stmt.executeQuery("select group_id from cs_reps where rep_no_text='" + searchRepNo + "'");
			if(rsCsReps != null){
				while(rsCsReps.next()){
					tempGroup = rsCsReps.getString(1);
				}
			}
			rsCsReps.close();

			boolean isWhereClause = false;
			query2 = "SELECT count(*) FROM cs_customers WHERE  ";
			query = "SELECT TOP 50 cust_no,cust_name1,cust_name2,cust_addr1,cust_addr2,attention,salutation,city,state,zip_code,country,phone,country_code,currency,shipping_city,fax,email,cust_no_text,created_rep_no,bill_cust,market_type,contact_name,bpcs_cust_no,dormant FROM cs_customers WHERE ";
			queryback = "SELECT TOP 50 cust_no from cs_customers WHERE ";
			isWhereClause = true;
			String whereClause = "";
			if(tempGroup.toUpperCase().indexOf("REP") >= 0 && searchRepNo != null && searchRepNo.trim().length() > 0){
				String repNums = "'" + searchRepNo;
				ResultSet rsCsRepMapping = stmt.executeQuery("Select rep_cust from cs_rep_mapping where rep_no like '" + searchRepNo + "'");
				if(rsCsRepMapping != null){
					while(rsCsRepMapping.next()){
						repNums = repNums + "," + rsCsRepMapping.getString(1);
					}
				}
				rsCsRepMapping.close();
				for(int a = 0;a < repNums.length();a++){
					int x = repNums.indexOf(",",a);
					if(x > 0){
						repNums = repNums.substring(0,x) + "'" + repNums.substring(x,x + 1) + "'" + repNums.substring(x + 1);
						a = x + 2;
					}
				}
				repNums = repNums + "'";
				whereClause = whereClause + " created_rep_no in (" + repNums + ") and ";
				isWhereClause = true;
			}

			boolean isCustName = false;
			boolean isCustCity = false;
			boolean isBpcsNo = false;
			if(searchRepCountry != null && searchRepCountry.trim().length() > 0){
				whereClause = whereClause + " country_code='" + searchRepCountry + "' and ";
				isWhereClause = true;
			}
			if(searchCustomerName != null && searchCustomerName.trim().length() > 0){
				whereClause = whereClause + " cust_name1 like  '" + searchCustomerName + "%' and ";
				if(searchCustomerName.length() > 3){
					isCustName = true;
				}
				isWhereClause = true;
			}
			if(searchCustomerCity != null && searchCustomerCity.trim().length() > 0){
				whereClause = whereClause + " city like '" + searchCustomerCity + "%' and ";
				if(searchCustomerCity.length() > 3){
					isCustCity = true;
				}
				isWhereClause = true;
			}
			//logger.debug("BERFORE" + searchCustomerBpcsNo);
			if(searchCustomerBpcsNo != null && searchCustomerBpcsNo.trim().length() > 0){
				whereClause = whereClause + " bpcs_cust_no like '" + searchCustomerBpcsNo + "%' and ";
				if(searchCustomerBpcsNo.length() > 3){
					isBpcsNo = true;
				}
				isWhereClause = true;
			}
			//logger.debug("after");
			if(isCustCity || isCustName || isBpcsNo){
				query2 = "SELECT count(*) FROM cs_customers WHERE  ";
				query = "SELECT cust_no,cust_name1,cust_name2,cust_addr1,cust_addr2,attention,salutation,city,state,zip_code,country,phone,country_code,currency,shipping_city,fax,email,cust_no_text,created_rep_no,bill_cust,market_type,contact_name,bpcs_cust_no,dormant FROM cs_customers WHERE ";
				queryback = "SELECT cust_no from cs_customers WHERE ";
			}

			whereClause = whereClause + " (dormant is null or not dormant = 'y') and ";
			isWhereClause = true;
			query = query + whereClause;
			query2 = query2 + whereClause;
			queryback = queryback + whereClause;
			if(functionName.equals("forward")){
				query = query + " cust_no < '" + lastOrderNo + "' and ";
			}
			else if(functionName.equals("back")){
				query = query + " cust_no > '" + firstOrderNo + "' and cust_no in (" + queryback + " cust_no > '" + firstOrderNo + "' order by cust_no ) and ";
			}
			if(functionName.equals("end")){
				if(queryback.trim().endsWith(" and")){
					queryback = queryback.substring(0,queryback.length() - 5);
				}
				query = query + " cust_no in (" + queryback + " order by cust_no ) and ";
			}
			if(query.trim().endsWith(" and")){
				query = query.substring(0,query.length() - 5);
				query2 = query2.substring(0,query2.length() - 5);
				queryback = queryback.substring(0,queryback.length() - 5);

			}

			query = query + " order by cust_name1 ";

			if(isWhereClause){
				int rowCount = 0;
				ResultSet rsCount = stmt.executeQuery(query2);
				if(rsCount != null){
					while(rsCount.next()){
						rowCount = rsCount.getInt(1);
						Element rowcount = doc2.createElement("rowcount");
						rowcount.appendChild(doc2.createTextNode("" + rowCount));
						resultList.appendChild(rowcount);
					}
				}
				rsCount.close();
				if(functionName.equals("end")){
					rowCount = rowCount % 20;
					if(rowCount == 0){
						rowCount = 20;
					}
					query = query.replaceAll("20","" + rowCount);
				}

				ResultSet rs1 = stmt.executeQuery(query);
				String[] line = new String[2];
				if(rs1 != null){
					while(rs1.next()){
						String custNoTemp = rs1.getString("cust_no");
						String custName1Temp = rs1.getString("cust_name1");
						String custName2Temp = rs1.getString("cust_name2");
						String custAddr1Temp = rs1.getString("cust_addr1");
						String custAddr2Temp = rs1.getString("cust_addr2");
						String attentionTemp = rs1.getString("attention");
						String salutationTemp = rs1.getString("salutation");
						String cityTemp = rs1.getString("city");
						String stateTemp = rs1.getString("state");
						String zipCodeTemp = rs1.getString("zip_code");
						String countryTemp = rs1.getString("country");
						String phoneTemp = rs1.getString("phone");
						String countryCodeTemp = rs1.getString("country_code");
						String currencyTemp = rs1.getString("currency");
						String shippingCityTemp = rs1.getString("shipping_city");
						String faxTemp = rs1.getString("fax");
						String emailTemp = rs1.getString("email");
						String custNoTextTemp = rs1.getString("cust_no_text");
						String createdRepNoTemp = rs1.getString("created_rep_no");
						String billingCustTemp = rs1.getString("bill_cust");
						String marketTypeTemp = rs1.getString("market_type");
						String contactNameTemp = rs1.getString("contact_name");
						String bpcsCustNoTemp = rs1.getString("bpcs_cust_no");
						String dormantTemp = rs1.getString("dormant");
						if(custNoTemp == null){
							custNoTemp = " ";
						}
						if(custName1Temp == null){
							custName1Temp = " ";
						}
						if(custName2Temp == null){
							custName2Temp = " ";
						}
						if(custAddr1Temp == null){
							custAddr1Temp = " ";
						}
						if(custAddr2Temp == null){
							custAddr2Temp = " ";
						}
						if(attentionTemp == null){
							attentionTemp = " ";
						}
						if(salutationTemp == null){
							salutationTemp = " ";
						}
						if(cityTemp == null){
							cityTemp = " ";
						}
						if(stateTemp == null){
							stateTemp = " ";
						}
						if(zipCodeTemp == null){
							zipCodeTemp = " ";
						}
						if(countryTemp == null){
							countryTemp = " ";
						}
						if(phoneTemp == null){
							phoneTemp = " ";
						}
						if(countryCodeTemp == null){
							countryCodeTemp = " ";
						}
						if(currencyTemp == null){
							currencyTemp = " ";
						}
						if(shippingCityTemp == null){
							shippingCityTemp = " ";
						}
						if(faxTemp == null){
							faxTemp = " ";
						}
						if(emailTemp == null){
							emailTemp = " ";
						}
						if(custNoTextTemp == null){
							custNoTextTemp = " ";
						}
						if(createdRepNoTemp == null){
							createdRepNoTemp = " ";
						}
						if(billingCustTemp == null){
							billingCustTemp = " ";
						}
						if(marketTypeTemp == null){
							marketTypeTemp = " ";
						}
						if(contactNameTemp == null){
							contactNameTemp = " ";
						}
						if(bpcsCustNoTemp == null){
							bpcsCustNoTemp = " ";
						}
						if(dormantTemp == null){
							dormantTemp = " ";
						}
						Element result = doc2.createElement("searchresult");
						resultList.appendChild(result);
						Element custNo = doc2.createElement("custNo");
						custNo.appendChild(doc2.createTextNode(custNoTemp.trim() + "#"));
						result.appendChild(custNo);
						Element custName1 = doc2.createElement("custName1");
						custName1.appendChild(doc2.createTextNode(custName1Temp.trim() + "#"));
						result.appendChild(custName1);
						Element custName2 = doc2.createElement("custName2");
						custName2.appendChild(doc2.createTextNode(custName2Temp.trim() + "#"));
						result.appendChild(custName2);
						Element custAddr1 = doc2.createElement("custAddr1");
						custAddr1.appendChild(doc2.createTextNode(custAddr1Temp.trim() + "#"));
						result.appendChild(custAddr1);
						Element custAddr2 = doc2.createElement("custAddr2");
						custAddr2.appendChild(doc2.createTextNode(custAddr2Temp.trim() + "#"));
						result.appendChild(custAddr2);
						Element attention = doc2.createElement("attention");
						attention.appendChild(doc2.createTextNode(attentionTemp.trim() + "#"));
						result.appendChild(attention);
						Element salutation = doc2.createElement("salutation");
						salutation.appendChild(doc2.createTextNode(salutationTemp.trim() + "#"));
						result.appendChild(salutation);
						Element city = doc2.createElement("city");
						city.appendChild(doc2.createTextNode(cityTemp.trim() + "#"));
						result.appendChild(city);
						Element state = doc2.createElement("state");
						state.appendChild(doc2.createTextNode(stateTemp.trim() + "#"));
						result.appendChild(state);
						Element zipCode = doc2.createElement("zipCode");
						zipCode.appendChild(doc2.createTextNode(zipCodeTemp.trim() + "#"));
						result.appendChild(zipCode);
						Element country = doc2.createElement("country");
						country.appendChild(doc2.createTextNode(countryTemp.trim() + "#"));
						result.appendChild(country);
						Element phone = doc2.createElement("phone");
						phone.appendChild(doc2.createTextNode(phoneTemp.trim() + "#"));
						result.appendChild(phone);
						Element countryCode = doc2.createElement("countryCode");
						countryCode.appendChild(doc2.createTextNode(countryCodeTemp.trim() + "#"));
						result.appendChild(countryCode);
						Element currency = doc2.createElement("currency");
						currency.appendChild(doc2.createTextNode(currencyTemp.trim() + "#"));
						result.appendChild(currency);
						Element shippingCity = doc2.createElement("shippingCity");
						shippingCity.appendChild(doc2.createTextNode(shippingCityTemp.trim() + "#"));
						result.appendChild(shippingCity);
						Element fax = doc2.createElement("fax");
						fax.appendChild(doc2.createTextNode(faxTemp.trim() + "#"));
						result.appendChild(fax);
						Element email = doc2.createElement("email");
						email.appendChild(doc2.createTextNode(emailTemp.trim() + "#"));
						result.appendChild(email);
						Element custNoText = doc2.createElement("custNoText");
						custNoText.appendChild(doc2.createTextNode(custNoTextTemp.trim() + "#"));
						result.appendChild(custNoText);
						Element createdRepNo = doc2.createElement("createdRepNo");
						createdRepNo.appendChild(doc2.createTextNode(createdRepNoTemp.trim() + "#"));
						result.appendChild(createdRepNo);
						Element billingCust = doc2.createElement("billingCust");
						billingCust.appendChild(doc2.createTextNode(billingCustTemp.trim() + "#"));
						result.appendChild(billingCust);
						Element marketType = doc2.createElement("marketType");
						marketType.appendChild(doc2.createTextNode(marketTypeTemp.trim() + "#"));
						result.appendChild(marketType);
						Element contactName = doc2.createElement("contactName");
						contactName.appendChild(doc2.createTextNode(contactNameTemp.trim() + "#"));
						result.appendChild(contactName);
						Element bpcsCustNo = doc2.createElement("bpcsCustNo");
						bpcsCustNo.appendChild(doc2.createTextNode(bpcsCustNoTemp.trim() + "#"));
						result.appendChild(bpcsCustNo);
						Element dormant = doc2.createElement("dormant");
						dormant.appendChild(doc2.createTextNode(dormantTemp.trim() + "#"));
						result.appendChild(dormant);
					}
				}
				rs1.close();
				TransformerFactory tFact = TransformerFactory.newInstance();
				Transformer trans = tFact.newTransformer();
				StringWriter writer = new StringWriter();
				StreamResult result = new StreamResult(writer);
				DOMSource source = new DOMSource(doc2);
				trans.transform(source,result);
				div = writer.toString().trim();
				//logger.debug(div);
			}

		}
		catch(Exception e){
			logger.debug("CustomerBean" + query);
			logger.debug(query2);
			logger.debug("getCustomerSearchDiv()");
			logger.debug(e.getMessage());
			logger.debug("CustomerBean END");
		}
		finally{
			try{
				stmt.close();
				myConn.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
		return div;
	}

	public String getCustomerEditDiv(){
		String div = "";
		Connection myConn = null;
		Statement stmt = null;
		try{
			boolean isWhereClause = false;
			query = "SELECT cust_no,cust_name1,cust_name2,cust_addr1,cust_addr2,attention,salutation,city,state,zip_code,country,phone,country_code,currency,shipping_city,fax,email,cust_no_text,created_rep_no,bill_cust,market_type,contact_name,bpcs_cust_no,dormant FROM cs_customers WHERE ";
			isWhereClause = true;
			String whereClause = "";
			if(editCustNo != null && editCustNo.trim().length() > 0){
				whereClause = whereClause + " cust_no='" + editCustNo + "' and ";
				isWhereClause = true;
			}
			if(editCountryCode != null && editCountryCode.trim().length() > 0){
				whereClause = whereClause + " country_code='" + editCountryCode + "' ";
				isWhereClause = true;
			}
			query = query + whereClause;
			File fXmlFile = new File("d:\\erapid\\erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					dbServerName = "" + getTagValue("dbServerName",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
				}
			}
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("search");
			doc2.appendChild(resultList);
			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			if(isWhereClause){
				ResultSet rs1 = stmt.executeQuery(query);
				String[] line = new String[2];
				if(rs1 != null){
					while(rs1.next()){
						String custNoTemp = rs1.getString("cust_no");
						String custName1Temp = rs1.getString("cust_name1");
						String custName2Temp = rs1.getString("cust_name2");
						String custAddr1Temp = rs1.getString("cust_addr1");
						String custAddr2Temp = rs1.getString("cust_addr2");
						String attentionTemp = rs1.getString("attention");
						String salutationTemp = rs1.getString("salutation");
						String cityTemp = rs1.getString("city");
						String stateTemp = rs1.getString("state");
						String zipCodeTemp = rs1.getString("zip_code");
						String countryTemp = rs1.getString("country");
						String phoneTemp = rs1.getString("phone");
						String countryCodeTemp = rs1.getString("country_code");
						String currencyTemp = rs1.getString("currency");
						String shippingCityTemp = rs1.getString("shipping_city");
						String faxTemp = rs1.getString("fax");
						String emailTemp = rs1.getString("email");
						String custNoTextTemp = rs1.getString("cust_no_text");
						String createdRepNoTemp = rs1.getString("created_rep_no");
						String billingCustTemp = rs1.getString("bill_cust");
						String marketTypeTemp = rs1.getString("market_type");
						String contactNameTemp = rs1.getString("contact_name");
						String bpcsCustNoTemp = rs1.getString("bpcs_cust_no");
						String dormantTemp = rs1.getString("dormant");

						if(custNoTemp == null){
							custNoTemp = " ";
						}
						if(custName1Temp == null){
							custName1Temp = " ";
						}
						if(custName2Temp == null){
							custName2Temp = " ";
						}
						if(custAddr1Temp == null){
							custAddr1Temp = " ";
						}
						if(custAddr2Temp == null){
							custAddr2Temp = " ";
						}
						if(attentionTemp == null){
							attentionTemp = " ";
						}
						if(salutationTemp == null){
							salutationTemp = " ";
						}
						if(cityTemp == null){
							cityTemp = " ";
						}
						if(stateTemp == null){
							stateTemp = " ";
						}
						if(zipCodeTemp == null){
							zipCodeTemp = " ";
						}
						if(countryTemp == null){
							countryTemp = " ";
						}
						if(phoneTemp == null){
							phoneTemp = " ";
						}
						if(countryCodeTemp == null){
							countryCodeTemp = " ";
						}
						if(currencyTemp == null){
							currencyTemp = " ";
						}
						if(shippingCityTemp == null){
							shippingCityTemp = " ";
						}
						if(faxTemp == null){
							faxTemp = " ";
						}
						if(emailTemp == null){
							emailTemp = " ";
						}
						if(custNoTextTemp == null){
							custNoTextTemp = " ";
						}
						if(createdRepNoTemp == null){
							createdRepNoTemp = " ";
						}
						if(billingCustTemp == null){
							billingCustTemp = " ";
						}
						if(marketTypeTemp == null){
							marketTypeTemp = " ";
						}
						if(contactNameTemp == null){
							contactNameTemp = " ";
						}
						if(bpcsCustNoTemp == null){
							bpcsCustNoTemp = " ";
						}
						if(dormantTemp == null){
							dormantTemp = " ";
						}

						Element result = doc2.createElement("searchresult");
						resultList.appendChild(result);
						Element custNo = doc2.createElement("custNo");
						custNo.appendChild(doc2.createTextNode(custNoTemp.trim() + "#"));
						result.appendChild(custNo);
						Element custName1 = doc2.createElement("custName1");
						custName1.appendChild(doc2.createTextNode(custName1Temp.trim() + "#"));
						result.appendChild(custName1);
						Element custName2 = doc2.createElement("custName2");
						custName2.appendChild(doc2.createTextNode(custName2Temp.trim() + "#"));
						result.appendChild(custName2);
						Element custAddr1 = doc2.createElement("custAddr1");
						custAddr1.appendChild(doc2.createTextNode(custAddr1Temp.trim() + "#"));
						result.appendChild(custAddr1);
						Element custAddr2 = doc2.createElement("custAddr2");
						custAddr2.appendChild(doc2.createTextNode(custAddr2Temp.trim() + "#"));
						result.appendChild(custAddr2);
						Element attention = doc2.createElement("attention");
						attention.appendChild(doc2.createTextNode(attentionTemp.trim() + "#"));
						result.appendChild(attention);
						Element salutation = doc2.createElement("salutation");
						salutation.appendChild(doc2.createTextNode(salutationTemp.trim() + "#"));
						result.appendChild(salutation);
						Element city = doc2.createElement("city");
						city.appendChild(doc2.createTextNode(cityTemp.trim() + "#"));
						result.appendChild(city);
						Element state = doc2.createElement("state");
						state.appendChild(doc2.createTextNode(stateTemp.trim() + "#"));
						result.appendChild(state);
						Element zipCode = doc2.createElement("zipCode");
						zipCode.appendChild(doc2.createTextNode(zipCodeTemp.trim() + "#"));
						result.appendChild(zipCode);
						Element country = doc2.createElement("country");
						country.appendChild(doc2.createTextNode(countryTemp.trim() + "#"));
						result.appendChild(country);
						Element phone = doc2.createElement("phone");
						phone.appendChild(doc2.createTextNode(phoneTemp.trim() + "#"));
						result.appendChild(phone);
						Element countryCode = doc2.createElement("countryCode");
						countryCode.appendChild(doc2.createTextNode(countryCodeTemp.trim() + "#"));
						result.appendChild(countryCode);
						Element currency = doc2.createElement("currency");
						currency.appendChild(doc2.createTextNode(currencyTemp.trim() + "#"));
						result.appendChild(currency);
						Element shippingCity = doc2.createElement("shippingCity");
						shippingCity.appendChild(doc2.createTextNode(shippingCityTemp.trim() + "#"));
						result.appendChild(shippingCity);
						Element fax = doc2.createElement("fax");
						fax.appendChild(doc2.createTextNode(faxTemp.trim() + "#"));
						result.appendChild(fax);
						Element email = doc2.createElement("email");
						email.appendChild(doc2.createTextNode(emailTemp.trim() + "#"));
						result.appendChild(email);
						Element custNoText = doc2.createElement("custNoText");
						custNoText.appendChild(doc2.createTextNode(custNoTextTemp.trim() + "#"));
						result.appendChild(custNoText);
						Element createdRepNo = doc2.createElement("createdRepNo");
						createdRepNo.appendChild(doc2.createTextNode(createdRepNoTemp.trim() + "#"));
						result.appendChild(createdRepNo);
						Element billingCust = doc2.createElement("billingCust");
						billingCust.appendChild(doc2.createTextNode(billingCustTemp.trim() + "#"));
						result.appendChild(billingCust);
						Element marketType = doc2.createElement("marketType");
						marketType.appendChild(doc2.createTextNode(marketTypeTemp.trim() + "#"));
						result.appendChild(marketType);
						Element contactName = doc2.createElement("contactName");
						contactName.appendChild(doc2.createTextNode(contactNameTemp.trim() + "#"));
						result.appendChild(contactName);
						Element bpcsCustNo = doc2.createElement("bpcsCustNo");
						bpcsCustNo.appendChild(doc2.createTextNode(bpcsCustNoTemp.trim() + "#"));
						result.appendChild(bpcsCustNo);
						Element dormant = doc2.createElement("dormant");
						dormant.appendChild(doc2.createTextNode(dormantTemp.trim() + "#"));
						result.appendChild(dormant);

					}
				}
				rs1.close();
				TransformerFactory tFact = TransformerFactory.newInstance();
				Transformer trans = tFact.newTransformer();
				StringWriter writer = new StringWriter();
				StreamResult result = new StreamResult(writer);
				DOMSource source = new DOMSource(doc2);
				trans.transform(source,result);
				div = writer.toString().trim();
				////logger.debug("get cust edit div");
				//logger.debug(div);
				//logger.debug("end get custedit div");
			}

		}
		catch(Exception e){
			logger.debug("CustomerBean" + query);
			logger.debug(query2);
			logger.debug("getCustomerEditDiv()");
			logger.debug(e.getMessage());
			logger.debug("CustomerBean END");
		}
		finally{
			try{
				stmt.close();
				myConn.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
		return div;
	}

	public String saveContact(String custNo,String contactNo,String countryCode,String contactName,String contactPhone,String contactFax,String contactEmail,String contactDormant){
		String div = "";
		//logger.debug("CustomerBean.saveContact line 854");
		if(custNo == null){
			custNo = "";
		}
		if(contactNo == null){
			contactNo = "";
		}
		if(countryCode == null){
			countryCode = "";
		}
		if(contactName == null){
			contactName = "";
		}
		if(contactPhone == null){
			contactPhone = "";
		}
		if(contactFax == null){
			contactFax = "";
		}
		if(contactEmail == null){
			contactEmail = "";
		}
		if(contactDormant == null){
			contactDormant = "";
		}
		if(contactDormant == null){
			contactDormant = "";
		}
		if(contactDormant.equals("true")){
			contactDormant = "y";
		}
		else{
			contactDormant = "";
		}
		File fXmlFile = new File("d:\\erapid\\erapid.xml");
		Document doc;
		DocumentBuilder dBuilder;
		NodeList nList;
		DocumentBuilderFactory dbFactory;
		DocumentBuilderFactory dFact;
		DocumentBuilder build;
		Document doc2;
		Element resultList;
		Connection myConn = null;
		Statement stmt = null;
		try{
			dbFactory = DocumentBuilderFactory.newInstance();
			dBuilder = dbFactory.newDocumentBuilder();
			doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			nList = doc.getElementsByTagName("instance");
			dFact = DocumentBuilderFactory.newInstance();
			build = dFact.newDocumentBuilder();
			doc2 = build.newDocument();
			resultList = doc2.createElement("search");
			doc2.appendChild(resultList);

			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					dbServerName = "" + getTagValue("dbServerName",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
				}
			}
			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();

			if(custNo.trim().length() > 0){
				if(contactNo.trim().length() > 0){
					//edit existing contact
					// do insert in cs_customers
					java.sql.PreparedStatement updateCsContacts = myConn.prepareStatement("UPDATE cs_customer_contact set contact_name=?,contact_phone=?,contact_fax=?,contact_email=?,dormant=? WHERE cust_no=? and contact_no=? and country_code=?");
					updateCsContacts.setString(1,contactName);
					updateCsContacts.setString(2,contactPhone);
					updateCsContacts.setString(3,contactFax);
					updateCsContacts.setString(4,contactEmail);
					updateCsContacts.setString(5,contactDormant);
					updateCsContacts.setString(6,custNo);
					updateCsContacts.setString(7,contactNo);
					updateCsContacts.setString(8,countryCode);
					int rocount = updateCsContacts.executeUpdate();
					updateCsContacts.close();
					div = "edit existing" + rocount;
				}
				else{
					//create new contact
					int contactNoTemp = 0;
					ResultSet rsContact = stmt.executeQuery("SELECT max(contact_no) from cs_customer_contact where cust_no='" + custNo + "' and country_code='" + countryCode + "'");
					if(rsContact != null){
						while(rsContact.next()){
							contactNoTemp = rsContact.getInt(1);
						}
					}
					rsContact.close();
					contactNoTemp++;
					//logger.debug("SELECT max(contact_no) from cs_customer_contact where cust_no='"+custNo+"' and country_code='"+countryCode+"'");
					//logger.debug(contactNoTemp);
					java.sql.PreparedStatement insertCsContacts = myConn.prepareStatement("insert into cs_customer_contact (cust_no,contact_no,country_code,contact_name,contact_phone,contact_fax,contact_email,dormant) values(?,?,?,?,?,?,?,?)");
					insertCsContacts.setString(1,custNo);
					insertCsContacts.setString(2,"" + contactNoTemp);
					insertCsContacts.setString(3,countryCode);
					insertCsContacts.setString(4,contactName);
					insertCsContacts.setString(5,contactPhone);
					insertCsContacts.setString(6,contactFax);
					insertCsContacts.setString(7,contactEmail);
					insertCsContacts.setString(8,contactDormant);
					int rocount = insertCsContacts.executeUpdate();
					insertCsContacts.close();
					div = "insert contact" + rocount;
					//logger.debug(div);
				}
			}
			else{
				// problem with customer number
				div = "problem with customer number";
			}
			Element result = doc2.createElement("searchresult");
			resultList.appendChild(result);
			Element contactResult = doc2.createElement("contactResult");
			contactResult.appendChild(doc2.createTextNode(div.trim() + "#"));
			result.appendChild(contactResult);
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult resultx = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,resultx);
			div = writer.toString().trim();

		}
		catch(Exception e){
			logger.debug("CustomerBean.saveContact start");
			logger.debug(" start db connections");
			logger.debug(e.getMessage());
			try{
				dbFactory = DocumentBuilderFactory.newInstance();
				dBuilder = dbFactory.newDocumentBuilder();
				doc = dBuilder.parse(fXmlFile);
				doc.getDocumentElement().normalize();
				nList = doc.getElementsByTagName("instance");
				dFact = DocumentBuilderFactory.newInstance();
				build = dFact.newDocumentBuilder();
				doc2 = build.newDocument();
				resultList = doc2.createElement("search");
				doc2.appendChild(resultList);
				Element result = doc2.createElement("searchresult");
				resultList.appendChild(result);
				Element contactResult = doc2.createElement("contactResult");
				contactResult.appendChild(doc2.createTextNode("ERROR::" + e + "#"));
				result.appendChild(contactResult);
				TransformerFactory tFact = TransformerFactory.newInstance();
				Transformer trans = tFact.newTransformer();
				StringWriter writer = new StringWriter();
				StreamResult resultx = new StreamResult(writer);
				DOMSource source = new DOMSource(doc2);
				trans.transform(source,resultx);
				div = writer.toString().trim();
			}
			catch(Exception ex){

			}
			//logger.debug("CustomerBean.saveContact end");
		}
		finally{
			try{
				stmt.close();
				myConn.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
		return div;
	}

	public String getContacts(String custNo,String countryCode){
		String div = "";
		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("d:\\erapid\\erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					dbServerName = "" + getTagValue("dbServerName",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
				}
			}
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("search");
			doc2.appendChild(resultList);
			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			ResultSet rsContacts = stmt.executeQuery("select * from cs_customer_contact where cust_no='" + custNo + "' and country_code='" + countryCode + "' and (dormant is null or not dormant='y')");
			if(rsContacts != null){
				while(rsContacts.next()){
					String custNoTemp = rsContacts.getString("cust_no");
					String contactNoTemp = rsContacts.getString("contact_no");
					String countryCodeTemp = rsContacts.getString("country_code");
					String contactNameTemp = rsContacts.getString("contact_name");
					String contactPhoneTemp = rsContacts.getString("contact_phone");
					String contactFaxTemp = rsContacts.getString("contact_fax");
					String contactEmailTemp = rsContacts.getString("contact_email");
					String contactDormantTemp = rsContacts.getString("dormant");
					if(contactNameTemp == null){
						contactNameTemp = "";
					}
					if(contactPhoneTemp == null){
						contactPhoneTemp = "";
					}
					if(contactFaxTemp == null){
						contactFaxTemp = "";
					}
					if(contactEmailTemp == null){
						contactEmailTemp = "";
					}
					if(custNoTemp == null){
						custNoTemp = "";
					}
					if(contactNoTemp == null){
						contactNoTemp = "";
					}
					if(countryCodeTemp == null){
						countryCodeTemp = "";
					}
					if(contactDormantTemp == null){
						contactDormantTemp = "";
					}
					Element result = doc2.createElement("searchresult");
					resultList.appendChild(result);
					Element contactName = doc2.createElement("contactName");
					contactName.appendChild(doc2.createTextNode(contactNameTemp.trim() + "#"));
					result.appendChild(contactName);
					Element contactPhone = doc2.createElement("contactPhone");
					contactPhone.appendChild(doc2.createTextNode(contactPhoneTemp.trim() + "#"));
					result.appendChild(contactPhone);
					Element contactFax = doc2.createElement("contactFax");
					contactFax.appendChild(doc2.createTextNode(contactFaxTemp.trim() + "#"));
					result.appendChild(contactFax);
					Element contactEmail = doc2.createElement("contactEmail");
					contactEmail.appendChild(doc2.createTextNode(contactEmailTemp.trim() + "#"));
					result.appendChild(contactEmail);
					Element custNox = doc2.createElement("custNo");
					custNox.appendChild(doc2.createTextNode(custNoTemp.trim() + "#"));
					result.appendChild(custNox);
					Element contactNox = doc2.createElement("contactNo");
					contactNox.appendChild(doc2.createTextNode(contactNoTemp.trim() + "#"));
					result.appendChild(contactNox);
					Element countryCodex = doc2.createElement("countryCode");
					countryCodex.appendChild(doc2.createTextNode(countryCodeTemp.trim() + "#"));
					result.appendChild(countryCodex);
					Element contactDormantx = doc2.createElement("contactDormant");
					contactDormantx.appendChild(doc2.createTextNode(contactDormantTemp.trim() + "#"));
					result.appendChild(contactDormantx);
				}
			}
			rsContacts.close();
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult resultx = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,resultx);
			// logger.debug("customerbean.getContacts::"+writer.toString());
			div = writer.toString().trim();

		}
		catch(Exception e){
			logger.debug("customerbean.getContacts");
			logger.debug(e.getMessage());
			logger.debug("customerbean.getContacts END");
		}
		finally{
			try{
				stmt.close();
				myConn.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
		return div;
	}

	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}
}
