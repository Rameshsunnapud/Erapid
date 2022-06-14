package com.csgroup.general;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import org.w3c.dom.*;
import java.io.*;
import java.sql.*;
import java.util.*;


public class QuoteHeaderBean{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String serverName = "";
	String dbServerName = "";
	String dbServerPort = "";
	String erapidDB = "";
	String erapidSysDB = "";
	String erapidDBUsername = "";
	String erapidDBPassword = "";
	String dbPSAServerName = "";
	String dbPSAServerPort = "";
	String dbSFDCServerName = "";
	String dbSFDCServerPort = "";
	String SFDCDB = "";
	String SFDCDBUsername = "";
	String SFDCDBPassword = "";
	String PSADBUsername = "";
	String PSADBPassword = "";

	String query = "";
	String orderNo = "";
	String projectName = "";
	String archName = "";
	String bpcsOrderNo = "";
	String custName = "";
	String custLoc = "";
	String agentName = "";
	String freightCity = "";
	String projectState = "";
	String exclusions = "";
	String qualifyingNotes = "";
	String freeText = "";
	String overage = "";
	String setupCost = "";
	String handlingCost = "";
	String freightCost = "";
	String creatorId = "";
	String creatorUserName = "";
	String creatorGroup = "";
	String productId = "";
	String configuredPrice = "";
	String exclusionsFreeText = "";
	String qualifyingNotesFreeText = "";
	String showComission = "";
	String quoteType = "";
	String carriageCharge = "";
	String carriageType = "";
	String marketType = "";
	String terriRep = "";
	String installDistance = "";
	String createdBy = "";
	String createdOn = "";
	String originalNo = "";
	String orderDate = "";
	String internalNotes = "";
	String jobLoc = "";
	String archLoc = "";
	String qType = "";
	String repEmail = "";
	String projectType = "";
	String projectTypeId = "";
	String docPriority = "";
	String showRecap = "";
	String exchName = "";
	String exchDate = "";
	String exchRate = "";
	String repQuote = "";
	String repTear = "";
	String quoteOrigin = "";
	String groupCode = "";
	String salesRegion = "";
	String constructionType = "";
	String endUser = "";
	String pricingOptions = "";
	String pricingOptionsFree = "";
	String instructions = "";
	String docStage = "";
	String changeCustomer = "";
	String changeArch = "";

	public void setOriginalNo(String x){
		this.originalNo = x;
		//System.out.println(x+"::original no");
	}

	public void setQType(String x){

		this.qType = x;

		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("erapid.xml");
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
			query = "select * from cs_project where order_no='" + originalNo + "'";
			//System.out.println(query+"::: query<BR>");
			//System.out.println(orderDate+":: BEFORE");
			ResultSet rs1 = stmt.executeQuery(query);
			//System.out.println("1");
			if(rs1 != null){
				while(rs1.next()){
					//System.out.println("2");
					//orderNo=rs1.getString("order_no");
					projectName = rs1.getString("project_name");
					//System.out.println(rs1.getString("project_name")+":::HERE");
					archName = rs1.getString("arch_name");
					bpcsOrderNo = rs1.getString("bpcs_order_no");
					projectType = rs1.getString("project_type");
					if(projectType != null && projectType.equals("PFL")){
						custName = "";
						custLoc = "";
						projectTypeId = "";
						agentName = "";
						projectType = "";
					}
					else{
						custName = rs1.getString("cust_name");
						custLoc = rs1.getString("cust_loc");
						projectTypeId = rs1.getString("project_type_id");
						agentName = rs1.getString("agent_name");
					}

					freightCity = rs1.getString("freight_City");
					projectState = rs1.getString("project_State");
					exclusions = rs1.getString("exclusions");
					qualifyingNotes = rs1.getString("qualifying_Notes");
					freeText = rs1.getString("free_Text");
					overage = rs1.getString("overage");
					setupCost = rs1.getString("setup_Cost");
					handlingCost = rs1.getString("handling_Cost");
					freightCost = rs1.getString("freight_Cost");
					creatorId = rs1.getString("creator_Id");
					productId = rs1.getString("product_Id");
					configuredPrice = rs1.getString("configured_Price");
					exclusionsFreeText = rs1.getString("exclusions_Free_Text");
					qualifyingNotesFreeText = rs1.getString("qualifying_notes_Free_Text");
					showComission = rs1.getString("show_comission");
					quoteType = rs1.getString("quote_Type");
					carriageCharge = rs1.getString("carriage_Charge");
					carriageType = rs1.getString("carriage_Type");
					marketType = rs1.getString("market_Type");
					terriRep = rs1.getString("terri_Rep");
					createdBy = rs1.getString("user_id");
					createdOn = rs1.getString("created_On");

					internalNotes = rs1.getString("internal_Notes");
					jobLoc = rs1.getString("job_loc");
					archLoc = rs1.getString("arch_loc");
					showRecap = rs1.getString("show_recap");
					exchName = rs1.getString("exch_name");
					exchRate = rs1.getString("exch_rate");
					exchDate = rs1.getString("exch_rate_date");
					repQuote = rs1.getString("rep_quote");
					repTear = rs1.getString("rep_tear_sheet");
					quoteOrigin = rs1.getString("quote_origin");
					groupCode = rs1.getString("group_code");
					salesRegion = rs1.getString("sales_region");
					constructionType = rs1.getString("construction_type");
					endUser = rs1.getString("end_user");
					pricingOptions = rs1.getString("pricing_options");
					pricingOptionsFree = rs1.getString("pricing_options_free_text");
					instructions = rs1.getString("instructions");
					changeCustomer = rs1.getString("changeCustomer");
					changeArch = rs1.getString("changeArch");
					//System.out.println("3");
				}
			}
			rs1.close();
			query = "select email,user_id,group_id from cs_reps where rep_no_text='" + creatorId + "' and user_id = '" + createdBy + "'";
			ResultSet rs2 = stmt.executeQuery(query);
			//System.out.println("1"+query);
			if(rs2 != null){
				while(rs2.next()){
					repEmail = rs2.getString(1);
					creatorUserName = rs2.getString(2);
					creatorGroup = rs2.getString(3);
				}
			}
			rs2.close();
			if(creatorUserName == null || creatorUserName.trim().length() == 0){
				query = "select email,user_id,group_id from cs_reps where rep_no_text='" + creatorId + "' ";
				ResultSet rs2x = stmt.executeQuery(query);
				//System.out.println("1"+query);
				if(rs2x != null){
					while(rs2x.next()){
						//repEmail = rs2.getString(1);
						creatorUserName = rs2x.getString(2);
						creatorGroup = rs2x.getString(3);
					}
				}
				rs2x.close();
			}
			ResultSet rs3 = stmt.executeQuery("select doc_priority from doc_header where doc_number='" + originalNo + "'");
			if(rs3 != null){
				while(rs3.next()){
					docPriority = rs3.getString(1);
				}
			}
			rs3.close();
			ResultSet rs4 = stmt.executeQuery("select doc_stage from doc_header where doc_number='" + originalNo + "'");
			if(rs4 != null){
				while(rs4.next()){
					docStage = rs4.getString(1);
				}
			}
			rs4.close();
			if(docStage == null){
				docStage = "";
			}
			stmt.close();
			//System.out.println(orderDate+"::after");
			//System.out.println("4");
			myConn.close();
			if(orderNo == null){
				orderNo = "";
			}
			if(projectName == null){
				projectName = "";
			}
			if(archName == null){
				archName = "";
			}
			if(bpcsOrderNo == null){
				bpcsOrderNo = "";
			}
			if(custName == null){
				custName = "";
			}
			if(custLoc == null){
				custLoc = "";
			}
			if(agentName == null){
				agentName = "";
			}
			if(freightCity == null){
				freightCity = "";
			}
			if(projectState == null){
				projectState = "";
			}
			if(exclusions == null){
				exclusions = "";
			}
			if(qualifyingNotes == null){
				qualifyingNotes = "";
			}
			if(freeText == null){
				freeText = "";
			}
			if(overage == null){
				overage = "";
			}
			if(setupCost == null){
				setupCost = "";
			}
			if(handlingCost == null){
				handlingCost = "";
			}
			if(freightCost == null){
				freightCost = "";
			}
			if(creatorId == null){
				creatorId = "";
			}
			if(productId == null){
				productId = "";
			}
			if(configuredPrice == null){
				configuredPrice = "";
			}
			if(exclusionsFreeText == null){
				exclusionsFreeText = "";
			}
			if(qualifyingNotesFreeText == null){
				qualifyingNotesFreeText = "";
			}
			if(showComission == null){
				showComission = "";
			}
			if(quoteType == null){
				quoteType = "";
			}
			if(carriageCharge == null){
				carriageCharge = "";
			}
			if(carriageType == null){
				carriageType = "";
			}
			if(marketType == null){
				marketType = "";
			}
			if(terriRep == null){
				terriRep = "";
			}
			if(installDistance == null){
				installDistance = "";
			}
			if(createdBy == null){
				createdBy = "";
			}
			if(createdOn == null){
				createdOn = "";
			}
			if(originalNo == null){
				originalNo = "";
			}
			if(orderDate == null){
				orderDate = "";
			}
			if(internalNotes == null){
				internalNotes = "";
			}
			if(jobLoc == null){
				jobLoc = "";
			}
			if(archLoc == null){
				archLoc = "";
			}

			if(repEmail == null){
				repEmail = "";
			}
			if(projectType == null){
				projectType = "";
			}
			if(projectTypeId == null){
				projectTypeId = "";
			}
			if(docPriority == null){
				docPriority = "";
			}
			if(showRecap == null){
				showRecap = "";
			}
			if(exchName == null){
				exchName = "";
			}
			if(exchRate == null){
				exchRate = "";
			}
			if(exchDate == null){
				exchDate = "";
			}
			if(repQuote == null){
				repQuote = "";
			}
			if(repTear == null){
				repTear = "";
			}
			if(quoteOrigin == null){
				quoteOrigin = "";
			}
			if(groupCode == null){
				groupCode = "";
			}
			if(salesRegion == null){
				salesRegion = "";
			}
			if(constructionType == null){
				constructionType = "";
			}
			if(endUser == null){
				endUser = "";
			}
			if(pricingOptions == null){
				pricingOptions = "";
			}
			if(pricingOptionsFree == null){
				pricingOptionsFree = "";
			}
			if(instructions == null){
				instructions = "";
			}
			if(changeCustomer == null){
				changeCustomer = "";
			}
			if(changeArch == null){
				changeArch = "";
			}

		}
		catch(Exception e){
			orderNo = "" + e;
			System.out.println("QuoteHeaderBean.setQType");
			System.out.println(e);
			System.out.println("QuoteHeaderBean.setQType END");
			//System.out.println(e);
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
		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("erapid.xml");
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
			query = "select * from cs_project where order_no='" + orderNo + "'";
			//System.out.println(query+":: setOrderNo");
			ResultSet rs1 = stmt.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					orderNo = rs1.getString("order_no");
					projectName = rs1.getString("project_name");
					archName = rs1.getString("arch_name");
					bpcsOrderNo = rs1.getString("bpcs_order_no");
					custName = rs1.getString("cust_name");
					custLoc = rs1.getString("cust_loc");
					agentName = rs1.getString("agent_name");

					freightCity = rs1.getString("freight_City");
					projectState = rs1.getString("project_State");
					exclusions = rs1.getString("exclusions");
					qualifyingNotes = rs1.getString("qualifying_Notes");
					freeText = rs1.getString("free_Text");
					overage = rs1.getString("overage");
					setupCost = rs1.getString("setup_Cost");
					handlingCost = rs1.getString("handling_Cost");
					freightCost = rs1.getString("freight_Cost");
					creatorId = rs1.getString("creator_Id");
					productId = rs1.getString("product_Id");
					configuredPrice = rs1.getString("configured_Price");
					exclusionsFreeText = rs1.getString("exclusions_Free_Text");
					qualifyingNotesFreeText = rs1.getString("qualifying_notes_Free_Text");
					showComission = rs1.getString("show_comission");
					quoteType = rs1.getString("quote_Type");
					carriageCharge = rs1.getString("carriage_Charge");
					carriageType = rs1.getString("carriage_Type");
					marketType = rs1.getString("market_Type");
					terriRep = rs1.getString("terri_Rep");
					createdBy = rs1.getString("user_id");
					createdOn = rs1.getString("created_On");
					originalNo = rs1.getString("base_quote_no");

					internalNotes = rs1.getString("internal_Notes");

					jobLoc = rs1.getString("job_loc");
					archLoc = rs1.getString("arch_loc");

					projectType = rs1.getString("project_type");
					projectTypeId = rs1.getString("project_type_id");
					showRecap = rs1.getString("show_recap");
					exchName = rs1.getString("exch_name");
					exchRate = rs1.getString("exch_rate");
					exchDate = rs1.getString("exch_rate_date");
					repQuote = rs1.getString("rep_quote");
					repTear = rs1.getString("rep_tear_sheet");
					quoteOrigin = rs1.getString("quote_origin");
					groupCode = rs1.getString("group_code");
					salesRegion = rs1.getString("sales_region");
					constructionType = rs1.getString("construction_type");
					endUser = rs1.getString("end_user");
					pricingOptions = rs1.getString("pricing_options");
					pricingOptionsFree = rs1.getString("pricing_options_free_text");
					instructions = rs1.getString("instructions");
					changeCustomer = rs1.getString("changeCustomer");
					changeArch = rs1.getString("changeArch");
				}
			}
			rs1.close();
			query = "select email,user_id,group_id from cs_reps where rep_no_text='" + creatorId + "' and user_id = '" + createdBy + "'";
			ResultSet rs2 = stmt.executeQuery(query);
			//System.out.println("1" + query);
			if(rs2 != null){
				while(rs2.next()){
					repEmail = rs2.getString(1);
					creatorUserName = rs2.getString(2);
					creatorGroup = rs2.getString(3);
				}
			}
			rs2.close();

			if(creatorUserName == null || creatorUserName.trim().length() == 0){
				query = "select email,user_id,group_id from cs_reps where rep_no_text='" + creatorId + "' ";
				ResultSet rs2x = stmt.executeQuery(query);
				//System.out.println("2" + query);
				if(rs2x != null){
					while(rs2x.next()){
						//repEmail = rs2.getString(1);
						creatorUserName = rs2x.getString(2);
						creatorGroup = rs2x.getString(3);
					}
				}
				rs2x.close();
			}
			ResultSet rs3 = stmt.executeQuery("select doc_priority from doc_header where doc_number='" + orderNo + "'");
			if(rs3 != null){
				while(rs3.next()){
					docPriority = rs3.getString(1);
				}
			}
			rs3.close();
			ResultSet rs4 = stmt.executeQuery("select doc_stage from doc_header where doc_number='" + orderNo + "'");
			if(rs4 != null){
				while(rs4.next()){
					docStage = rs4.getString(1);
				}
			}
			rs4.close();
			if(docStage == null){
				docStage = "";
			}

			if(orderNo == null){
				orderNo = "";
			}
			if(projectName == null){
				projectName = "";
			}
			if(archName == null){
				archName = "";
			}
			if(bpcsOrderNo == null){
				bpcsOrderNo = "";
			}
			if(custName == null){
				custName = "";
			}
			if(custLoc == null){
				custLoc = "";
			}
			if(agentName == null){
				agentName = "";
			}

			if(freightCity == null){
				freightCity = "";
			}
			if(projectState == null){
				projectState = "";
			}
			if(exclusions == null){
				exclusions = "";
			}
			if(qualifyingNotes == null){
				qualifyingNotes = "";
			}
			if(freeText == null){
				freeText = "";
			}
			if(overage == null){
				overage = "";
			}
			if(setupCost == null){
				setupCost = "";
			}
			if(handlingCost == null){
				handlingCost = "";
			}
			if(freightCost == null){
				freightCost = "";
			}
			if(creatorId == null){
				creatorId = "";
			}
			if(productId == null){
				productId = "";
			}
			if(configuredPrice == null){
				configuredPrice = "";
			}
			if(exclusionsFreeText == null){
				exclusionsFreeText = "";
			}
			if(qualifyingNotesFreeText == null){
				qualifyingNotesFreeText = "";
			}
			if(showComission == null){
				showComission = "";
			}
			if(quoteType == null){
				quoteType = "";
			}
			if(carriageCharge == null){
				carriageCharge = "";
			}
			if(carriageType == null){
				carriageType = "";
			}
			if(marketType == null){
				marketType = "";
			}
			if(terriRep == null){
				terriRep = "";
			}
			if(installDistance == null){
				installDistance = "";
			}
			if(createdBy == null){
				createdBy = "";
			}
			if(createdOn == null){
				createdOn = "";
			}
			if(originalNo == null){
				originalNo = "";
			}
			if(orderDate == null){
				orderDate = "";
			}

			if(internalNotes == null){
				internalNotes = "";
			}
			if(jobLoc == null){
				jobLoc = "";
			}
			if(archLoc == null){
				archLoc = "";
			}

			if(repEmail == null){
				repEmail = "";
			}
			if(projectType == null){
				projectType = "";
			}
			if(projectTypeId == null){
				projectTypeId = "";
			}
			if(docPriority == null){
				docPriority = "";
			}
			if(showRecap == null){
				showRecap = "";
			}
			if(exchName == null){
				exchName = "";
			}
			if(exchRate == null){
				exchRate = "";
			}
			if(exchDate == null){
				exchDate = "";
			}
			if(repQuote == null){
				repQuote = "";
			}
			if(repTear == null){
				repTear = "";
			}
			if(quoteOrigin == null){
				quoteOrigin = "";
			}
			if(groupCode == null){
				groupCode = "";
			}
			if(salesRegion == null){
				salesRegion = "";
			}
			if(constructionType == null){
				constructionType = "";
			}
			if(endUser == null){
				endUser = "";
			}
			if(pricingOptions == null){
				pricingOptions = "";
			}
			if(pricingOptionsFree == null){
				pricingOptionsFree = "";
			}
			if(instructions == null){
				instructions = "";
			}
			if(changeCustomer == null){
				changeCustomer = "";
			}
			if(changeArch == null){
				changeArch = "";
			}

		}
		catch(Exception e){
			orderNo = "" + e;
			System.out.println("QuoteHeaderBean.setOrderNo");
			System.out.println(e);
			System.out.println("QuoteHeaderBean.setOrderNo END");
			//System.out.println(e);
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

	public String getOrderNo(){
		return orderNo;
	}

	public String getProjectName(){
		return projectName;
	}

	public String getArchName(){
		return archName;
	}

	public String getBpcsOrderNo(){
		return bpcsOrderNo;
	}

	public String getCustName(){
		return custName;
	}

	public String getCustLoc(){
		return custLoc;
	}

	public String getAgentName(){
		return agentName;
	}

	public String getFreightCity(){
		return freightCity;
	}

	public String getProjectState(){
		return projectState;
	}

	public String getExclusions(){
		return exclusions;
	}

	public String getQualifyingNotes(){
		return qualifyingNotes;
	}

	public String getFreeText(){
		return freeText;
	}

	public String getOverage(){
		return overage;
	}

	public String getSetupCost(){
		return setupCost;
	}

	public String getHandlingCost(){
		return handlingCost;
	}

	public String getFreightCost(){
		return freightCost;
	}

	public String getCreatorId(){
		return creatorId;
	}

	public String getCreatorUserName(){
		return creatorUserName;
	}

	public String getCreatorGroup(){
		return creatorGroup;
	}

	public String getProductId(){
		return productId;
	}

	public String getConfiguredPrice(){
		return configuredPrice;
	}

	public String getExclusionsFreeText(){
		return exclusionsFreeText;
	}

	public String getqualifyingNotesFreeText(){
		return qualifyingNotesFreeText;
	}

	public String getshowComission(){
		return showComission;
	}

	public String getQuoteType(){
		return quoteType;
	}

	public String getCarriageCharge(){
		return carriageCharge;
	}

	public String getCarriageType(){
		return carriageType;
	}

	public String geMarketType(){
		return marketType;
	}

	public String getTerriRep(){
		return terriRep;
	}

	public String getInstallDistance(){
		return installDistance;
	}

	public String getCreatedBy(){
		return createdBy;
	}

	public String getCreatedOn(){
		return createdOn;
	}

	public String getOriginalNo(){
		return originalNo;
	}

	public String getOrderDate(){
		return orderDate;
	}

	public String getInternalNotes(){
		return internalNotes;
	}

	public String getRepEmail(){
		return repEmail;
	}

	public String getProjectType(){
		return projectType;
	}

	public String getProjectTypeId(){
		return projectTypeId;
	}

	public String getDocPriority(){
		return docPriority;
	}

	public String getDocPriorityName(){
		String x = "";
		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("erapid.xml");
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
			query = "select option_label from cs_pull_downs where select_name='quoteType' and option_value='" + docPriority + "' and product_id in('" + productId + "','*') order by product_id";
			//System.out.println(query);
			ResultSet rs1 = stmt.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					x = rs1.getString(1);
				}
			}
			rs1.close();
			myConn.close();
		}
		catch(Exception e){

			System.out.println(" QuoteHeaderBean.getDocPriorityName");
			System.out.println(e);
			System.out.println(" QuoteHeaderBean.getDocPriorityNameEND");
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
		return x;
	}

	public String getExchName(){
		return exchName;
	}

	public String getExchRate(){
		return exchRate;
	}

	public String getExchDate(){
		return exchDate;
	}

	public String getRepQuote(){
		return repQuote;
	}

	public String getRepTear(){
		return repTear;
	}

	public String getQuoteOrigin(){
		return quoteOrigin;
	}

	public String getXml(){
		String div = "";
		Connection myConn = null;
		Statement stmt = null;
		try{
			//System.out.println(orderDate+":: getXml1");
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("search");
			doc2.appendChild(resultList);
			Element searchresult = doc2.createElement("searchresult");
			resultList.appendChild(searchresult);
			Element orderNoElement = doc2.createElement("orderNo");
			orderNoElement.appendChild(doc2.createTextNode(orderNo.trim() + "#"));
			searchresult.appendChild(orderNoElement);
			Element projectNameElement = doc2.createElement("projectName");
			projectNameElement.appendChild(doc2.createTextNode(projectName.trim() + "#"));
			searchresult.appendChild(projectNameElement);
			Element jobLocElement = doc2.createElement("jobLoc");
			jobLocElement.appendChild(doc2.createTextNode(jobLoc.trim() + "#"));
			searchresult.appendChild(jobLocElement);
			Element archNameElement = doc2.createElement("archName");
			archNameElement.appendChild(doc2.createTextNode(archName.trim() + "#"));
			searchresult.appendChild(archNameElement);
			Element archLocElement = doc2.createElement("archLoc");
			archLocElement.appendChild(doc2.createTextNode(archLoc.trim() + "#"));
			searchresult.appendChild(archLocElement);
			Element bpcsOrderNoElement = doc2.createElement("bpcsOrderNo");
			bpcsOrderNoElement.appendChild(doc2.createTextNode(bpcsOrderNo.trim() + "#"));
			searchresult.appendChild(bpcsOrderNoElement);
			Element custNameElement = doc2.createElement("custName");
			custNameElement.appendChild(doc2.createTextNode(custName.trim() + "#"));
			searchresult.appendChild(custNameElement);
			Element custLocElement = doc2.createElement("custLoc");
			custLocElement.appendChild(doc2.createTextNode(custLoc.trim() + "#"));
			searchresult.appendChild(custLocElement);
			Element agentNameElement = doc2.createElement("agentName");
			agentNameElement.appendChild(doc2.createTextNode(agentName.trim() + "#"));
			searchresult.appendChild(agentNameElement);

			Element freightCityElement = doc2.createElement("freightCity");
			freightCityElement.appendChild(doc2.createTextNode(freightCity.trim() + "#"));
			searchresult.appendChild(freightCityElement);
			Element projectStateElement = doc2.createElement("projectState");
			projectStateElement.appendChild(doc2.createTextNode(projectState.trim() + "#"));
			searchresult.appendChild(projectStateElement);
			Element exclusionsElement = doc2.createElement("exclusions");
			exclusionsElement.appendChild(doc2.createTextNode(exclusions.trim() + "#"));
			searchresult.appendChild(exclusionsElement);
			Element qualifyingNotesElement = doc2.createElement("qualifyingNotes");
			qualifyingNotesElement.appendChild(doc2.createTextNode(qualifyingNotes.trim() + "#"));
			searchresult.appendChild(qualifyingNotesElement);
			Element freeTextElement = doc2.createElement("freeText");
			freeTextElement.appendChild(doc2.createTextNode(freeText.trim() + "#"));
			searchresult.appendChild(freeTextElement);
			Element overageElement = doc2.createElement("overage");
			overageElement.appendChild(doc2.createTextNode(overage.trim() + "#"));
			searchresult.appendChild(overageElement);
			Element setupCostElement = doc2.createElement("setupCost");
			setupCostElement.appendChild(doc2.createTextNode(setupCost.trim() + "#"));
			searchresult.appendChild(setupCostElement);
			Element handlingCostElement = doc2.createElement("handlingCost");
			handlingCostElement.appendChild(doc2.createTextNode(handlingCost.trim() + "#"));
			searchresult.appendChild(handlingCostElement);
			Element freightCostElement = doc2.createElement("freightCost");
			freightCostElement.appendChild(doc2.createTextNode(freightCost.trim() + "#"));
			searchresult.appendChild(freightCostElement);
			Element creatorIdElement = doc2.createElement("creatorId");
			creatorIdElement.appendChild(doc2.createTextNode(creatorId.trim() + "#"));
			searchresult.appendChild(creatorIdElement);
			Element creatorUserNameElement = doc2.createElement("creatorUserName");
			creatorUserNameElement.appendChild(doc2.createTextNode(creatorUserName.trim() + "#"));
			searchresult.appendChild(creatorUserNameElement);
			Element creatorGroupElement = doc2.createElement("creatorGroup");
			creatorGroupElement.appendChild(doc2.createTextNode(creatorGroup.trim() + "#"));
			searchresult.appendChild(creatorGroupElement);
			Element productIdElement = doc2.createElement("productId");
			productIdElement.appendChild(doc2.createTextNode(productId.trim() + "#"));
			searchresult.appendChild(productIdElement);
			Element configuredPriceElement = doc2.createElement("configuredPrice");
			configuredPriceElement.appendChild(doc2.createTextNode(configuredPrice.trim() + "#"));
			searchresult.appendChild(configuredPriceElement);
			Element exclusionsFreeTextElement = doc2.createElement("exclusionsFreeText");
			exclusionsFreeTextElement.appendChild(doc2.createTextNode(exclusionsFreeText.trim() + "#"));
			searchresult.appendChild(exclusionsFreeTextElement);
			Element qualifyingNotesFreeTextElement = doc2.createElement("qualifyingNotesFreeText");
			qualifyingNotesFreeTextElement.appendChild(doc2.createTextNode(qualifyingNotesFreeText.trim() + "#"));
			searchresult.appendChild(qualifyingNotesFreeTextElement);
			Element showComissionElement = doc2.createElement("showComission");
			showComissionElement.appendChild(doc2.createTextNode(showComission.trim() + "#"));
			searchresult.appendChild(showComissionElement);
			Element quoteTypeElement = doc2.createElement("quoteType");
			quoteTypeElement.appendChild(doc2.createTextNode(quoteType.trim() + "#"));
			searchresult.appendChild(quoteTypeElement);
			Element carriageChargeElement = doc2.createElement("carriageCharge");
			carriageChargeElement.appendChild(doc2.createTextNode(carriageCharge.trim() + "#"));
			searchresult.appendChild(carriageChargeElement);
			Element carriageTypeElement = doc2.createElement("carriageType");
			carriageTypeElement.appendChild(doc2.createTextNode(carriageType.trim() + "#"));
			searchresult.appendChild(carriageTypeElement);
			Element marketTypeElement = doc2.createElement("marketType");
			marketTypeElement.appendChild(doc2.createTextNode(marketType.trim() + "#"));
			searchresult.appendChild(marketTypeElement);
			Element terriRepElement = doc2.createElement("terriRep");
			terriRepElement.appendChild(doc2.createTextNode(terriRep.trim() + "#"));
			searchresult.appendChild(terriRepElement);

			Element installDistanceElement = doc2.createElement("installDistance");
			installDistanceElement.appendChild(doc2.createTextNode(installDistance.trim() + "#"));
			searchresult.appendChild(installDistanceElement);
			Element createdByElement = doc2.createElement("createdBy");
			createdByElement.appendChild(doc2.createTextNode(createdBy.trim() + "#"));
			searchresult.appendChild(createdByElement);;
			Element createdOnElement = doc2.createElement("createdOn");
			createdOnElement.appendChild(doc2.createTextNode(createdOn.trim() + "#"));
			searchresult.appendChild(createdOnElement);
			Element originalNoElement = doc2.createElement("originalNo");
			originalNoElement.appendChild(doc2.createTextNode(originalNo.trim() + "#"));
			searchresult.appendChild(originalNoElement);
			Element orderDateElement = doc2.createElement("orderDate");
			orderDateElement.appendChild(doc2.createTextNode(orderDate.trim() + "#"));
			searchresult.appendChild(orderDateElement);
			Element internalNotesElement = doc2.createElement("internalNotes");
			internalNotesElement.appendChild(doc2.createTextNode(internalNotes.trim() + "#"));
			searchresult.appendChild(internalNotesElement);
			Element projectTypeElement = doc2.createElement("projectType");
			projectTypeElement.appendChild(doc2.createTextNode(projectType.trim() + "#"));
			searchresult.appendChild(projectTypeElement);
			Element projectTypeIdElement = doc2.createElement("projectTypeId");
			projectTypeIdElement.appendChild(doc2.createTextNode(projectTypeId.trim() + "#"));
			searchresult.appendChild(projectTypeIdElement);
			Element a = doc2.createElement("exchName");
			a.appendChild(doc2.createTextNode(exchName.trim() + "#"));
			searchresult.appendChild(a);
			Element b = doc2.createElement("exchRate");
			b.appendChild(doc2.createTextNode(exchRate.trim() + "#"));
			searchresult.appendChild(b);
			Element c = doc2.createElement("exchDate");
			c.appendChild(doc2.createTextNode(exchDate.trim() + "#"));
			searchresult.appendChild(c);
			Element d = doc2.createElement("groupCode");
			d.appendChild(doc2.createTextNode(groupCode.trim() + "#"));
			searchresult.appendChild(d);
			Element e = doc2.createElement("salesRegion");
			e.appendChild(doc2.createTextNode(salesRegion.trim() + "#"));
			searchresult.appendChild(e);
			Element f = doc2.createElement("constructionType");
			f.appendChild(doc2.createTextNode(constructionType.trim() + "#"));
			searchresult.appendChild(f);
			Element g = doc2.createElement("endUser");
			g.appendChild(doc2.createTextNode(endUser.trim() + "#"));
			searchresult.appendChild(g);

			Element h = doc2.createElement("pricingOptions");
			h.appendChild(doc2.createTextNode(pricingOptions.trim() + "#"));
			searchresult.appendChild(h);
			Element j = doc2.createElement("pricingOptionsFree");
			j.appendChild(doc2.createTextNode(pricingOptionsFree.trim() + "#"));
			searchresult.appendChild(j);
			Element k = doc2.createElement("instructions");
			k.appendChild(doc2.createTextNode(instructions.trim() + "#"));
			searchresult.appendChild(k);
			Element l = doc2.createElement("docStage");
			l.appendChild(doc2.createTextNode(docStage.trim() + "#"));
			searchresult.appendChild(l);

			Element m = doc2.createElement("changeCustomer");
			m.appendChild(doc2.createTextNode(changeCustomer.trim() + "#"));
			searchresult.appendChild(m);
			Element n = doc2.createElement("changeArch");
			n.appendChild(doc2.createTextNode(changeArch.trim() + "#"));
			searchresult.appendChild(n);

			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			//System.out.println(orderDate+":: getXml2");
			stmt.executeUpdate("set ANSI_warnings off");
			int notecounter = 0;
			if(orderNo.trim().length() <= 0 && (productId.equals("IWP") || productId.equals("EJC"))){
				Element showRecapElement = doc2.createElement("showRecap");
				showRecapElement.appendChild(doc2.createTextNode("on#"));
				searchresult.appendChild(showRecapElement);
			}
			else{
				Element showRecapElement = doc2.createElement("showRecap");
				showRecapElement.appendChild(doc2.createTextNode(showRecap + "#"));
				searchresult.appendChild(showRecapElement);
			}
			if(orderNo.trim().length() > 0){
				query = "select win_loss,doc_type,doc_date,entry_date,expires_date,win_loss_desc,doc_priority from doc_header where doc_number='" + orderNo + "'";
				ResultSet rs2 = stmt.executeQuery(query);
				if(rs2 != null){
					while(rs2.next()){
						Element winLossElement = doc2.createElement("winLoss");
						winLossElement.appendChild(doc2.createTextNode(rs2.getString("win_loss") + "#"));
						searchresult.appendChild(winLossElement);
						Element docTypeElement = doc2.createElement("docType");
						docTypeElement.appendChild(doc2.createTextNode(rs2.getString("doc_type") + "#"));
						searchresult.appendChild(docTypeElement);
						Element docDateElement = doc2.createElement("docDate");
						docDateElement.appendChild(doc2.createTextNode(rs2.getString("doc_date") + "#"));
						searchresult.appendChild(docDateElement);
						Element entryDateElement = doc2.createElement("entryDate");
						entryDateElement.appendChild(doc2.createTextNode(rs2.getString("entry_date") + "#"));
						searchresult.appendChild(entryDateElement);
						Element expiresDateElement = doc2.createElement("expiresDate");
						expiresDateElement.appendChild(doc2.createTextNode(rs2.getString("expires_date") + "#"));
						searchresult.appendChild(expiresDateElement);
						Element expiresDate2Element = doc2.createElement("expiresDate2");
						expiresDate2Element.appendChild(doc2.createTextNode(rs2.getString("expires_date") + "#"));
						searchresult.appendChild(expiresDate2Element);
						Element winLossDescElement = doc2.createElement("winLossDesc");
						winLossDescElement.appendChild(doc2.createTextNode(rs2.getString("win_loss_desc") + "#"));
						searchresult.appendChild(winLossDescElement);
						Element docPriorityElement = doc2.createElement("docPriority");
						docPriorityElement.appendChild(doc2.createTextNode(rs2.getString("doc_priority") + "#"));
						searchresult.appendChild(docPriorityElement);
					}
				}
				rs2.close();

			}
			else{
				java.util.Date uDate = new java.util.Date(); // Right now
				java.sql.Date days1 = new java.sql.Date(uDate.getTime());
				GregorianCalendar firstFlight = new GregorianCalendar();
				GregorianCalendar firstFlight2 = new GregorianCalendar();
				GregorianCalendar firstFlight3 = new GregorianCalendar();
				firstFlight.add(Calendar.DATE,60);
				firstFlight2.add(Calendar.DATE,55);
				firstFlight3.add(Calendar.DATE,90);
				java.util.Date days60 = firstFlight.getTime();
				java.util.Date days55 = firstFlight2.getTime();
				java.util.Date days90 = firstFlight3.getTime();
				java.sql.Date days60Format = new java.sql.Date(days60.getTime());
				java.sql.Date days55Format = new java.sql.Date(days55.getTime());
				java.sql.Date days90Format = new java.sql.Date(days90.getTime());

				Element winLossElement = doc2.createElement("winLoss");
				winLossElement.appendChild(doc2.createTextNode("OPEN#"));
				searchresult.appendChild(winLossElement);
				Element docTypeElement = doc2.createElement("docType");
				docTypeElement.appendChild(doc2.createTextNode("Q#"));
				searchresult.appendChild(docTypeElement);
				Element docDateElement = doc2.createElement("docDate");
				docDateElement.appendChild(doc2.createTextNode(days1 + "#"));
				searchresult.appendChild(docDateElement);
				Element entryDateElement = doc2.createElement("entryDate");
				entryDateElement.appendChild(doc2.createTextNode(days1 + "#"));
				searchresult.appendChild(entryDateElement);
				Element expiresDateElement = doc2.createElement("expiresDate");
				expiresDateElement.appendChild(doc2.createTextNode(days60Format + "#"));
				searchresult.appendChild(expiresDateElement);

				Element expiresDate2Element = doc2.createElement("expiresDate2");
				expiresDate2Element.appendChild(doc2.createTextNode(days90Format + "#"));
				searchresult.appendChild(expiresDate2Element);

				Element winLossDescElement = doc2.createElement("winLossDesc");
				winLossDescElement.appendChild(doc2.createTextNode("#"));
				searchresult.appendChild(winLossDescElement);
				Element docPriorityElement = doc2.createElement("docPriority");
				docPriorityElement.appendChild(doc2.createTextNode(docPriority + "#"));
				searchresult.appendChild(docPriorityElement);
				Element noteElement = doc2.createElement("note");
				noteElement.appendChild(doc2.createTextNode("#"));
				searchresult.appendChild(noteElement);

			}

			if(notecounter == 0){
				Element noteElement = doc2.createElement("note");
				noteElement.appendChild(doc2.createTextNode("#"));
				searchresult.appendChild(noteElement);
			}
			//searchresult.appendChild(quoteSourceElement);
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult result = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,result);
			div = writer.toString().trim();
			myConn.close();
		}
		catch(Exception e){
			div = " error " + e + ":: " + query;
			System.out.println(" QuoteHeaderBean.getxml");
			System.out.println(e);
			System.out.println(" QuoteHeaderBean.getxml END");
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

	public String getPSAXml(String psaNo){
		String div = "";
		Connection connPsa = null;
		Statement stmtPsa = null;
		try{
			if(orderNo == null){
				orderNo = "";
			}
			if(projectName == null){
				projectName = "";
			}
			if(archName == null){
				archName = "";
			}
			if(bpcsOrderNo == null){
				bpcsOrderNo = "";
			}
			if(custName == null){
				custName = "";
			}
			if(custLoc == null){
				custLoc = "";
			}
			if(agentName == null){
				agentName = "";
			}
			if(freightCity == null){
				freightCity = "";
			}
			if(projectState == null){
				projectState = "";
			}
			if(exclusions == null){
				exclusions = "";
			}
			if(qualifyingNotes == null){
				qualifyingNotes = "";
			}
			if(freeText == null){
				freeText = "";
			}
			if(overage == null){
				overage = "";
			}
			if(setupCost == null){
				setupCost = "";
			}
			if(handlingCost == null){
				handlingCost = "";
			}
			if(freightCost == null){
				freightCost = "";
			}
			if(creatorId == null){
				creatorId = "";
			}
			if(productId == null){
				productId = "";
			}
			if(configuredPrice == null){
				configuredPrice = "";
			}
			if(exclusionsFreeText == null){
				exclusionsFreeText = "";
			}
			if(qualifyingNotesFreeText == null){
				qualifyingNotesFreeText = "";
			}
			if(showComission == null){
				showComission = "";
			}
			if(quoteType == null){
				quoteType = "";
			}
			if(carriageCharge == null){
				carriageCharge = "";
			}
			if(carriageType == null){
				carriageType = "";
			}
			if(marketType == null){
				marketType = "";
			}
			if(terriRep == null){
				terriRep = "";
			}
			if(installDistance == null){
				installDistance = "";
			}
			if(createdBy == null){
				createdBy = "";
			}
			if(createdOn == null){
				createdOn = "";
			}
			if(originalNo == null){
				originalNo = "";
			}
			if(orderDate == null){
				orderDate = "";
			}
			if(internalNotes == null){
				internalNotes = "";
			}
			if(jobLoc == null){
				jobLoc = "";
			}
			if(archLoc == null){
				archLoc = "";
			}

			if(repEmail == null){
				repEmail = "";
			}
			if(projectType == null){
				projectType = "";
			}
			if(projectTypeId == null){
				projectTypeId = "";
			}
			File fXmlFile = new File("erapid.xml");
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
				}
			}
			Class.forName("com.sybase.jdbc2.jdbc.SybDriver");
			connPsa = DriverManager.getConnection("jdbc:sybase:Tds:" + dbPSAServerName + ":" + dbPSAServerPort,PSADBUsername,PSADBPassword);
			stmtPsa = connPsa.createStatement();
			String psa_project_id = "";
			String psa_quote_id = "";
			String quote_notes = "";
			String quote_region = "";
			int count_quotation = 0;
			String psa_project_name = "";
			String psa_project_town = "";
			String psa_project_state = "";
			String psa_product_id = "";
			String psa_acct_id = "";
			String psa_acct_name = "";
			String psa_cont_name = "";
			String psa_cont_id = "";
			String arch_acct_id = "";
			String Arch_name = "";
			String Arch_loc = "";
			ResultSet rs_psa = stmtPsa.executeQuery("SELECT quote_id,project_id,notes,quote_region,quote_type_id FROM dba.quotation where quote_id  like '" + psaNo + "%" + "' ");
			while(rs_psa.next()){
				psa_quote_id = rs_psa.getString("quote_id");
				psa_project_id = rs_psa.getString("project_id");
				quote_notes = rs_psa.getString("notes");
				quote_region = rs_psa.getString("quote_region");
				psa_product_id = rs_psa.getString("quote_type_id");
				count_quotation++;
			}
			rs_psa.close();
			if(psa_product_id.equals("GC")){
				psa_product_id = "GCP";
			}
			if(psa_product_id.equals("DL")){
				psa_product_id = "IWP";
			}
			setDefaultNotes(psa_product_id);
			if(count_quotation > 0){
				ResultSet rs_psa_pt = stmtPsa.executeQuery("SELECT project_id,project_title,site_town,site_county FROM dba.project where project_id like '" + psa_project_id + "'");
				while(rs_psa_pt.next()){
					psa_project_id = rs_psa_pt.getString(1);
					psa_project_name = rs_psa_pt.getString(2);
					psa_project_town = rs_psa_pt.getString(3);
					psa_project_state = rs_psa_pt.getString(4);
				}
				rs_psa_pt.close();
				ResultSet rs_psa_qa = stmtPsa.executeQuery("select * FROM dba.proj_ac_link where project_id= '" + psa_project_id + "' and aclookup_id in (select acct_id FROM dba.quoted_accounts where quote_id='" + psaNo + "') ");
				while(rs_psa_qa.next()){
					psa_acct_id = rs_psa_qa.getString(3);
					psa_acct_name = rs_psa_qa.getString(5);
					psa_cont_name = rs_psa_qa.getString(7);
					psa_cont_id = rs_psa_qa.getString(9);
				}
				rs_psa_qa.close();
				ResultSet rs_psa_proj_ac_link = stmtPsa.executeQuery("SELECT * FROM dba.proj_ac_link where project_id like '" + psa_project_id + "' order by link_id");
				if(rs_psa_proj_ac_link != null){
					while(rs_psa_proj_ac_link.next()){
						if(rs_psa_proj_ac_link.getString("role_type_id").equals("2")){
							arch_acct_id = rs_psa_proj_ac_link.getString("aclookup_id");
						}
					}
				}
				rs_psa_proj_ac_link.close();
				if(arch_acct_id.trim().length() > 0){
					ResultSet rs_psa_account = stmtPsa.executeQuery("SELECT acctname,town FROM dba.account where acct_id like '" + arch_acct_id + "'");
					if(rs_psa_account != null){
						while(rs_psa_account.next()){
							Arch_name = rs_psa_account.getString(1);
							Arch_loc = rs_psa_account.getString(2);
						}
					}
					rs_psa_account.close();
				}
			}
			if(psaNo == null){
				psaNo = "";
			}
			if(psa_project_name == null){
				psa_project_name = "";
			}
			if(psa_project_town == null){
				psa_project_town = "";
			}
			if(psa_project_state == null){
				psa_project_state = "";
			}
			if(psa_acct_id == null){
				psa_acct_id = "";
			}
			if(psa_acct_name == null){
				psa_acct_name = "";
			}
			if(psa_cont_name == null){
				psa_cont_name = "";
			}
			if(Arch_loc == null){
				Arch_loc = "";
			}
			if(Arch_name == null){
				Arch_name = "";
			}
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			//System.out.println("5");
			Element resultList = doc2.createElement("search");
			doc2.appendChild(resultList);
			Element searchresult = doc2.createElement("searchresult");
			resultList.appendChild(searchresult);
			Element orderNoElement = doc2.createElement("orderNo");
			orderNoElement.appendChild(doc2.createTextNode(orderNo.trim() + "#"));
			searchresult.appendChild(orderNoElement);
			//System.out.println("a");
			Element projectNameElement = doc2.createElement("projectName");
			projectNameElement.appendChild(doc2.createTextNode(psa_project_name.trim() + "#"));
			searchresult.appendChild(projectNameElement);
			Element jobLocElement = doc2.createElement("jobLoc");
			jobLocElement.appendChild(doc2.createTextNode(psa_project_town.trim() + "#"));
			searchresult.appendChild(jobLocElement);
			Element archNameElement = doc2.createElement("archName");
			archNameElement.appendChild(doc2.createTextNode(Arch_name.trim() + "#"));
			searchresult.appendChild(archNameElement);
			Element archLocElement = doc2.createElement("archLoc");
			archLocElement.appendChild(doc2.createTextNode(Arch_loc.trim() + "#"));
			searchresult.appendChild(archLocElement);
			//System.out.println("b");
			Element bpcsOrderNoElement = doc2.createElement("bpcsOrderNo");
			bpcsOrderNoElement.appendChild(doc2.createTextNode(bpcsOrderNo.trim() + "#"));
			searchresult.appendChild(bpcsOrderNoElement);
			Element custNameElement = doc2.createElement("custName");
			custNameElement.appendChild(doc2.createTextNode(psa_acct_id.trim() + "#"));
			searchresult.appendChild(custNameElement);
			Element custLocElement = doc2.createElement("custLoc");
			custLocElement.appendChild(doc2.createTextNode(psa_acct_name.trim() + "#"));
			searchresult.appendChild(custLocElement);
			Element agentNameElement = doc2.createElement("agentName");
			agentNameElement.appendChild(doc2.createTextNode(psa_cont_name.trim() + "#"));
			searchresult.appendChild(agentNameElement);
			Element freightCityElement = doc2.createElement("freightCity");
			freightCityElement.appendChild(doc2.createTextNode(freightCity.trim() + "#"));
			searchresult.appendChild(freightCityElement);
			//System.out.println("c");
			Element projectStateElement = doc2.createElement("projectState");
			projectStateElement.appendChild(doc2.createTextNode(psa_project_state.trim() + "#"));
			searchresult.appendChild(projectStateElement);
			Element exclusionsElement = doc2.createElement("exclusions");
			exclusionsElement.appendChild(doc2.createTextNode(exclusions.trim() + "#"));
			searchresult.appendChild(exclusionsElement);
			Element qualifyingNotesElement = doc2.createElement("qualifyingNotes");
			qualifyingNotesElement.appendChild(doc2.createTextNode(qualifyingNotes.trim() + "#"));
			searchresult.appendChild(qualifyingNotesElement);
			Element freeTextElement = doc2.createElement("freeText");
			freeTextElement.appendChild(doc2.createTextNode(freeText.trim() + "#"));
			searchresult.appendChild(freeTextElement);
			Element overageElement = doc2.createElement("overage");
			overageElement.appendChild(doc2.createTextNode(overage.trim() + "#"));
			searchresult.appendChild(overageElement);
			Element setupCostElement = doc2.createElement("setupCost");
			setupCostElement.appendChild(doc2.createTextNode(setupCost.trim() + "#"));
			searchresult.appendChild(setupCostElement);
			Element handlingCostElement = doc2.createElement("handlingCost");
			handlingCostElement.appendChild(doc2.createTextNode(handlingCost.trim() + "#"));
			searchresult.appendChild(handlingCostElement);
			Element freightCostElement = doc2.createElement("freightCost");
			freightCostElement.appendChild(doc2.createTextNode(freightCost.trim() + "#"));
			searchresult.appendChild(freightCostElement);
			Element creatorIdElement = doc2.createElement("creatorId");
			creatorIdElement.appendChild(doc2.createTextNode(creatorId.trim() + "#"));
			searchresult.appendChild(creatorIdElement);
			Element creatorUserNameElement = doc2.createElement("creatorUserName");
			creatorUserNameElement.appendChild(doc2.createTextNode(creatorUserName.trim() + "#"));
			searchresult.appendChild(creatorUserNameElement);
			Element creatorGroupElement = doc2.createElement("creatorGroup");
			creatorGroupElement.appendChild(doc2.createTextNode(creatorGroup.trim() + "#"));
			searchresult.appendChild(creatorGroupElement);
			Element productIdElement = doc2.createElement("productId");
			productIdElement.appendChild(doc2.createTextNode(psa_product_id.trim() + "#"));
			searchresult.appendChild(productIdElement);
			Element configuredPriceElement = doc2.createElement("configuredPrice");
			configuredPriceElement.appendChild(doc2.createTextNode(configuredPrice.trim() + "#"));
			searchresult.appendChild(configuredPriceElement);
			Element exclusionsFreeTextElement = doc2.createElement("exclusionsFreeText");
			exclusionsFreeTextElement.appendChild(doc2.createTextNode(exclusionsFreeText.trim() + "#"));
			searchresult.appendChild(exclusionsFreeTextElement);
			Element qualifyingNotesFreeTextElement = doc2.createElement("qualifyingNotesFreeText");
			qualifyingNotesFreeTextElement.appendChild(doc2.createTextNode(qualifyingNotesFreeText.trim() + "#"));
			searchresult.appendChild(qualifyingNotesFreeTextElement);
			Element showComissionElement = doc2.createElement("showComission");
			showComissionElement.appendChild(doc2.createTextNode(showComission.trim() + "#"));
			searchresult.appendChild(showComissionElement);
			Element quoteTypeElement = doc2.createElement("quoteType");
			quoteTypeElement.appendChild(doc2.createTextNode(quoteType.trim() + "#"));
			searchresult.appendChild(quoteTypeElement);
			Element carriageChargeElement = doc2.createElement("carriageCharge");
			carriageChargeElement.appendChild(doc2.createTextNode(carriageCharge.trim() + "#"));
			searchresult.appendChild(carriageChargeElement);
			Element carriageTypeElement = doc2.createElement("carriageType");
			carriageTypeElement.appendChild(doc2.createTextNode(carriageType.trim() + "#"));
			searchresult.appendChild(carriageTypeElement);
			Element marketTypeElement = doc2.createElement("marketType");
			marketTypeElement.appendChild(doc2.createTextNode(marketType.trim() + "#"));
			searchresult.appendChild(marketTypeElement);
			//System.out.println("d");
			Element terriRepElement = doc2.createElement("terriRep");
			terriRepElement.appendChild(doc2.createTextNode(terriRep.trim() + "#"));
			searchresult.appendChild(terriRepElement);
			Element installDistanceElement = doc2.createElement("installDistance");
			installDistanceElement.appendChild(doc2.createTextNode(installDistance.trim() + "#"));
			searchresult.appendChild(installDistanceElement);
			Element createdByElement = doc2.createElement("createdBy");
			createdByElement.appendChild(doc2.createTextNode(createdBy.trim() + "#"));
			searchresult.appendChild(createdByElement);;
			Element createdOnElement = doc2.createElement("createdOn");
			createdOnElement.appendChild(doc2.createTextNode(createdOn.trim() + "#"));
			searchresult.appendChild(createdOnElement);
			Element originalNoElement = doc2.createElement("originalNo");
			originalNoElement.appendChild(doc2.createTextNode(originalNo.trim() + "#"));
			searchresult.appendChild(originalNoElement);
			Element orderDateElement = doc2.createElement("orderDate");
			orderDateElement.appendChild(doc2.createTextNode(orderDate.trim() + "#"));
			searchresult.appendChild(orderDateElement);
			Element internalNotesElement = doc2.createElement("internalNotes");
			internalNotesElement.appendChild(doc2.createTextNode(internalNotes.trim() + "#"));
			searchresult.appendChild(internalNotesElement);
			Element projectTypeElement = doc2.createElement("projectType");
			projectTypeElement.appendChild(doc2.createTextNode("PSA#"));
			searchresult.appendChild(projectTypeElement);
			Element d = doc2.createElement("groupCode");
			d.appendChild(doc2.createTextNode(groupCode.trim() + "#"));
			searchresult.appendChild(d);
			Element e = doc2.createElement("salesRegion");
			e.appendChild(doc2.createTextNode(salesRegion.trim() + "#"));
			searchresult.appendChild(e);
			Element f = doc2.createElement("constructionType");
			f.appendChild(doc2.createTextNode(constructionType.trim() + "#"));
			searchresult.appendChild(f);
			Element g = doc2.createElement("endUser");
			g.appendChild(doc2.createTextNode(endUser.trim() + "#"));
			searchresult.appendChild(g);
			Element h = doc2.createElement("pricingOptions");
			h.appendChild(doc2.createTextNode("#"));
			searchresult.appendChild(h);
			Element j = doc2.createElement("pricingOptionsFree");
			j.appendChild(doc2.createTextNode("#"));
			searchresult.appendChild(j);
			Element k = doc2.createElement("instructions");
			k.appendChild(doc2.createTextNode(instructions.trim() + "#"));
			searchresult.appendChild(k);
			Element l = doc2.createElement("docStage");
			l.appendChild(doc2.createTextNode(docStage.trim() + "#"));
			searchresult.appendChild(l);
			Element projectTypeIdElement = doc2.createElement("projectTypeId");
			projectTypeIdElement.appendChild(doc2.createTextNode(psaNo + "#"));
			searchresult.appendChild(projectTypeIdElement);
			java.util.Date uDate = new java.util.Date(); // Right now
			java.sql.Date days1 = new java.sql.Date(uDate.getTime());
			GregorianCalendar firstFlight = new GregorianCalendar();
			GregorianCalendar firstFlight2 = new GregorianCalendar();
			GregorianCalendar firstFlight3 = new GregorianCalendar();
			firstFlight.add(Calendar.DATE,60);
			firstFlight2.add(Calendar.DATE,55);
			firstFlight3.add(Calendar.DATE,90);
			java.util.Date days60 = firstFlight.getTime();
			java.util.Date days55 = firstFlight2.getTime();
			java.util.Date days90 = firstFlight3.getTime();
			java.sql.Date days60Format = new java.sql.Date(days60.getTime());
			java.sql.Date days55Format = new java.sql.Date(days55.getTime());
			java.sql.Date days90Format = new java.sql.Date(days90.getTime());
			Element winLossElement = doc2.createElement("winLoss");
			winLossElement.appendChild(doc2.createTextNode("OPEN#"));
			searchresult.appendChild(winLossElement);
			Element docTypeElement = doc2.createElement("docType");
			docTypeElement.appendChild(doc2.createTextNode("Q#"));
			searchresult.appendChild(docTypeElement);
			Element docDateElement = doc2.createElement("docDate");
			docDateElement.appendChild(doc2.createTextNode(days1 + "#"));
			searchresult.appendChild(docDateElement);
			Element entryDateElement = doc2.createElement("entryDate");
			entryDateElement.appendChild(doc2.createTextNode(days1 + "#"));
			searchresult.appendChild(entryDateElement);
			Element expiresDateElement = doc2.createElement("expiresDate");
			expiresDateElement.appendChild(doc2.createTextNode(days60Format + "#"));
			searchresult.appendChild(expiresDateElement);
			Element expiresDate2Element = doc2.createElement("expiresDate2");
			expiresDate2Element.appendChild(doc2.createTextNode(days90Format + "#"));
			searchresult.appendChild(expiresDate2Element);
			//System.out.println("f");
			Element winLossDescElement = doc2.createElement("winLossDesc");
			winLossDescElement.appendChild(doc2.createTextNode("#"));
			searchresult.appendChild(winLossDescElement);
			Element docPriorityElement = doc2.createElement("docPriority");
			docPriorityElement.appendChild(doc2.createTextNode("#"));
			searchresult.appendChild(docPriorityElement);
			Element noteElement = doc2.createElement("note");
			noteElement.appendChild(doc2.createTextNode("#"));
			searchresult.appendChild(noteElement);
			Element a = doc2.createElement("exchName");
			a.appendChild(doc2.createTextNode(exchName.trim() + "#"));
			searchresult.appendChild(a);
			Element b = doc2.createElement("exchRate");
			b.appendChild(doc2.createTextNode(exchRate.trim() + "#"));
			searchresult.appendChild(b);
			Element c = doc2.createElement("exchDate");
			c.appendChild(doc2.createTextNode(exchDate.trim() + "#"));
			searchresult.appendChild(c);

			if(orderNo.trim().length() <= 0 && (productId.equals("IWP") || productId.equals("EJC"))){
				Element showRecapElement = doc2.createElement("showRecap");
				showRecapElement.appendChild(doc2.createTextNode("on#"));
				searchresult.appendChild(showRecapElement);
			}
			else{
				Element showRecapElement = doc2.createElement("showRecap");
				showRecapElement.appendChild(doc2.createTextNode(showRecap + "#"));
				searchresult.appendChild(showRecapElement);
			}			//System.out.println("6");
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult result = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,result);
			div = writer.toString().trim();

		}
		catch(Exception e){
			System.out.println("QuoteHeaderBean.getPSAXml");
			System.out.println(e);
			System.out.println("QuoteHeaderBean.getPSAXml END");
		}
		finally{
			try{
				connPsa.close();
				stmtPsa.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
		return div;
	}

	public String getCountries(){
		String div = "";
		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("erapid.xml");
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
			div = div + "<option value=''></option>";
			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			query = "select * from cs_country_codes order by name";
			//System.out.println(query);
			ResultSet rs1 = stmt.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					div = div + "<option value='" + rs1.getString("code") + "'>" + rs1.getString("name") + "</option>";
				}
			}
			myConn.close();
		}
		catch(Exception e){
			div = " error " + e + ":: " + query;
			System.out.println(" QuoteHeaderBean.getCountries");
			System.out.println(e);
			System.out.println(" QuoteHeaderBean.getCountries END");
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

	public String getCountries2(){
		String div = "";
		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("erapid.xml");
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
			div = div + "<option value=''></option>";
			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			query = "select * from cs_country_codes order by name";
			ResultSet rs1 = stmt.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					div = div + "<option value='" + rs1.getString("name") + "'>" + rs1.getString("name") + "</option>";
				}
			}
			myConn.close();
		}
		catch(Exception e){
			div = " error " + e + ":: " + query;
			System.out.println(" QuoteHeaderBean.getCountries");
			System.out.println(e);
			System.out.println(" QuoteHeaderBean.getCountries END");
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

	public String getPullDownValues(String pullDownCountry,String pullDownProductId,String pullDownGroupId,String pullDownSelectName){
		String div = "";
		Connection myConn = null;
		Statement stmt = null;
		try{

			File fXmlFile = new File("erapid.xml");
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
			//System.out.println(pullDownSelectName+"0");
			if(pullDownSelectName.toLowerCase().equals("bcc")){
				query = "select email_address  from cs_bcc where country_code='" + pullDownCountry + "' order by email_address";
				ResultSet rs1 = stmt.executeQuery(query);
				if(rs1 != null){
					while(rs1.next()){
						div = div + "<option value='" + rs1.getString(1) + "'>" + rs1.getString(1) + "</option>";
					}
				}
			}
			else if(pullDownSelectName.equals("project_state")){
				query = "select state_code,state_name from cs_state_codes where country_code in ('us','CA') order by country_code desc, state_name ";
				div = div + "<option value=''></option>";
				ResultSet rs1 = stmt.executeQuery(query);
				if(rs1 != null){
					while(rs1.next()){
						div = div + "<option value='" + rs1.getString(2) + "'>" + rs1.getString(2) + "</option>";
					}
				}

			}
			else if(pullDownSelectName.equals("project_state2")){
				query = "select state_code,state_name from cs_state_codes where country_code in ('us','CA') order by country_code desc, state_name ";
				div = div + "<option value=''></option>";
				ResultSet rs1 = stmt.executeQuery(query);
				if(rs1 != null){
					while(rs1.next()){
						div = div + "<option value='" + rs1.getString(1) + "'>" + rs1.getString(2) + "</option>";
					}
				}

			}
			else if(pullDownSelectName.equals("emailQuotes")){
				query = "select name,url,urlAdd from cs_button_security where (url like 'quotes/%' or url like 'reports/change%') and action='pdf' and product_id='" + pullDownProductId + "' and group_id in ('" + pullDownGroupId + "','*')";
				//System.out.println("quoteheader bean line 1632::" + query);
				div = div + "<option value=''></option>";
				ResultSet rs1 = stmt.executeQuery(query);
				if(rs1 != null){
					while(rs1.next()){
						div = div + "<option value='" + rs1.getString(2) + rs1.getString(3) + "'>" + rs1.getString(1) + rs1.getString(2) + rs1.getString(3) + "</option>";
					}
				}
			}
			else if(pullDownSelectName.equals("groupCode")){
				query = "select ccode,ccdesc from cs_ge_group_codes order by ccdesc";
				div = div + "<option value=''></option>";
				ResultSet rs1 = stmt.executeQuery(query);
				if(rs1 != null){
					while(rs1.next()){
						div = div + "<option value='" + rs1.getString(1) + "'>" + rs1.getString(2) + "</option>";
					}
				}
			}
			else if(pullDownSelectName.equals("salesRegion")){
				query = "select region_code,region from cs_regions where product_id='ge'";
				div = div + "<option value=''></option>";
				ResultSet rs1 = stmt.executeQuery(query);
				if(rs1 != null){
					while(rs1.next()){
						div = div + "<option value='" + rs1.getString(1) + "'>" + rs1.getString(1) + "</option>";
					}
				}
			}
			else if(pullDownSelectName.equals("commission")){
				query = "select * from cs_lvr_sp_factor where product_id='" + pullDownProductId + "' order by cast(com_percent as integer) desc";
				//System.out.println(query);
				div = div + "<option value=''></option>";
				ResultSet rs1 = stmt.executeQuery(query);
				if(rs1 != null){
					while(rs1.next()){
						div = div + "<option value='" + rs1.getString(1) + "'>" + rs1.getString(1) + "</option>";
					}
				}
			}
			else{
				query = "select * from cs_pull_downs where country='" + pullDownCountry + "' and product_id in ('" + pullDownProductId + "','*') and (group_id like '%" + pullDownGroupId + "%' or group_id='*') and select_name='" + pullDownSelectName + "' order by cast(sequence as float)";
				ResultSet rs1 = stmt.executeQuery(query);
				if(rs1 != null){
					while(rs1.next()){
						div = div + "<option value='" + rs1.getString("option_value") + "'>" + rs1.getString("option_label") + "</option>";
					}
				}
			}
			//System.out.println(div + ":: pulldown query quoteheaderbean line 1428");
			myConn.close();
		}
		catch(Exception e){
			div = " error " + e + ":: " + query;
			System.out.println(" QuoteHeaderBean.getPullDownValues");
			System.out.println(e);
			System.out.println(" QuoteHeaderBean.getPullDownValues END");
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

	public String getPullDownValues2(String pullDownCountry,String pullDownProductId,String pullDownGroupId,String pullDownSelectName,String projectType,String quoteOrigin){
		String div = "";
		if(projectType == null || projectType.trim().length() == 0){
			projectType = "rep";
		}
		if(quoteOrigin == null){
			quoteOrigin = "";
		}
		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("erapid.xml");
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
			//System.out.println(pullDownSelectName+"0");
			String pullDownGroupId2 = pullDownGroupId;
			if(pullDownGroupId2.toUpperCase().indexOf("REP") >= 0){
				pullDownGroupId2 = "REP*";
			}
			if(pullDownSelectName.equals("emailQuotes")){
				query = "select name,url,urlAdd from cs_button_security where (url like 'quotes/%' or url like 'reports/change%') and action='pdf' and product_id='" + pullDownProductId + "' and group_id in ('" + pullDownGroupId2 + "','*') and (not_group_id ='' or not not_group_id like '%" + pullDownGroupId + "%') and project_type='" + projectType + "' AND (quote_origin IN ('*', '" + quoteOrigin + "')) AND (not_quote_origin IS NULL OR NOT (not_quote_origin = '" + quoteOrigin + "')) order by seq";
				//System.out.println("quoteheader bean line 1798::" + query);

				div = div + "<option value=''></option>";
				ResultSet rs1 = stmt.executeQuery(query);
				int countx = 0;
				if(rs1 != null){
					while(rs1.next()){
						String selected = "";
						if(countx == 0){
							selected = "selected";
						}
						div = div + "<option value='" + rs1.getString(2) + rs1.getString(3).replaceAll("&","!") + "' " + selected + ">" + rs1.getString(1) + "</option>";
						countx++;
					}
				}
			}
			myConn.close();
		}
		catch(Exception e){
			div = " error " + e + ":: " + query;
			System.out.println(" QuoteHeaderBean.getPullDownValues2");
			System.out.println(e);
			System.out.println(" QuoteHeaderBean.getPullDownValues2 END");
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

	public void setDefaultNotes(String notesProductId){
		Connection myConn = null;
		Statement stmt = null;
		try{

			File fXmlFile = new File("erapid.xml");
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
			//System.out.println(exclusions+":: exc");
			//System.out.println(qualifyingNotes+":: qlf");
			ResultSet rs1 = stmt.executeQuery("select * from cs_exc_notes where product_id='" + notesProductId + "' and not set_default is null and set_default='y' order by code");
			if(rs1 != null){
				while(rs1.next()){
					exclusions = exclusions + rs1.getString("code") + ",";
				}
			}
			rs1.close();
			ResultSet rs2 = stmt.executeQuery("select * from cs_qlf_notes where product_id='" + notesProductId + "' and not set_default is null and set_default='y' order by code");
			if(rs2 != null){
				while(rs2.next()){
					qualifyingNotes = qualifyingNotes + rs2.getString("code") + ",";
				}
			}
			rs2.close();
			if(exclusions != null && exclusions.trim().endsWith(",")){
				exclusions = exclusions.trim().substring(0,exclusions.trim().length() - 1);
			}
			if(qualifyingNotes != null && qualifyingNotes.trim().endsWith(",")){
				qualifyingNotes = qualifyingNotes.trim().substring(0,qualifyingNotes.trim().length() - 1);
			}
			//System.out.println(exclusions+":: exc");
			//System.out.println(qualifyingNotes+":: qlf");
			myConn.close();
		}
		catch(Exception e){
			System.out.println(" QuoteHeaderBean.getDefaultNotes");
			System.out.println(e);
			System.out.println(" QuoteHeaderBean.getDefaultNotes END");
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
		//return div;
	}

	public String getNotes(String notesProductId,String noteType){
		String div = "";
		Connection myConn = null;
		Statement stmt = null;
		try{
			String table_name = "";
			if(noteType.equals("exclusion")){
				table_name = "cs_exc_notes";
			}
			else if(noteType.equals("qualify")){
				table_name = "cs_qlf_notes";
			}
			else if(noteType.equals("pricingOptions")){
				table_name = "cs_pricing_options";
			}
			File fXmlFile = new File("erapid.xml");
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
			ResultSet rs1 = stmt.executeQuery("select * from " + table_name + " where product_id='" + notesProductId + "' order by code");
			//System.out.println("select * from "+table_name+" where product_id='"+notesProductId+"' order by code");
			if(rs1 != null){
				while(rs1.next()){
					if(noteType.equals("qualify")){
						if(notesProductId.equals("ADS")){
							div = div + "<input type='checkbox' name='" + table_name + "1' id='" + table_name + "1' value='" + rs1.getString("code") + "'>" + rs1.getString("code") + ". " + rs1.getString("description") + " <font color='red'>" + rs1.getString("type") + "</font><BR>";
						}
						else{
							div = div + "<input type='checkbox' name='" + table_name + "1' id='" + table_name + "1' value='" + rs1.getString("code") + "'>" + rs1.getString("code") + ". " + rs1.getString("description") + " <font color='red'>" + rs1.getString("model") + "</font><BR>";
						}
					}
					else if(noteType.equals("pricingOptions")){
						String color = "black";
						if(rs1.getString("country") != null && rs1.getString("country").equals("CAN")){
							color = "red";
						}
						div = div + "<input type='checkbox' name='" + table_name + "1' id='" + table_name + "1' value='" + rs1.getString("code") + "'><font color='" + color + "'>" + rs1.getString("code") + ". " + rs1.getString("description") + "</font><BR>";

					}
					else{
						if(notesProductId.equals("ADS")){
							div = div + "<input type='checkbox' name='" + table_name + "1' id='" + table_name + "1' value='" + rs1.getString("code") + "'>" + rs1.getString("code") + ". " + rs1.getString("description") + "<font color='red'>" + rs1.getString("type") + "</font><BR>";

						}
						else{
							div = div + "<input type='checkbox' name='" + table_name + "1' id='" + table_name + "1' value='" + rs1.getString("code") + "'>" + rs1.getString("code") + ". " + rs1.getString("description") + "<BR>";
						}
					}
				}
				rs1.close();
			}
			myConn.close();
		}
		catch(Exception e){
			System.out.println(" QuoteHeaderBean.getNotes");
			System.out.println(e);
			System.out.println(" QuoteHeaderBean.getNotes END");
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

	public String saveHeader(String orderNo,String projectName,String custName,String custLoc,String jobLoc,String projectState,String archName,String archLoc,String exclusions,String qualifyingNotes,String terriRep,String marketType,String projectState2,String internalNo,String winLoss,String docType,String docDate,String entryDate,String expiresDate,String winLossDesc,String exclusionsFreeText,String qualifyingNotesFreeText,String freeText,String internalNotes,String qtype,String product,String repNum,String altCpyNo,String custNo,String userId,String agentName,String projectType,String projectTypeId,String quoteType,String showRecap,String exchName,String exchRate,String exchDate,String groupCodes,String salesRegion,String constructionType,String endUser,String bpcsOrderNo,String pricingOptions,String pricingOptionsFree,String instructions,String docStage,String changeCustomer,String changeArch){
		boolean isProfileCopy = false;
		boolean isSample = false;
		int isCustomerChange = 0;
		int isArchChange = 0;
		Connection myConn = null;
		Statement stmt = null;
		Connection myConnSfdc = null;
		Statement stmtSfdc = null;
		try{
			if(changeCustomer != null && changeCustomer.equals("YES")){
				isCustomerChange = 1;
			}
			if(changeArch != null && changeArch.equals("YES")){
				isArchChange = 1;
			}
			File fXmlFile = new File("erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					serverName = "" + getTagValue("serverName",eElement);
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					dbServerName = "" + getTagValue("dbServerName",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
					dbSFDCServerName = "" + getTagValue("dbSFDCServerName",eElement);
					dbSFDCServerPort = "" + getTagValue("dbSFDCServerPort",eElement);
					SFDCDB = "" + getTagValue("SFDCDB",eElement);
					SFDCDBUsername = "" + getTagValue("SFDCDBUsername",eElement);
					SFDCDBPassword = "" + getTagValue("SFDCDBPassword",eElement);
				}
			}
			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			myConnSfdc = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbSFDCServerName + ":" + dbSFDCServerPort + "/" + SFDCDB,SFDCDBUsername,SFDCDBPassword);
			stmtSfdc = myConnSfdc.createStatement();
			stmtSfdc.executeUpdate("set ANSI_warnings off");

			if(exchRate == null || exchRate.trim().length() <= 0){
				exchRate = null;
			}

			if(docType.toUpperCase().equals("B")){
				docType = "Q";
			}
			if(qualifyingNotes != null){
				if(qualifyingNotes.endsWith(",")){
					qualifyingNotes = qualifyingNotes.substring(0,qualifyingNotes.length() - 1);
				}
			}
			if(exclusions != null){
				if(exclusions.endsWith(",")){
					exclusions = exclusions.substring(0,exclusions.length() - 1);
				}
			}
			if(docStage == null){
				docStage = "";
			}
			//if(showRecap.equals("on")){
			//	showRecap="Y";
			//}
			if(orderNo.trim().length() > 0){
				try{
					if(projectState == null || projectState.trim().length() == 0){
						projectState2 = projectState;
					}
					java.sql.PreparedStatement updateCsProject = myConn.prepareStatement("UPDATE cs_project set project_name=?,cust_name=?,cust_loc=?,job_loc=?,project_state=?,arch_name=?,arch_loc=?,exclusions=?,qualifying_notes=?,terri_rep=?,market_type=?,	exclusions_free_text=?,qualifying_notes_free_text=?,free_text=?,internal_notes=?,quote_type=?,agent_name=?,show_recap=?,exch_name=?,exch_rate=?,exch_rate_date=?,group_code=?,sales_region=?,construction_type=?,end_user=?,bpcs_order_no=?,pricing_options=?,pricing_options_free_text=?,instructions=?,changeCustomer=?,changeArch=? WHERE order_no= ?");
					updateCsProject.setString(1,projectName);
					updateCsProject.setString(2,custNo);
					updateCsProject.setString(3,custLoc);
					updateCsProject.setString(4,jobLoc);
					updateCsProject.setString(5,projectState);
					updateCsProject.setString(6,archName);
					updateCsProject.setString(7,archLoc);
					updateCsProject.setString(8,exclusions);
					updateCsProject.setString(9,qualifyingNotes);
					updateCsProject.setString(10,terriRep);
					updateCsProject.setString(11,marketType);
					updateCsProject.setString(12,exclusionsFreeText);
					updateCsProject.setString(13,qualifyingNotesFreeText);
					updateCsProject.setString(14,freeText);
					updateCsProject.setString(15,internalNotes);
					updateCsProject.setString(16,docType);
					updateCsProject.setString(17,agentName);
					updateCsProject.setString(18,showRecap);
					updateCsProject.setString(19,exchName);
					updateCsProject.setString(20,exchRate);
					updateCsProject.setString(21,exchDate);
					updateCsProject.setString(22,groupCodes);
					updateCsProject.setString(23,salesRegion);
					updateCsProject.setString(24,constructionType);
					updateCsProject.setString(25,endUser);
					updateCsProject.setString(26,bpcsOrderNo);
					updateCsProject.setString(27,pricingOptions);
					updateCsProject.setString(28,pricingOptionsFree);
					updateCsProject.setString(29,instructions);
					updateCsProject.setInt(30,isCustomerChange);
					updateCsProject.setInt(31,isArchChange);
					updateCsProject.setString(32,orderNo);
					int rocount = updateCsProject.executeUpdate();
					updateCsProject.close();

					boolean isTypeChange = false;
					String oldType = "";
					String oldWinLoss = "";
					String tempDocSalesperson = "";
					String tempDocPriority = "";
					ResultSet rsType = stmt.executeQuery("select doc_type,doc_salesperson,doc_priority,win_loss from doc_header where doc_number='" + orderNo + "'");
					if(rsType != null){
						while(rsType.next()){
							if(!rsType.getString(1).equals(docType)){
								isTypeChange = true;
								oldType = rsType.getString(1);
								tempDocSalesperson = rsType.getString(2);
								tempDocPriority = rsType.getString(3);
								oldWinLoss = rsType.getString(4);

							}
						}
					}
					rsType.close();
					//System.out.println(projectType+":: projectType");
					//System.out.println(oldType+":: old type");
					//System.out.println(docType+":: new type");
					//System.out.println(oldWinLoss+":: old status");
					//System.out.println(winLoss+":: new status");
					if(projectType.equals("SFDC") || projectType.equals("RP")){
						String sfdcStatus = "";
						if(docType.equals("O") && winLoss.equals("CLOSE") && !(oldType.equals("O") && oldWinLoss.equals("CLOSE"))){
							sfdcStatus = "Won";
						}
						else if((oldType.equals("O") && oldWinLoss.equals("CLOSE")) && !(docType.equals("O") && winLoss.equals("CLOSE"))){
							sfdcStatus = "Bidding";
							if(product.equals("LVR")){
								sfdcStatus = "Pending";
							}
						}
						//System.out.println(sfdcStatus+":: sfdc status");
						if(serverName.indexOf("dev") > 0){
							System.out.println(" DEV SERVER--SFDC STATUS SCRIPT WONT RUN");
						}
						else{
							System.out.println("run stored procedure");
							stmtSfdc.executeUpdate("set ANSI_warnings on");
							stmtSfdc.executeUpdate("set ANSI_NULLS on");
							if(sfdcStatus != null && sfdcStatus.trim().length() > 0){
								try{
									CallableStatement cs = myConnSfdc.prepareCall("{call dbo.cspUpdateStatus(?,?)}");
									cs.setString(1,orderNo.trim());
									cs.setString(2,sfdcStatus.toUpperCase());
									cs.execute();
									cs.close();
									System.out.println("sfdc stored procedure run for " + orderNo + "::" + sfdcStatus);
								}
								catch(java.sql.SQLException e){
									System.out.println("Problem with salesforce stored procedure<br>");
									System.out.println("Illegal Operation try again/Report Error" + "<br>");
									System.out.println(e.toString());
								}
							}
							stmtSfdc.executeUpdate("set ANSI_warnings off");
							stmtSfdc.executeUpdate("set ANSI_NULLS off");
						}
					}
					if(isTypeChange){
						java.sql.PreparedStatement insertDocHeader = myConn.prepareStatement("insert into doc_header (win_loss,doc_type,doc_date,entry_date,expires_date,win_loss_desc,doc_number,doc_revision,doc_customer,doc_salesperson,doc_priority,doc_stage) values (?,?,?,?,?,?,?,?,?,?,?,?)");
						insertDocHeader.setString(1,winLoss);
						insertDocHeader.setString(2,docType);
						insertDocHeader.setString(3,docDate);
						insertDocHeader.setString(4,entryDate);
						insertDocHeader.setString(5,expiresDate);
						insertDocHeader.setString(6,winLossDesc);
						insertDocHeader.setString(7,orderNo);
						insertDocHeader.setString(8,"1");
						insertDocHeader.setString(9,custNo);
						insertDocHeader.setString(10,tempDocSalesperson);
						insertDocHeader.setString(11,tempDocPriority);
						insertDocHeader.setString(12,docStage);

						int rocount2 = insertDocHeader.executeUpdate();
						insertDocHeader.close();
						java.sql.PreparedStatement updateDocLine = myConn.prepareStatement("UPDATE doc_line set doc_type=? WHERE doc_number= ?");
						updateDocLine.setString(1,docType);
						updateDocLine.setString(2,orderNo);
						int rocount3 = updateDocLine.executeUpdate();
						updateDocLine.close();
						int rocount5 = stmt.executeUpdate("delete from doc_header where doc_number='" + orderNo + "' and doc_type='" + oldType + "'");

					}
					else{
						//doc_header
						java.sql.PreparedStatement updateDocHeader = myConn.prepareStatement("UPDATE doc_header set win_loss=?,doc_type=?,doc_date=?,entry_date=?,expires_date=?,win_loss_desc=?,doc_customer=?,doc_stage=? WHERE doc_number= ?");
						updateDocHeader.setString(1,winLoss);
						updateDocHeader.setString(2,docType);
						updateDocHeader.setString(3,docDate);
						updateDocHeader.setString(4,entryDate);
						updateDocHeader.setString(5,expiresDate);
						updateDocHeader.setString(6,winLossDesc);
						updateDocHeader.setString(7,custNo);
						updateDocHeader.setString(8,docStage);
						updateDocHeader.setString(9,orderNo);
						int rocount2 = updateDocHeader.executeUpdate();
						updateDocHeader.close();
					}

				}
				catch(Exception e){
					System.out.println(" QuoteHeaderBean.saveHeader");
					System.out.println(e);
					System.out.println(" QuoteHeaderBean.saveHeader END");
				}

			}
			else{
				//System.out.println("quoteheaderbean line 1693 add new quote");
				//System.out.println("quote header bean line 2203" + qtype);
				//String bpcsOrderNo = "";

				try{
					if(qtype.equals("cpy")){
						bpcsOrderNo = "";
					}
					//System.out.println(altCpyNo + "::1");
					ResultSet rsPFL = stmt.executeQuery("select project_type,quote_origin from cs_project where order_no='" + altCpyNo + "'");
					if(rsPFL != null){
						while(rsPFL.next()){
							if(rsPFL.getString(1) != null && rsPFL.getString(1).equals("PFL")){
								isProfileCopy = true;
							}
							if(rsPFL.getString(2) != null && rsPFL.getString(2).equals("sample")){
								isSample = true;
							}
						}
					}
					rsPFL.close();
					//System.out.println(altCpyNo + "::2");
					if(!(qtype.equals("alt") || qtype.equals("build") || qtype.equals("change") || qtype.equals("release") || qtype.equals("revision") || qtype.equals("submittal"))){
						/*
						 String tempOrderNo = "";
						 int newOrderNo = 0;
						 query = "select rec_no from rec_no_control where tablename='orders'";
						 ResultSet rsRecNo = stmt.executeQuery(query);
						 if(rsRecNo != null){
						 while(rsRecNo.next()){
						 tempOrderNo = rsRecNo.getString(1);
						 newOrderNo = rsRecNo.getInt(1);
						 }
						 }
						 rsRecNo.close();
						 newOrderNo++;
						 int nrows = stmt.executeUpdate("update rec_no_control set rec_no='" + newOrderNo + "' where tablename='orders'");
						 tempOrderNo = tempOrderNo + "_00";
						 orderNo = tempOrderNo;
						 */
						String tempOrderNo = "";
						CallableStatement proc = myConn.prepareCall("{ call sp_Get_order_no }");
						ResultSet result = proc.executeQuery();
						if(result != null){
							while(result.next()){
								tempOrderNo = result.getString(1);
							}
						}
						result.close();
						//System.out.println(tempOrderNo + "::HERE");
						tempOrderNo = tempOrderNo + "_00";
						orderNo = tempOrderNo;
					}
					else{
						if(!qtype.equals("cpy")){
							if(qtype.equals("change") || qtype.equals("release")){
								query = "select bpcs_order_no from cs_project where order_no='" + altCpyNo + "'";
								ResultSet rsBpcsNo = stmt.executeQuery(query);
								if(rsBpcsNo != null){
									while(rsBpcsNo.next()){
										bpcsOrderNo = rsBpcsNo.getString(1);
									}
								}
								rsBpcsNo.close();
								if(bpcsOrderNo == null){
									bpcsOrderNo = "";
								}
							}
						}
						else{
							bpcsOrderNo = "";
						}
						String base = altCpyNo.substring(0,altCpyNo.indexOf("_"));
						//System.out.println(altCpyNo + "::" + base + ":: quote header bean line 2050");
						String altNo = "";
						query = "SELECT doc_number FROM doc_header where doc_number like '" + base + "_%%' order by doc_number";
						ResultSet rsRecNo = stmt.executeQuery(query);
						if(rsRecNo != null){
							while(rsRecNo.next()){
								String tempRecNo = rsRecNo.getString(1);
								altNo = tempRecNo.substring(tempRecNo.length() - 2);
							}
						}
						rsRecNo.close();
						altNo = "" + (Integer.parseInt(altNo) + 1);
						if(altNo.trim().length() == 1){
							altNo = "0" + altNo;
						}
						else if(altNo.trim().length() > 2){
							altNo = "99";
						}
						orderNo = base + "_" + altNo;
					}
					this.orderNo = orderNo;
					//System.out.println(orderNo + ":: order number");

					if(orderNo != null && orderNo.trim().length() > 0){

						//System.out.println("quoteheaderbean line 1744 add cs_project");
						if(projectState == null || projectState.trim().length() == 0){
							projectState2 = projectState;
						}
						String template = "";
						String georder = "";
						if(quoteType.equals("G")){
							quoteType = "C";
							georder = "GE";
						}
						if(qtype.equals("pfl")){
							projectType = "PFL";
							template = "PFL";
							qtype = "";
						}
						if(qtype.equals("alt")){
							qtype = "Alternate";
						}
						if(isSample){
							qtype = "sample";
						}
						java.sql.PreparedStatement insertCsProject = myConn.prepareStatement("insert into cs_project( project_name,cust_name,cust_loc,job_loc,project_state,arch_name,arch_loc,exclusions,qualifying_notes,terri_rep,market_type,	exclusions_free_text,qualifying_notes_free_text,free_text,internal_notes,order_no,product_id,creator_id,base_quote_no,quote_type,user_id,agent_name,created_on,project_type,project_type_id,quote_origin,bpcs_order_no,doc_type_alt,template,show_recap,exch_name,exch_rate,exch_rate_date,group_code,sales_region,construction_type,end_user,pricing_options,pricing_options_free_text,instructions,changeCustomer,changeArch) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						insertCsProject.setString(1,projectName);
						insertCsProject.setString(2,custNo);
						insertCsProject.setString(3,custLoc);
						insertCsProject.setString(4,jobLoc);
						insertCsProject.setString(5,projectState);
						insertCsProject.setString(6,archName);
						insertCsProject.setString(7,archLoc);
						insertCsProject.setString(8,exclusions);
						insertCsProject.setString(9,qualifyingNotes);
						insertCsProject.setString(10,userId);
						insertCsProject.setString(11,marketType);
						insertCsProject.setString(12,exclusionsFreeText);
						insertCsProject.setString(13,qualifyingNotesFreeText);
						insertCsProject.setString(14,freeText);
						insertCsProject.setString(15,internalNotes);
						insertCsProject.setString(16,orderNo);
						insertCsProject.setString(17,product);
						insertCsProject.setString(18,repNum);
						insertCsProject.setString(19,altCpyNo);
						insertCsProject.setString(20,docType);
						insertCsProject.setString(21,userId);
						insertCsProject.setString(22,agentName);
						insertCsProject.setString(23,entryDate);
						insertCsProject.setString(24,projectType);
						insertCsProject.setString(25,projectTypeId);
						insertCsProject.setString(26,qtype);
						insertCsProject.setString(27,bpcsOrderNo);
						insertCsProject.setString(28,georder);
						insertCsProject.setString(29,template);
						insertCsProject.setString(30,showRecap);
						insertCsProject.setString(31,exchName);
						insertCsProject.setString(32,exchRate);
						insertCsProject.setString(33,exchDate);
						insertCsProject.setString(34,groupCodes);
						insertCsProject.setString(35,salesRegion);
						insertCsProject.setString(36,constructionType);
						insertCsProject.setString(37,endUser);
						insertCsProject.setString(38,pricingOptions);
						insertCsProject.setString(39,pricingOptionsFree);
						insertCsProject.setString(40,instructions);
						insertCsProject.setInt(41,isCustomerChange);
						insertCsProject.setInt(42,isArchChange);
						int rocount = insertCsProject.executeUpdate();
						insertCsProject.close();

						//System.out.println("quoteheaderbean line 1776 add cs_project end");
						//System.out.println(repNum+":: creator id");
						//System.out.println("quoteheaderbean line 1787 add doc_header" + "::" + "insert into doc_header (win_loss,doc_type,doc_date,entry_date,expires_date,win_loss_desc,doc_number,doc_revision,doc_customer,doc_salesperson) values (?,?,?,?,?,?,?,?,?,?)");
						java.sql.PreparedStatement insertDocHeader = myConn.prepareStatement("insert into doc_header (win_loss,doc_type,doc_date,entry_date,expires_date,win_loss_desc,doc_number,doc_revision,doc_customer,doc_salesperson,doc_priority,doc_stage) values (?,?,?,?,?,?,?,?,?,?,?,?)");
						insertDocHeader.setString(1,winLoss);
						insertDocHeader.setString(2,docType);
						insertDocHeader.setString(3,docDate);
						insertDocHeader.setString(4,entryDate);
						insertDocHeader.setString(5,expiresDate);
						insertDocHeader.setString(6,winLossDesc);
						insertDocHeader.setString(7,orderNo);
						insertDocHeader.setString(8,"1");
						insertDocHeader.setString(9,custNo);
						insertDocHeader.setString(10,repNum);
						insertDocHeader.setString(11,quoteType);
						insertDocHeader.setString(12,docStage);
						int rocount2 = insertDocHeader.executeUpdate();
						insertDocHeader.close();
					//System.out.println("quoteheaderbean line 18101 add doc_header end::" + rocount2);
						//System.out.println(orderNo + ":: order number");

						//System.out.println("quoteheaderbean line 1970" + qtype);
						if(isSample || isProfileCopy || qtype.equals("alt") || qtype.equals("Alternate") || qtype.equals("cpy") || qtype.equals("build") || qtype.equals("change") || qtype.equals("release") || qtype.equals("revision") || qtype.equals("submittal")){
							//System.out.println("quote headerbean line 1972 copy lines");
							copyLines(altCpyNo,orderNo,qtype,repNum,docType);
						}
					}

				}
				catch(Exception e){
					System.out.println(" QuoteHeaderBean.saveHeader");
					System.out.println(" existing header");
					System.out.println(e);
					System.out.println(" QuoteHeaderBean.saveHeader END");
				}

			}

		}
		catch(Exception e){
			System.out.println(" QuoteHeaderBean.saveHeader");
			System.out.println(" New header");
			System.out.println(" initialize db conn for new quote ");
			System.out.println(e);
			System.out.println(" QuoteHeaderBean.saveHeader END");
		}
		finally{
			try{
				stmt.close();
				myConn.close();
				stmtSfdc.close();
				myConnSfdc.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
		return orderNo;
	}

	private String copyLines(String oldOrderNo,String newOrderNo,String copyType,String newCreatorId,String dtype){
		//System.out.println("quoteheaderbean line 1330 copy lines");
		String tempQuery = "";
		Connection myConn = null;
		Statement stmt = null;
		Connection myConnSfdc = null;
		Statement stmtSfdc = null;
		try{
			File fXmlFile = new File("erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					serverName = "" + getTagValue("serverName",eElement);
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					dbServerName = "" + getTagValue("dbServerName",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
					dbSFDCServerName = "" + getTagValue("dbSFDCServerName",eElement);
					dbSFDCServerPort = "" + getTagValue("dbSFDCServerPort",eElement);
					SFDCDB = "" + getTagValue("SFDCDB",eElement);
					SFDCDBUsername = "" + getTagValue("SFDCDBUsername",eElement);
					SFDCDBPassword = "" + getTagValue("SFDCDBPassword",eElement);
				}
			}
			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			myConnSfdc = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbSFDCServerName + ":" + dbSFDCServerPort + "/" + SFDCDB,SFDCDBUsername,SFDCDBPassword);
			stmtSfdc = myConnSfdc.createStatement();
			stmtSfdc.executeUpdate("set ANSI_warnings off");
			String tempccode = "";
			query = "select country_code from cs_reps where rep_no_text='" + newCreatorId + "'";
			//System.out.println(query);
			ResultSet rscc = stmt.executeQuery(query);
			if(rscc != null){
				while(rscc.next()){
					tempccode = rscc.getString(1);
					//System.out.println(tempccode);
				}
			}
			rscc.close();

			query = "select * from cs_copy_dm where product_id in('" + productId + "','*') and country in ('" + tempccode + "','*') and action in ('" + copyType + "','*')";
			ResultSet rsDm = stmt.executeQuery(query);
			Vector tableNames = new Vector();
			Vector productIds = new Vector();
			Vector countrys = new Vector();
			Vector colLists = new Vector();
			Vector orderNoCols = new Vector();
			Vector lineNoCols = new Vector();
			Vector actions = new Vector();
			Vector numCols = new Vector();
			if(rsDm != null){
				while(rsDm.next()){
					//System.out.println(rsDm.getString("table_name")+"::"+rsDm.getString("line_no_col")+"::"+rsDm.getString("order_no_col")+"::"+rsDm.getString("col_list")+"::");
					tableNames.addElement(rsDm.getString("table_name"));
					productIds.addElement(rsDm.getString("product_id"));
					countrys.addElement(rsDm.getString("country"));
					colLists.addElement(rsDm.getString("col_list"));
					orderNoCols.addElement(rsDm.getString("order_no_col"));
					lineNoCols.addElement(rsDm.getString("line_no_col"));
					actions.addElement(rsDm.getString("action"));
					numCols.addElement("0");
				}
			}
			rsDm.close();
			// i need to figure out how many columns are contained in the colLists elements.
			for(int i = 0;i < tableNames.size();i++){
				Vector columns = new Vector();
				String tempColList = colLists.elementAt(i).toString();
				int safetycounter = 0;
				String tempColName = "";
				while(tempColList.trim().length() > 0){

					int y = 0;
					if(tempColList.indexOf(",") >= 0){
						y = tempColList.indexOf(",");
						tempColName = tempColList.substring(0,y);
						tempColList = tempColList.substring(y + 1);
					}
					else{
						tempColName = tempColList;
						tempColList = "";
					}

					columns.addElement(tempColName);
					safetycounter++;
					if(safetycounter > 100){
						tempColList = "";
					}
				}
				numCols.setElementAt("" + safetycounter,i);
				String querySelect = "select ";
				String queryInsert = "insert into " + tableNames.elementAt(i).toString() + " (" + orderNoCols.elementAt(i).toString() + ",";
				String queryInsertQuestion = "?,";
				for(int ii = 0;ii < Integer.parseInt(numCols.elementAt(i).toString());ii++){
					querySelect = querySelect + columns.elementAt(ii).toString() + ",";
					queryInsert = queryInsert + columns.elementAt(ii).toString() + ",";
					queryInsertQuestion = queryInsertQuestion + "?,";
				}
				if(tableNames.elementAt(i).toString().toLowerCase().equals("doc_line")){
					querySelect = querySelect + "doc_type,";
					queryInsert = queryInsert + "doc_type,";
					queryInsertQuestion = queryInsertQuestion + "'" + dtype + "',";

				}
				if(querySelect.endsWith(",")){
					querySelect = querySelect.substring(0,querySelect.length() - 1);
				}
				if(queryInsert.endsWith(",")){
					queryInsert = queryInsert.substring(0,queryInsert.length() - 1);
				}
				if(queryInsertQuestion.endsWith(",")){
					queryInsertQuestion = queryInsertQuestion.substring(0,queryInsertQuestion.length() - 1);
				}

				querySelect = querySelect + " from " + tableNames.elementAt(i).toString() + " where " + orderNoCols.elementAt(i).toString() + " = '" + oldOrderNo + "'";
				queryInsert = queryInsert + ") values (" + queryInsertQuestion + ")";
				//System.out.println("quoteheaderbean line 1421::"+querySelect);
				//System.out.println("quoteheaderbean line 1422::"+queryInsert);
				tempQuery = querySelect + "::" + queryInsert;
				ResultSet rsDmResults = stmt.executeQuery(querySelect);
				String tempValues;
				if(rsDmResults != null){
					while(rsDmResults.next()){
						tempValues = "";
						java.sql.PreparedStatement psInsertDm = myConn.prepareStatement(queryInsert);
						psInsertDm.setString(1,orderNo);
						for(int y = 1;y <= Integer.parseInt(numCols.elementAt(i).toString());y++){
							psInsertDm.setString((y + 1),rsDmResults.getString(y));
						}
						int rocount2 = psInsertDm.executeUpdate();
						psInsertDm.close();
					}
				}
				rsDmResults.close();
			}
			myConn.close();
		}
		catch(Exception e){
			System.out.println(" QuoteHeaderBean.copyLines");
			System.out.println(e);
			System.out.println(tempQuery);
			System.out.println(" QuoteHeaderBean.copyLines END");
		}
		finally{
			try{
				stmt.close();
				myConn.close();
				myConn.close();
				stmt.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
		return newOrderNo;
	}

	public String deleteFactura(String orderNoFactura){
		String value = "";
		try{

		}
		catch(Exception e){
			System.out.println(" QuoteHeaderBean.deleteFactura");
			System.out.println(e);
			System.out.println(" QuoteHeaderBean.deleteFActura END");
		}
		return value;
	}

	public String checkAlternate(String altNo){
		String value = "";
		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("erapid.xml");
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
			query = "select count(*) from cs_project where order_no like '" + altNo.substring(0,6) + "%'";
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("search");
			doc2.appendChild(resultList);
			Element searchresult = doc2.createElement("searchresult");
			resultList.appendChild(searchresult);

			ResultSet rs1 = stmt.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					value = rs1.getInt(1) + "";
				}
			}
			rs1.close();
			Element valueElement = doc2.createElement("value");
			valueElement.appendChild(doc2.createTextNode(value.trim() + "#"));
			searchresult.appendChild(valueElement);
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult result = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,result);
			value = writer.toString().trim();

		}
		catch(Exception e){
			System.out.println(" QuoteHeaderBean.deleteFactura");
			System.out.println(e);
			System.out.println(" QuoteHeaderBean.deleteFActura END");
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
		return value;
	}

	public String checkSFDCType(String SFDCno){
		String div = "";
		//System.out.println("1");
		Connection myConnSfdc = null;
		Statement stmtSfdc = null;
		try{
			File fXmlFile = new File("erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					this.dbSFDCServerName = "" + getTagValue("dbSFDCServerName",eElement);
					this.dbSFDCServerPort = "" + getTagValue("dbSFDCServerPort",eElement);
					this.SFDCDB = "" + getTagValue("SFDCDB",eElement);
					this.SFDCDBUsername = "" + getTagValue("SFDCDBUsername",eElement);
					this.SFDCDBPassword = "" + getTagValue("SFDCDBPassword",eElement);
				}
			}
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("search");
			doc2.appendChild(resultList);
			//System.out.println("2");
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			myConnSfdc = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbSFDCServerName + ":" + dbSFDCServerPort + "/" + SFDCDB,SFDCDBUsername,SFDCDBPassword);
			stmtSfdc = myConnSfdc.createStatement();
			stmtSfdc.executeUpdate("set ANSI_warnings off");
			String temp = "";
			//System.out.println("3select RecordTypeId from Quotes__c where name='" + SFDCno + "'");
			ResultSet rsSf0 = stmtSfdc.executeQuery("select CurrencyIsoCode from Quotes__c where name='" + SFDCno + "'");
			if(rsSf0 != null){
				while(rsSf0.next()){
					div = rsSf0.getString("CurrencyIsoCode");
					//System.out.println(temp + "::" + SFDCno);
				}
			}
			rsSf0.close();

			myConnSfdc.close();
		}
		catch(Exception e){
			System.out.println("QuoteHeaderBean.checkSFDCType");
			System.out.println(e);
			System.out.println("QuoteHeaderBean.checkSFDCType END");
		}
		finally{
			try{
				stmtSfdc.close();
				myConnSfdc.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
		return div;
	}

	public void setRepQuote(String orderNo,String repQuote){
		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("erapid.xml");
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
			int rs = stmt.executeUpdate("update cs_project set rep_quote='" + repQuote + "' where order_no='" + orderNo + "'");
			myConn.close();
		}
		catch(Exception e){
			System.out.println("quoteHeaderBean.setRepQuote");
			System.out.println(e);
			System.out.println("quoteHeaderBean.setRepQuote END");
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

	public void setRepTear(String orderNo,String repTear){
		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("erapid.xml");
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
			int rs = stmt.executeUpdate("update cs_project set rep_tear_sheet='" + repTear + "' where order_no='" + orderNo + "'");
			myConn.close();
		}
		catch(Exception e){
			System.out.println("quoteHeaderBean.setRepQuote");
			System.out.println(e);
			System.out.println("quoteHeaderBean.setRepQuote END");
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

	public String getSalesRegion(String groupCode){
		String div = "";
		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("erapid.xml");
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
			query = "select cust_shipping_no,region from cs_ge_group_codes where ccode='" + groupCode + "'";
			//System.out.println(query);
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("search");
			doc2.appendChild(resultList);
			Element searchresult = doc2.createElement("searchresult");
			resultList.appendChild(searchresult);
			String custNo = "";
			String region = "";
			ResultSet rs1 = stmt.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					custNo = rs1.getString(1);
					region = rs1.getString(2);
				}
			}
			rs1.close();
			//System.out.println(custNo+"::"+region);
			if(custNo == null){
				custNo = "";
			}
			if(region == null){
				region = "";
			}

			Element valueElement2 = doc2.createElement("region");
			valueElement2.appendChild(doc2.createTextNode(region.trim() + "#"));
			searchresult.appendChild(valueElement2);
			Element valueElement = doc2.createElement("custNo");
			valueElement.appendChild(doc2.createTextNode(custNo.trim() + "#"));
			searchresult.appendChild(valueElement);
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult result = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,result);
			div = writer.toString().trim();
			//System.out.println(div);
			stmt.close();
			myConn.close();
		}
		catch(Exception e){
			System.out.println("quoteHeaderBean.getSalesRegion");
			System.out.println(e);
			System.out.println("quoteHeaderBean.getSalesRegion END");
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
