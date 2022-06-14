package com.csgroup.general;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import org.w3c.dom.*;
import java.io.*;
import java.sql.*;
import java.util.*;


public class SearchBean{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String dbServerName = "";
	String dbServerPort = "";
	String erapidDB = "";
	String erapidSysDB = "";
	String erapidDBUsername = "";
	String erapidDBPassword = "";
	String dbPSAServerName = "";
	String dbPSAServerPort = "";
	String PSADBUsername = "";
	String PSADBPassword = "";
	String PSADB = "";
	boolean isRep = true;

	String query = "";
	String query2 = "";
	String queryback = "";
	String product = "";
	String repNo = "";
	String repNoText = "";
	String userId = "";
	String orderNo = "";
	String archName = "";
	String orderDate1 = "";
	String orderDate2 = "";
	String custLoc = "";
	String projectName = "";
	String quoteType = "";
	String firstOrderNo = "";
	String lastOrderNo = "";
	String functionName = "";
	String bpcsNo = "";
	String repList = "";
	String webNum = "";

	public void setProduct(String x){
		this.product = x;
	}

	public void setRepNo(String x){
		this.repNo = x;
	}

	public void setUserId(String x){
		this.userId = x;
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
			query = "select group_id,rep_no_text from cs_reps where user_id='" + x + "'";
			ResultSet rsRep = stmt.executeQuery(query);
			if(rsRep != null){
				while(rsRep.next()){
					repNoText = rsRep.getString(2);
					if(rsRep.getString(1).toUpperCase().startsWith("REP")){
						isRep = true;
					}
					else{
						isRep = false;
					}
				}
			}
			rsRep.close();
			if(isRep){
				ResultSet rsRepList = stmt.executeQuery("select rep_quote from cs_rep_mapping where rep_no='" + repNo + "'");
				if(rsRepList != null){
					while(rsRepList.next()){
						repList = repList + rsRepList.getString(1);
					}
				}
				rsRepList.close();
				if(repList == null || repList.equals("null")){
					repList = "";
				}
				else{
					repList = "'" + repNo + "','" + repList.replaceAll(",","','") + "'";
				}
			}
			if(repList.indexOf(",''") >= 0){
				repList = repList.replace(",''","");
			}

		}
		catch(Exception e){
			logger.debug("SearchBean.setUserId");
			logger.debug(e.getMessage());
			logger.debug("SearchBean.setUserId end");
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

	public void setOrderNo(String x){
		this.orderNo = x;
	}

	public void setArchName(String x){
		this.archName = x;
	}

	public void setOrderDate1(String x){
		this.orderDate1 = x;
	}

	public void setOrderDate2(String x){
		this.orderDate2 = x;
	}

	public void setCustLoc(String x){
		this.custLoc = x;
	}

	public void setProjectName(String x){
		this.projectName = x;
	}

	public void setBpcsNo(String x){
		this.bpcsNo = x;
	}

	public void setQuoteType(String x){
		this.quoteType = x;
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

	public void setWebNum(String x){
		this.webNum = x;
	}

	public String getSearchDiv(String countryCode){
		String div = "";
		Connection myConn = null;
		Statement stmt = null;
		try{
			String factory_orders = "";
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
					dbPSAServerName = "" + getTagValue("dbPSAServerName",eElement);
					dbPSAServerPort = "" + getTagValue("dbPSAServerPort",eElement);
					PSADBUsername = "" + getTagValue("PSADBUsername",eElement);
					PSADBPassword = "" + getTagValue("PSADBPassword",eElement);
				}
			}

			boolean isWhereClause = false;
			boolean isOtherQuery = false;
			String psaWhere = "";

			query2 = "SELECT count(*) FROM cs_project a  with (nolock) left outer join doc_header b with (nolock) on  a.order_no=b.doc_number where  ";
			query = "SELECT TOP 20 a.Order_no,a.Project_name,a.Cust_loc,a.arch_name,a.creator_id,a.product_id,a.configured_price,a.created_on,b.win_loss,b.doc_type,b.doc_date,b.win_loss_desc,a.bpcs_order_no,a.template,a.project_type,b.doc_priority FROM cs_project a with (nolock) left outer join doc_header b with (nolock) on a.order_no=b.doc_number where ";
			queryback = "SELECT TOP 20 a.Order_no from cs_project a left outer join doc_header b on a.order_no=b.doc_number where ";
			isWhereClause = true;
			if(product != null && product.trim().length() > 0){
				query = query + " a.product_id='" + product + "' and ";
				psaWhere = psaWhere + " a.product_id='" + product + "' and ";
				query2 = query2 + " a.product_id='" + product + "' and ";
				queryback = queryback + " a.product_id='" + product + "' and ";
				isOtherQuery = true;
			}
			if(orderNo != null & orderNo.trim().length() > 0){
				String orderNoTemp = orderNo.replace("_","[_]");
				query = query + " a.order_no like '" + orderNoTemp + "%'  and ";
				psaWhere = psaWhere + " a.order_no like '" + orderNoTemp + "%'   and ";
				query2 = query2 + " a.order_no like '" + orderNoTemp + "%' and ";
				queryback = queryback + " a.order_no like '" + orderNoTemp + "%'  and ";
				isOtherQuery = true;
			}
			if(archName != null & archName.trim().length() > 0){
				query = query + " a.arch_name like '" + archName + "%' and ";
				psaWhere = psaWhere + " a.arch_name like '" + archName + "%' and ";
				query2 = query2 + " a.arch_name like '" + archName + "%' and ";
				queryback = queryback + " a.arch_name like '" + archName + "%' and ";
				isOtherQuery = true;
			}
			if(custLoc != null & custLoc.trim().length() > 0){
				String custLoc2 = custLoc.replaceAll("" + (char) 32,"" + (char) 160);
				query = query + " (a.cust_loc  like '" + custLoc + "%' or a.cust_loc like '" + custLoc2 + "%' ) and ";
				psaWhere = psaWhere + " (a.cust_loc  like '" + custLoc + "%' or a.cust_loc like '" + custLoc2 + "%' ) and ";

				query2 = query2 + " (a.cust_loc  like '" + custLoc + "%' or a.cust_loc like '" + custLoc2 + "%' ) and ";
				queryback = queryback + " (a.cust_loc  like '" + custLoc + "%' or a.cust_loc like '" + custLoc2 + "%') and ";
				isOtherQuery = true;
			}
			if(projectName != null & projectName.trim().length() > 0){
				query = query + " a.project_name like '" + projectName + "%' and ";
				psaWhere = psaWhere + " a.project_name like '" + projectName + "%' and ";

				query2 = query2 + " a.project_name like '" + projectName + "%' and ";
				queryback = queryback + " a.project_name like '" + projectName + "%' and ";
				isOtherQuery = true;
			}
			if(bpcsNo != null & bpcsNo.trim().length() > 0){
				query = query + " a.bpcs_order_no like '" + bpcsNo + "%' and ";
				psaWhere = psaWhere + " a.bpcs_order_no like '" + bpcsNo + "%' and ";
				query2 = query2 + " a.bpcs_order_no like '" + bpcsNo + "%' and ";
				queryback = queryback + " a.bpcs_order_no like '" + bpcsNo + "%' and ";
				isOtherQuery = true;
			}
			if(webNum != null & webNum.trim().length() > 0){
				query = query + " a.project_type_id like '" + webNum + "%' and ";
				psaWhere = psaWhere + " a.project_type_id like '" + webNum + "%' and ";
				query2 = query2 + " a.project_type_id like '" + webNum + "%' and ";
				queryback = queryback + " a.project_type_id like '" + webNum + "%' and ";
				isOtherQuery = true;
			}
			if(orderDate1 != null && orderDate1.trim().length() > 0){
				query = query + " b.doc_date >= '" + orderDate1 + "' and ";
				query2 = query2 + " b.doc_date >= '" + orderDate1 + "' and ";
				queryback = queryback + " b.doc_date >= '" + orderDate1 + "' and ";
				isOtherQuery = true;
			}
			if(orderDate2 != null && orderDate2.trim().length() > 0){
				query = query + " b.doc_date <= '" + orderDate2 + "' and ";
				psaWhere = psaWhere + " b.doc_date <= '" + orderDate2 + "' and ";
				query2 = query2 + " b.doc_date <= '" + orderDate2 + "' and ";
				queryback = queryback + " b.doc_date <= '" + orderDate2 + "' and ";
				isOtherQuery = true;
			}

			if(quoteType != null && quoteType.trim().length() > 0){

				if(quoteType.equals("profile")){
					query = query + " a.template = 'PFL' and ";
					query2 = query2 + " a.template = 'PFL' and ";
					queryback = queryback + " a.template = 'PFL' and ";
				}
				else{
					query = query + " (a.template is null or not a.template = 'PFL') and ";
					query2 = query2 + " (a.template is null or not a.template = 'PFL') and ";
					queryback = queryback + " (a.template is null or not a.template = 'PFL') and ";
				}
				if(quoteType.equals("quotes")){
					query = query + " b.doc_type like 'Q' and b.win_loss='open'  and ";
					psaWhere = psaWhere + " b.doc_type like 'Q' and b.win_loss='open'  and ";
					query2 = query2 + " b.doc_type like 'Q' and b.win_loss='open' and ";
					queryback = queryback + " b.doc_type like  'Q' and b.win_loss='open' and ";
					isOtherQuery = true;
				}
				else if(quoteType.equals("orders")){
					query = query + " b.doc_type like 'O' and ";
					psaWhere = psaWhere + " b.doc_type like 'O' and ";
					query2 = query2 + " b.doc_type like 'O' and ";
					queryback = queryback + " b.doc_type like  'O' and ";
					isOtherQuery = true;
				}

				else if(quoteType.equals("lost")){
					query = query + " b.win_loss='close' and b.doc_type='q' and ";
					psaWhere = psaWhere + " b.win_loss='close' and b.doc_type='q' and ";
					query2 = query2 + " b.win_loss='close' and b.doc_type='q' and ";
					queryback = queryback + " b.win_loss='close' and b.doc_type='q' and ";
					isOtherQuery = true;
				}
				else if(quoteType.equals("spec")){
					query = query + " a.project_type = 'S' and ";
					psaWhere = psaWhere + " a.project_type = 'S' and ";
					query2 = query2 + " a.project_type = 'S' and ";
					queryback = queryback + " a.project_type = 'S' and ";
					isOtherQuery = true;
				}
			}
			else{
				query = query + " (a.template is null or not a.template = 'PFL') and ";
				query2 = query2 + " (a.template is null or not a.template = 'PFL') and ";
				queryback = queryback + " (a.template is null or not a.template = 'PFL') and ";

			}

			String tempCountryCode = countryCode;
			if(tempCountryCode.equals("AE")){
				tempCountryCode = "ME";
			}

			if(!isOtherQuery){
				if(repNo != null && repNo.trim().length() > 0){
					if(!isRep && repNo.equals(repNoText)){
						query = query + " (( a.creator_id like '" + repNo + "' ) or (assigned_rep_no ='" + repNo + "' and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs'))) or project_type='web') and ";
						query2 = query2 + " (( a.creator_id like '" + repNo + "' ) or (assigned_rep_no ='" + repNo + "' and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs'))) or project_type='web') and ";
						queryback = queryback + " (( a.creator_id like '" + repNo + "' ) or (assigned_rep_no ='" + repNo + "' and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs'))) or project_type='web') and ";
					}
					else{
						if(repNo.startsWith("myQuotes")){

							query = query + " ( a.creator_id like '" + repNo.replace("myQuotes","") + "' ) or (assigned_rep_no ='" + repNo + "' and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs')))) and ";
							query2 = query2 + " ( a.creator_id like '" + repNo.replace("myQuotes","") + "' ) or (assigned_rep_no ='" + repNo + "' and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs')))) and ";
							queryback = queryback + " ( a.creator_id like '" + repNo.replace("myQuotes","") + "' ) or (assigned_rep_no ='" + repNo + "' and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs')))) and ";
							//isOtherQuery = true;
						}
						else{
							query = query + " (a.creator_id like '" + repNo + "'  or (assigned_rep_no ='" + repNo + "' and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs') or project_type='web'))) and ";
							query2 = query2 + " (a.creator_id like '" + repNo + "'  or (assigned_rep_no ='" + repNo + "' and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs') or project_type='web'))) and ";
							queryback = queryback + " (a.creator_id like '" + repNo + "'  or (assigned_rep_no ='" + repNo + "' and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs') or project_type='web'))) and ";
						}
					}
					isWhereClause = true;
				}
			}
			if(!isRep && (repNo.equals(repNoText) || repNo == null || repNo.length() == 0)){
				/*
				 query=query+" creator_id like '"+tempCountryCode+"%' and ";
				 queryback=queryback+" creator_id like '"+tempCountryCode+"%' and ";
				 query2=query2+" creator_id like '"+tempCountryCode+"%' and ";
				 isWhereClause=true;
				 */
			}
			else{
				if(repNo != null && repNo.trim().length() > 0 && repList != null && repList.trim().length() > 0){
					query = query + " (a.creator_id in (" + repList + ")  or (assigned_rep_no in (" + repList + ") and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs')))) and ";
					query2 = query2 + " (a.creator_id in (" + repList + ")  or (assigned_rep_no in (" + repList + ") and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs')))) and ";
					queryback = queryback + " (a.creator_id in (" + repList + ")  or (assigned_rep_no in (" + repList + ") and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs')))) and ";
				}
				else{
					if(repNo.startsWith("myQuotes")){
						query = query + " (( a.creator_id like '" + repNo.replace("myQuotes","") + "' )  or (assigned_rep_no ='" + repNo + "' and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs')))) and ";
						query2 = query2 + " (( a.creator_id like '" + repNo.replace("myQuotes","") + "' ) or (assigned_rep_no ='" + repNo + "' and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs')))) and ";
						queryback = queryback + " (( a.creator_id like '" + repNo.replace("myQuotes","") + "' ) or (assigned_rep_no ='" + repNo + "' and ((not rep_quote is null a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs')))) and ";
						//isOtherQuery = true;
					}
					else{
						query = query + " (a.creator_id like '" + repNo + "'  or (assigned_rep_no ='" + repNo + "' and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs')))) and ";
						query2 = query2 + " (a.creator_id like '" + repNo + "'  or (assigned_rep_no ='" + repNo + "' and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs')))) and ";
						queryback = queryback + " (a.creator_id like '" + repNo + "'  or (assigned_rep_no ='" + repNo + "' and ((not rep_quote is null and a.product_id in ('iwp','ejc','efs')) or not a.product_id in ('iwp','ejc','efs')))) and ";
					}
				}
				isWhereClause = true;
			}

			if(repNo.startsWith("myQuotes")){
				isOtherQuery = true;
			}
			if(projectName.toUpperCase().indexOf("TEST") < 0 && (orderNo == null || orderNo.trim().length() < 6) && erapidDB.toUpperCase().indexOf("DEV") < 0){
				query = query + " not project_name like '%test%' and ";
				query2 = query2 + " not project_name like '%test%' and ";
				queryback = queryback + " not project_name like '%test%' and ";
			}

			if(functionName.equals("forward")){
				query = query + " a.order_no < '" + lastOrderNo + "' and ";
			}
			else if(functionName.equals("back")){
				query = query + " a.order_no > '" + firstOrderNo + "' and a.order_no in (" + queryback + " a.order_no > '" + firstOrderNo + "' order by a.order_no ) and ";
			}
			if(functionName.equals("end")){
				if(queryback.trim().endsWith(" and")){
					queryback = queryback.substring(0,queryback.length() - 5);
				}
				query = query + " a.order_no in (" + queryback + " order by a.order_no ) and ";
			}

			if(query.trim().endsWith(" and")){
				query = query.substring(0,query.length() - 5);

				query2 = query2.substring(0,query2.length() - 5);
				queryback = queryback.substring(0,queryback.length() - 5);
			}

			if(factory_orders != null && factory_orders.trim().length() > 0){
				if(psaWhere.trim().endsWith(" and")){
					psaWhere = psaWhere.substring(0,psaWhere.length() - 5);
				}
				query = query + " or (order_no in (" + factory_orders + ") and " + psaWhere + ")";
				query2 = query2 + " or (order_no in (" + factory_orders + ") and " + psaWhere + ")";
				queryback = queryback + " or (order_no in (" + factory_orders + ") and " + psaWhere + ")";

			}
			//query=query+" order by   CAST(SUBSTRING(a.Order_no, 1, CHARINDEX('_', a.Order_no) - 1) AS numeric) desc";
			query = query + " order by   a.order_no desc";
			
			//logger.debug("query formed is: " + query);
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
				logger.debug(query);
				int rowCount = 0;
				ResultSet rsCount = stmt.executeQuery(query2);
				if(rsCount != null){
					while(rsCount.next()){
						rowCount = rsCount.getInt(1);
						if(!isOtherQuery && rowCount > 20){
							rowCount = 20;
						}
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
					//query = query.replaceAll("20","" + rowCount);
					query = query.replaceAll("TOP 20","TOP " + rowCount);
				}

				ResultSet rs1 = stmt.executeQuery(query);
				String[] line = new String[2];
				if(rs1 != null){
					while(rs1.next()){

						String orderNoTemp = rs1.getString("order_no");
						String projectNameTemp = rs1.getString("project_name");
						String custNameTemp = rs1.getString("cust_loc");
						String creatorIdTemp = rs1.getString("creator_id");
						String configuredPriceTemp = rs1.getString("configured_price");
						String createdOnTemp = rs1.getString("created_on");
						String archNameTemp = rs1.getString("arch_name");
						String productIdTemp = rs1.getString("product_id");
						String statusTemp = rs1.getString("win_loss");
						String docTypeTemp = rs1.getString("doc_type");
						String docDateTemp = rs1.getString("doc_date");
						String winLossDescTemp = rs1.getString("win_loss_desc");
						String bpcsOrderNoTemp = rs1.getString("bpcs_order_no");
						String templateTemp = rs1.getString("template");
						String projectTypeTemp = rs1.getString("project_type");
						String docPriorityTemp = rs1.getString("doc_priority");
						if(orderNoTemp == null){
							orderNoTemp = " ";
						}
						if(projectNameTemp == null){
							projectNameTemp = " ";
						}
						if(custNameTemp == null){
							custNameTemp = " ";
						}
						if(creatorIdTemp == null){
							creatorIdTemp = " ";
						}
						if(configuredPriceTemp == null){
							configuredPriceTemp = "0";
						}

						if(createdOnTemp == null){
							createdOnTemp = " ";
						}
						if(archNameTemp == null){
							archNameTemp = "";
						}
						if(productIdTemp == null){
							productIdTemp = "";
						}
						if(statusTemp == null){
							statusTemp = "";
						}
						if(docTypeTemp == null){
							docTypeTemp = "";
						}
						if(docDateTemp == null){
							docDateTemp = "";
						}
						if(winLossDescTemp == null){
							winLossDescTemp = "";
						}
						if(bpcsOrderNoTemp == null){
							bpcsOrderNoTemp = "";
						}
						if(templateTemp == null){
							templateTemp = "";
						}
						if(projectTypeTemp == null){
							projectTypeTemp = "";
						}
						if(docPriorityTemp == null){
							docPriorityTemp = "";
						}
						else{
							if(docPriorityTemp.equals("C")){
								docPriorityTemp = "CS";
							}
							else if(docPriorityTemp.equals("D")){
								docPriorityTemp = "Eldercare";
							}
							else if(docPriorityTemp.equals("E")){
								if(productIdTemp.equals("EJC")){
									docPriorityTemp = "Restofit";
								}
								else{
									docPriorityTemp = "Facility Sales";
								}
							}
							else if(docPriorityTemp.equals("G")){
								docPriorityTemp = "Grand Entrance";
							}
						}

						String gpaTemp = "";
						if(docTypeTemp.equals("Q") && statusTemp.toUpperCase().equals("CLOSE") && winLossDescTemp.toUpperCase().equals("PUSTE")){
							gpaTemp = "S_P";
						}
						else if(docTypeTemp.equals("Q") && statusTemp.toUpperCase().equals("CLOSE")){
							gpaTemp = "S_B";
						}
						else if(docTypeTemp.equals("Q") && statusTemp.equals("CLOSE")){
							gpaTemp = "S";
						}
						else if(docTypeTemp.equals("Q") && statusTemp.toUpperCase().equals("OPEN")){
							gpaTemp = "O_B";
						}
						else if(docTypeTemp.equals("Q") && statusTemp.toUpperCase().equals("OPEN")){
							gpaTemp = "O";
						}
						else if(docTypeTemp.equals("O") && statusTemp.toUpperCase().equals("CLOSE")){
							gpaTemp = "Z";
						}

						Element result = doc2.createElement("searchresult");
						resultList.appendChild(result);
						Element orderNo = doc2.createElement("orderNo");
						orderNo.appendChild(doc2.createTextNode(orderNoTemp.trim() + "#"));
						result.appendChild(orderNo);
						Element ProjectName = doc2.createElement("projectName");
						ProjectName.appendChild(doc2.createTextNode(projectNameTemp.trim() + "#"));
						result.appendChild(ProjectName);
						Element custName = doc2.createElement("custName");
						custName.appendChild(doc2.createTextNode(custNameTemp.trim() + "#"));
						result.appendChild(custName);
						Element creatorId = doc2.createElement("creatorId");
						creatorId.appendChild(doc2.createTextNode(creatorIdTemp.trim() + "#"));
						result.appendChild(creatorId);
						Element configuredPrice = doc2.createElement("configuredPrice");
						configuredPrice.appendChild(doc2.createTextNode(configuredPriceTemp.trim() + "#"));
						result.appendChild(configuredPrice);

						Element createdOn = doc2.createElement("createdOn");
						createdOn.appendChild(doc2.createTextNode(createdOnTemp.trim() + "#"));
						result.appendChild(createdOn);
						Element archName = doc2.createElement("archName");
						archName.appendChild(doc2.createTextNode(archNameTemp.trim() + "#"));
						result.appendChild(archName);
						Element productId = doc2.createElement("productId");
						productId.appendChild(doc2.createTextNode(productIdTemp.trim() + "#"));
						result.appendChild(productId);
						Element status = doc2.createElement("status");
						status.appendChild(doc2.createTextNode(statusTemp.trim() + "#"));
						result.appendChild(status);
						Element docType = doc2.createElement("docType");
						docType.appendChild(doc2.createTextNode(docTypeTemp.trim() + "#"));
						result.appendChild(docType);
						Element docDate = doc2.createElement("docDate");
						docDate.appendChild(doc2.createTextNode(docDateTemp.trim() + "#"));
						result.appendChild(docDate);
						Element winLossDesc = doc2.createElement("winLossDesc");
						winLossDesc.appendChild(doc2.createTextNode(winLossDescTemp.trim() + "#"));
						result.appendChild(winLossDesc);
						Element gpa = doc2.createElement("gpa");
						gpa.appendChild(doc2.createTextNode(gpaTemp.trim() + "#"));
						result.appendChild(gpa);
						Element bpcsOrderNo = doc2.createElement("bpcsOrderNo");
						bpcsOrderNo.appendChild(doc2.createTextNode(bpcsOrderNoTemp.trim() + "#"));
						result.appendChild(bpcsOrderNo);
						Element template = doc2.createElement("template");
						template.appendChild(doc2.createTextNode(templateTemp.trim() + "#"));
						result.appendChild(template);
						Element projectType = doc2.createElement("projectType");
						projectType.appendChild(doc2.createTextNode(projectTypeTemp.trim() + "#"));
						result.appendChild(projectType);
						Element docPriority = doc2.createElement("docPriority");
						docPriority.appendChild(doc2.createTextNode(docPriorityTemp.trim() + "#"));
						result.appendChild(docPriority);
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

			}
		}
		catch(Exception e){
			logger.debug("SearchBean.getSearchDiv");
			logger.debug(e.getMessage());
			logger.debug(query);
			logger.debug(queryback);
			logger.debug(query2);
			logger.debug("SearchBean END");
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

	public String getPSASearchDiv(String psaProjectName,String userName){
		String query = "select top 20 project.project_title,quotation.quote_id,quotation.value,quotation.quote_type_id FROM dba.quotation join dba.project on project.project_id=quotation.project_id where project.project_title like '" + psaProjectName + "%' order by 2 desc";
		if(psaProjectName == null || psaProjectName.trim().length() == 0){
			query = "SELECT top 20 project.project_title,quotation.quote_id,quotation.value,quotation.quote_type_id FROM dba.quotation join dba.project on project.project_id=quotation.project_id where project.creator_id like '" + userName + "%" + "' order by 2 desc";
		}
		String div = "";
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
					dbPSAServerPort = "" + getTagValue("dbPSAServerPort",eElement);
					dbPSAServerName = "" + getTagValue("dbPSAServerName",eElement);
					PSADBUsername = "" + getTagValue("PSADBUsername",eElement);
					PSADBPassword = "" + getTagValue("PSADBPassword",eElement);
					PSADB = "" + getTagValue("PSADB",eElement);
				}
			}
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("search");
			doc2.appendChild(resultList);
			/*
			 Class.forName("com.sybase.jdbc2.jdbc.SybDriver");
			 Connection connPsa = DriverManager.getConnection("jdbc:sybase:Tds:" + dbPSAServerName + ":" + dbPSAServerPort,PSADBUsername,PSADBPassword);

			 Statement stmtPsa = connPsa.createStatement();
			 */
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			Connection connPsa = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbPSAServerName + ":" + dbPSAServerPort + "/" + PSADB,PSADBUsername,PSADBPassword);
			Statement stmtPsa = connPsa.createStatement();
			stmtPsa.executeUpdate("set ANSI_warnings off");
			//logger.debug(query);
			ResultSet rs1 = stmtPsa.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					String el1Temp = rs1.getString(1);
					String el2Temp = rs1.getString(2);
					String el3Temp = rs1.getString(3);
					String el4Temp = rs1.getString(4);

					if(el1Temp == null){
						el1Temp = " ";
					}
					if(el2Temp == null){
						el2Temp = " ";
					}
					if(el3Temp == null){
						el3Temp = " ";
					}
					if(el4Temp == null){
						el4Temp = " ";
					}
					if(el4Temp.equals("GC")){
						el4Temp = "GCP";
					}
					if(el4Temp.equals("DL") || el4Temp.equals("DW")){
						el4Temp = "IWP";
					}
					Element result = doc2.createElement("searchresult");
					resultList.appendChild(result);
					Element el1 = doc2.createElement("el1");
					el1.appendChild(doc2.createTextNode(el1Temp.trim() + "#"));
					result.appendChild(el1);
					Element el2 = doc2.createElement("el2");
					el2.appendChild(doc2.createTextNode(el2Temp.trim() + "#"));
					result.appendChild(el2);
					Element el3 = doc2.createElement("el3");
					el3.appendChild(doc2.createTextNode(el3Temp.trim() + "#"));
					result.appendChild(el3);
					Element el4 = doc2.createElement("el4");
					el4.appendChild(doc2.createTextNode(el4Temp.trim() + "#"));
					result.appendChild(el4);
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
			//logger.debug("searchbean.java line 596::"+div);
		}
		catch(Exception e){
			logger.debug("SearchBean.getPSASearchDiv");
			logger.debug(e.getMessage());
			logger.debug("SearchBean.getPSASearchDiv end");
		}
		return div;
	}

	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}
}
