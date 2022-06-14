package com.csgroup.general;

//import static com.sun.org.apache.xerces.internal.util.PropertyState.is;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.Writer;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

//import javax.servlet.ServletException;
//import javax.servlet.ServletOutputStream;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import org.xml.sax.InputSource;

import org.w3c.dom.*;
//import org.json.simple.JSONObject;
//import jxl.*;
//import jxl.write.*;
//import jxl.write.Number;
//import jxl.write.biff.RowsExceededException;

//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
public class TableMaint{
	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String messageUS = "";
	String messageTypeUS = "";
	String dbServerName = "";
	String dbServerPort = "";
	String erapidDB = "";
	String erapidSysDB = "";
	String erapidDBUsername = "";
	String erapidDBPassword = "";
	Vector values = new Vector();
        
        
        public String getFks(String[] prods){
            logger.debug(join(prods,","));
            String result = "<select id='fks'>";
            String lookup ="";
            try{
                File fXmlFile = new File("d:\\erapid\\erapid.xml");
                DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
                Document doc = dBuilder.parse(fXmlFile);
                doc.getDocumentElement().normalize();
                NodeList nList = doc.getElementsByTagName("instance");
                //logger.debug("2");
                for(int temp = 0;temp < nList.getLength();temp++){
                        Node nNode = nList.item(temp);
                        if(nNode.getNodeType() == Node.ELEMENT_NODE){
                                Element eElement = (Element) nNode;
                                this.dbServerName = "" + getTagValue("dbServerName",eElement);
                                this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
                                this.erapidDB = "" + getTagValue("erapidDB",eElement);
                                this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
                                this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
                                this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
                                this.messageUS = "" + getTagValue("messageUS",eElement);
                                this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
                        }
                }
                //logger.debug("3");
                Connection myConn;
                Statement stmt;

                Class.forName("net.sourceforge.jtds.jdbc.Driver");
                myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
                stmt = myConn.createStatement();

                stmt.executeUpdate("set ANSI_warnings off");
                ResultSet rs = stmt.executeQuery("SELECT * FROM cs_FkRelationships");
                
                lookup+="<select id ='productsLookup'>";
                for(String x:prods){
                    lookup += "<option value='"+ x +"'>"+x +"</option>";
                }
                lookup += "</select>";
                
                if(rs.isBeforeFirst() ){
                    while(rs.next()){
                        result += "<option value='"+ rs.getString("fkColumnName") +"'>"+rs.getString("fkTable") +"</option>";
                        if(!rs.getString("fkTable").equalsIgnoreCase("products")){
                            logger.debug(rs.getString("fkTable")+" , " +rs.getString("fkColumnName")+" , " +rs.getString("fkColumnDisplay"));  
                            lookup += getListLookup(rs.getString("fkTable"),rs.getString("fkColumnName"),rs.getString("fkColumnDisplay"));
                        }
                        
                    }
                }
                logger.debug(result);
                result+= "</select>";
                
                return result+lookup;
            }
            catch(Exception e){
                logger.debug("TableMaint.getFks");
                logger.debug(e.getMessage());
                logger.debug("TableMaint.getFks end");
                return null;
            }
            
            
        }
        
        private String getListLookup(String tableName, String ID, String display){
            String result = "<select id='" + tableName + "Lookup'>";
            try{
                File fXmlFile = new File("d:\\erapid\\erapid.xml");
                DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
                Document doc = dBuilder.parse(fXmlFile);
                doc.getDocumentElement().normalize();
                NodeList nList = doc.getElementsByTagName("instance");
                //logger.debug("2");
                for(int temp = 0;temp < nList.getLength();temp++){
                        Node nNode = nList.item(temp);
                        if(nNode.getNodeType() == Node.ELEMENT_NODE){
                                Element eElement = (Element) nNode;
                                this.dbServerName = "" + getTagValue("dbServerName",eElement);
                                this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
                                this.erapidDB = "" + getTagValue("erapidDB",eElement);
                                this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
                                this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
                                this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
                                this.messageUS = "" + getTagValue("messageUS",eElement);
                                this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
                        }
                }
                Connection myConn;
                Statement stmt;

                Class.forName("net.sourceforge.jtds.jdbc.Driver");
                myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
                stmt = myConn.createStatement();

                stmt.executeUpdate("set ANSI_warnings off");
                ResultSet rs = stmt.executeQuery("SELECT " + ID + "," + display +" FROM " + tableName);
                
                if(rs.isBeforeFirst() ){
                    while(rs.next()){
                        result += "<option value='"+ rs.getString(ID) +"'>"+rs.getString(display) +"</option>";
                        
                    }
                }
                result+= "</select>";
                
                return result;
            }
            catch(Exception e){
                logger.debug("TableMaint.getListLookup");
                logger.debug(e.getMessage());
                logger.debug("TableMaint.getListLookup end");
                return null;
            }
        }
        
        public boolean checkAdminAccess(String userID,String tableName){
            try{
                File fXmlFile = new File("d:\\erapid\\erapid.xml");
                DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
                Document doc = dBuilder.parse(fXmlFile);
                doc.getDocumentElement().normalize();
                NodeList nList = doc.getElementsByTagName("instance");
                //logger.debug("2");
                for(int temp = 0;temp < nList.getLength();temp++){
                        Node nNode = nList.item(temp);
                        if(nNode.getNodeType() == Node.ELEMENT_NODE){
                                Element eElement = (Element) nNode;
                                this.dbServerName = "" + getTagValue("dbServerName",eElement);
                                this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
                                this.erapidDB = "" + getTagValue("erapidDB",eElement);
                                this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
                                this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
                                this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
                                this.messageUS = "" + getTagValue("messageUS",eElement);
                                this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
                        }
                }
                Connection myConn;
                Statement stmt;
                Statement stmtTableInfo;

                Class.forName("net.sourceforge.jtds.jdbc.Driver");
                myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
                stmt = myConn.createStatement();
                
                String query = "SELECT * FROM cs_table_maint WHERE user_id = '"+ userID +"' AND tables LIKE '%"+ tableName +"%'";
                logger.debug("liner:"+query);
                ResultSet rs = stmt.executeQuery(query);
                if(rs.isBeforeFirst()){
                    rs.next();
                    if(rs.getString("group_id").equals("super")){
                        return true;
                    }
                    else{
                        return false;
                    }
                }
                else{
                    return false;
                }
                    
            }
            catch(Exception e){
                    logger.debug("TableMaint.checkAdminAcess");
                    logger.debug(e.getMessage());
                    logger.debug("TableMaint.checkAdminAcess end");
                    return false;
            }
        }
        
	public String getTables(String userId,String groupId){
                
        
                String result = "<select id='tables'><option></option>";
                
		try{
			File fXmlFile = new File("d:\\erapid\\erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			//logger.debug("2");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					this.dbServerName = "" + getTagValue("dbServerName",eElement);
					this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
					this.erapidDB = "" + getTagValue("erapidDB",eElement);
					this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
					this.messageUS = "" + getTagValue("messageUS",eElement);
					this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
				}
			}
			Connection myConn;
			Statement stmt;
			Statement stmtTableInfo;
                        
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
                        
			stmt.executeUpdate("set ANSI_warnings off");
			String query2 = "select tables from cs_table_maint where user_id='" + userId + "' and group_id='" + groupId + "'";
			ResultSet rs2 = stmt.executeQuery(query2);
                        
                        String[] tbls;
                        String csv = new String();
                        
                        ResultSet rsTableInfo;
                        
                        if(rs2.isBeforeFirst() ){
                            while(rs2.next()){
                                csv = rs2.getString("tables");
                                tbls = csv.split(",");
                                
                                for(String tbl:tbls){
                                    result += "<option value='"+ tbl +"'>"+ tbl + "</option>";
                                }
                                
                                csv = "";
                                
                            }
                            
                        }
                        
                        result += "</select>";
			query2 = "select tables from cs_table_maint where user_id='*' and group_id='" + groupId + "'";
			//logger.debug(query2 + "::2");
			
			stmt.close();
			myConn.close();
		}
		catch(Exception e){
			logger.debug("TableMaint.getTables");
			logger.debug(e.getMessage());
			logger.debug("TableMaint.getTables end");
		}
		return result;
	}
        
        public <T> String join(T[] array, String cement) {
            StringBuilder builder = new StringBuilder();

            if(array == null || array.length == 0) {
                return null;
            }

            for (T t : array) {
                builder.append(t).append(cement);
            }

            builder.delete(builder.length() - cement.length(), builder.length());

            return builder.toString();
        }
        
        private boolean addLog(String tableName,String description){
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
                            this.dbServerName = "" + getTagValue("dbServerName",eElement);
                            this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
                            this.erapidDB = "" + getTagValue("erapidDB",eElement);
                            this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
                            this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
                            this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
                            this.messageUS = "" + getTagValue("messageUS",eElement);
                            this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
                    }
                }
                Connection myConn;
                Statement stmt;
                
                String userID = "dyachouh";
                
                myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
                stmt = myConn.createStatement();
                description = description.replaceAll("'","");
                String query = "INSERT INTO cs_tablemaint_logs (tableName,userID,description,dateModified) VALUES('"+ tableName +"','"+ userID +"','"+ description +"',CURRENT_TIMESTAMP)";    
                logger.debug(query);
                stmt.executeUpdate(query);
                
            
                return true;
            }
            catch(Exception e){
                logger.debug("TableMaint.addLog");
                logger.debug(e.getMessage());
                logger.debug("TableMaint.addLog end");
                return false;
            }
        }
        
        public String insertTableRecord(String tableName,String values){
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
                            this.dbServerName = "" + getTagValue("dbServerName",eElement);
                            this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
                            this.erapidDB = "" + getTagValue("erapidDB",eElement);
                            this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
                            this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
                            this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
                            this.messageUS = "" + getTagValue("messageUS",eElement);
                            this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
                    }
                }
                Connection myConn;
                Statement stmt;

                myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
                stmt = myConn.createStatement();
                
                if(checkExists(tableName,values) == false){
                
                    String insertStr = "";
                    String[] setNames;
                    String[] setValues;
                    Vector<String> namesArr = new Vector<String>();
                    Vector<String> valuesArr = new Vector<String>();


                    DocumentBuilderFactory colFactory = DocumentBuilderFactory.newInstance();
                    DocumentBuilder colBuilder = dbFactory.newDocumentBuilder();
                    InputSource is = new InputSource(new StringReader(values));
                    Document colDoc = colBuilder.parse(is);
                    colDoc.getDocumentElement().normalize();

                    NodeList colList = colDoc.getChildNodes();
                    for (int i = 0; i < colList.getLength(); ++i)
                    {
                        Node rootCol = colList.item(i);
                        NodeList children = rootCol.getChildNodes();
                        if(children != null){

                            for (int x = 0; x < children.getLength(); ++x)
                            {
                                Element column = (Element) children.item(x);
                                namesArr.add(column.getTagName());
                                valuesArr.add("'"+column.getTextContent().replaceAll("'","''")+"'");

                                //updateArr.add(column.getTagName()+"="+column.getTextContent());                            
                            }
                            setNames = namesArr.toArray(new String[namesArr.size()]);
                            setValues = valuesArr.toArray(new String[valuesArr.size()]);
                            insertStr += "INSERT INTO "+ tableName +"("+ join(setNames, ",") + ") VALUES (" + join(setValues, ",") + ");";
                        }


                    }

                    int prompt = stmt.executeUpdate("set ANSI_warnings off; " + insertStr);

                    stmt.close();
                    myConn.close();

                    if(prompt>0)
                    {
                        if(addLog(tableName, insertStr)==true){
                            return "true";
                        }
                        else{
                            return "Logger System Failed.";
                        }
                    }
                    else
                    {
                        return "Error: Record not Inserted.";
                    }
                }
                else{
                    return "Can't have duplicate record!";
                }
                
            }
            catch(Exception e){
                logger.debug("TableMaint.insertTableRecord");
                logger.debug(e.getMessage());
                logger.debug("TableMaint.insertTableRecord end");
                return "false";
            }
        }
        
        public boolean checkExists(String tableName,String values){
            
            try{
                logger.debug("checkExists: "+tableName);
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
                        this.dbServerName = "" + getTagValue("dbServerName",eElement);
                        this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
                        this.erapidDB = "" + getTagValue("erapidDB",eElement);
                        this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
                        this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
                        this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
                        this.messageUS = "" + getTagValue("messageUS",eElement);
                        this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
                    }
                }
                Connection myConn;
                Statement stmt;

                myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
                stmt = myConn.createStatement();

                String[] whereStr;
                Vector<String> whereClause = new Vector<String>();

                DocumentBuilderFactory colFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder colBuilder = dbFactory.newDocumentBuilder();
                Document colDoc = colBuilder.parse((new InputSource(new ByteArrayInputStream(values.getBytes("utf-8")))));
                colDoc.getDocumentElement().normalize();

                NodeList colList = colDoc.getChildNodes();
                Node rootCol = colList.item(0);
                NodeList children = rootCol.getChildNodes();
                if(children != null){

                    for (int x = 0; x < children.getLength(); ++x)
                    {
                        Element column = (Element) children.item(x);
                        if(column.getAttribute("type").equals("pk")){
                            whereClause.add(column.getTagName() + " = '" + column.getTextContent() + "'");
                        }

                        //updateArr.add(column.getTagName()+"="+column.getTextContent());                            
                    }

                }



                whereStr = whereClause.toArray(new String[whereClause.size()]);
                String query = "SELECT TOP 1 * FROM "+tableName + " WHERE " + join(whereStr," AND ");
                logger.debug(query);
                ResultSet rs = stmt.executeQuery(query);

                if(rs.next()){
                    return true;
                }
                else{
                    return false;
                }
            }catch(Exception e){
                logger.debug("TableMaint.checkExists");
                logger.debug(e.getMessage());
                logger.debug("TableMaint.checkExists end");
                return false;
            }
        }
        
        static boolean isInt(String s)  // assuming integer is in decimal number system
        {
         for(int a=0;a<s.length();a++)
         {
            if(a==0 && s.charAt(a) == '-') continue;
            if( !Character.isDigit(s.charAt(a)) ) return false;
         }
         return true;
        }
        
        public String searchTblFilter(String tableName,String query, String multi, String isSuper){
            String result = "";
            logger.debug(multi);
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
                            this.dbServerName = "" + getTagValue("dbServerName",eElement);
                            this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
                            this.erapidDB = "" + getTagValue("erapidDB",eElement);
                            this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
                            this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
                            this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
                            this.messageUS = "" + getTagValue("messageUS",eElement);
                            this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
                    }
                }
                Connection myConn;
                Statement stmt;

                myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
                stmt = myConn.createStatement();
                
                String[] setWhere;
                
                Vector<String> colNames = new Vector<String>();
                Map<String,String> colTypes = new HashMap<String,String>();
                
                DatabaseMetaData meta = myConn.getMetaData();
                
                ResultSet rs2 = meta.getPrimaryKeys(null, null, tableName);
                Vector<String> pksVec = new Vector<String>();
                
                while (rs2.next()) {
                    String columnName = rs2.getString("COLUMN_NAME");
                    pksVec.add(columnName);
                }
                
                String[] pks = pksVec.toArray(new String[pksVec.size()]);
                String colStr = "";
                
                
                
                ResultSet rsData;
                
                ResultSetMetaData rsmd;
                
                
                if(multi.equals("0")){
                    ResultSet rs = stmt.executeQuery("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='"+ tableName +"'");
                    while(rs.next()){
                        colNames.add(rs.getString("COLUMN_NAME") +" LIKE '%"+ query + "%'");

    //                    if(Arrays.asList(pks).contains(rs.getString("COLUMN_NAME"))){
    //                        colTypes.put(rs.getString("COLUMN_NAME"),"pk");
    //                    }
    //                    else{
    //                        colTypes.put(rs.getString("COLUMN_NAME"),"");
    //                    }

                    }


                    String[] cols = colNames.toArray(new String[colNames.size()]);
                    colStr = "SELECT TOP 100 * FROM " + tableName + " WHERE " + join(cols," OR ");
                }
                else if(multi.equals("1")){
                    DocumentBuilderFactory colFactory = DocumentBuilderFactory.newInstance();
                    DocumentBuilder colBuilder = dbFactory.newDocumentBuilder();
                    Document colDoc = colBuilder.parse((new InputSource(new ByteArrayInputStream(query.getBytes("utf-8")))));
                    colDoc.getDocumentElement().normalize();

                    NodeList colList = colDoc.getChildNodes();
                    Node rootCol = colList.item(0);
                    NodeList children = rootCol.getChildNodes();
                    if(children != null){

                        for (int x = 0; x < children.getLength(); ++x)
                        {
                            Element column = (Element) children.item(x);
                            if(isInt(column.getTextContent())){
                                colNames.add(column.getTagName() +" LIKE '"+ column.getTextContent()+ "%'");
                            }
                            else{
                                colNames.add(column.getTagName() +" LIKE '%"+ column.getTextContent()+ "%'");
                            }
                        }
                        String[] cols = colNames.toArray(new String[colNames.size()]);
                        colStr = "SELECT TOP 100 * FROM " + tableName + " WHERE " + join(cols," AND ");
                    }
                }
                
                
                rsData = stmt.executeQuery(colStr);
                
                rsmd = rsData.getMetaData();
                
                if(rsData.isBeforeFirst()){
                    int columnCount = rsmd.getColumnCount();
                    while(rsData.next()){
                        result += "<tr>";
                        for(int i =1; i <= columnCount; i ++){
                            if(Arrays.asList(pks).contains(rsmd.getColumnName(i))){
                                result +="<td data-type='pk' data-colname='"+ rsmd.getColumnName(i) +"'>"+ rsData.getString(i) + "</td>";
                            }
                            else{
                                result +="<td data-colname='"+ rsmd.getColumnName(i) +"'>"+ rsData.getString(i) + "</td>";
                            }
                        }
                        result += "<td><input type='button' class='genEdit' value='Edit' /></td>";
                        if(isSuper.equals("true")){
                            result += "<td><a href='#'><img class='delRow' src='../../images/delete.png'></a></td>";                            
                        }
                        
                        result += "</tr>";
                    }
                }
                
                
                stmt.close();
                myConn.close();
                
                return result;
                
                
            }
            catch(Exception e){
                logger.debug("TableMaint.searchTblFilter");
                logger.debug(e.getMessage());
                logger.debug("TableMaint.searchTblFilter end");
                return "";
            }
        }
        
        public boolean updateTableRecord(String tableName, String values){
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
                            this.dbServerName = "" + getTagValue("dbServerName",eElement);
                            this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
                            this.erapidDB = "" + getTagValue("erapidDB",eElement);
                            this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
                            this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
                            this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
                            this.messageUS = "" + getTagValue("messageUS",eElement);
                            this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
                    }
                }
                Connection myConn;
                Statement stmt;

                myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
                stmt = myConn.createStatement();
                
                String updateStr = "";
                String[] setUpdate;
                String[] setWhere;
                
                Vector<String> updateArr = new Vector<String>();
                Vector<String> updatePkArr = new Vector<String>();
                
                
                DocumentBuilderFactory colFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder colBuilder = dbFactory.newDocumentBuilder();
                Document colDoc = colBuilder.parse((new InputSource(new ByteArrayInputStream(values.getBytes("utf-8")))));
                colDoc.getDocumentElement().normalize();
                
                NodeList colList = colDoc.getChildNodes();
                for (int i = 0; i < colList.getLength(); ++i)
                {
                    Node rootCol = colList.item(i);
                    NodeList children = rootCol.getChildNodes();
                    if(children != null){
                        updateStr += "UPDATE " + tableName + " SET ";
                        
                        for (int x = 0; x < children.getLength(); ++x)
                        {
                            Element column = (Element) children.item(x);
                            
                            if( column.getAttribute("type").equals("pk"))
                            {
                                updatePkArr.add(column.getTagName()+"='"+column.getTextContent()+"'");
                            }
                            else{                                
                                updateArr.add(column.getTagName()+"='"+column.getTextContent()+"'");
                            }
                            //updateArr.add(column.getTagName()+"="+column.getTextContent());                            
                        }
                        setUpdate = updateArr.toArray(new String[updateArr.size()]);
                        setWhere = updatePkArr.toArray(new String[updatePkArr.size()]);
                        updateStr += join(setUpdate, ",") + " WHERE " + join(setWhere, " AND ") + ";";
                    }
                   
                    
                }
                logger.debug(updateStr);
                
                int prompt = stmt.executeUpdate("set ANSI_warnings off; " + updateStr);
                
                stmt.close();
                myConn.close();
                
                if(prompt>0)
                {
                    if(addLog(tableName, updateStr.replaceAll("'",""))==true){
                        return true;
                    }
                    else{
                        return false;
                    }
                }
                else
                {
                    return false;
                }
                
                
            }
            catch(Exception e){
                logger.debug("TableMaint.updateTableRecord");
                logger.debug(e.getMessage());
                logger.debug("TableMaint.updateTableRecord end");
                return false;
            }
            
        }
        
        private String capitalize(String line)
        {
          return Character.toUpperCase(line.charAt(0)) + line.substring(1);
        }
        
        public String writeExcelFile(String tableName,String browserType){
            String xml = "<?xml version='1.0' encoding ='UTF-8' ?><all>";
            String obj = tableName+"~";
            logger.debug("writeExcelFile java");
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
                            this.dbServerName = "" + getTagValue("dbServerName",eElement);
                            this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
                            this.erapidDB = "" + getTagValue("erapidDB",eElement);
                            this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
                            this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
                            this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
                            this.messageUS = "" + getTagValue("messageUS",eElement);
                            this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
                    }
                }
                Connection myConn;
                Statement stmt;

                myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
                stmt = myConn.createStatement();
                stmt.executeUpdate("set ANSI_warnings off");
                
                ResultSet rs1 = stmt.executeQuery("SELECT * FROM "+tableName);
                ResultSetMetaData rsmd = rs1.getMetaData();
                
                
                int columnCount = rsmd.getColumnCount();
                
                Date date = new Date();
                String fileName = tableName+(date.getTime()*1000);
                
                try (PrintWriter writer = new PrintWriter("////lebhq-erusdev//shared//"+fileName+".xml", "UTF-8")) {
                    writer.print("<?xml version='1.0' encoding ='UTF-8' ?><all>");
//                Writer writer = new BufferedWriter(new OutputStreamWriter(
//                new FileOutputStream("////lebhq-erusdev/transfer/tableBackup/report.tsv"), "utf-8"));
                    
                    Vector<String> cols = new Vector<String>();
                    String[] colsArr;
                    Vector<String> data = new Vector<String>();
                    String[] dataArr;
                    
                    String columnName = "";
                    
                    
                    if(rs1.isBeforeFirst()){
//                    xml += "<row>";
//                    for (int i = 1; i < columnCount + 1; i++ ) {
//                        cols.add(capitalize(rsmd.getColumnName(i)));
//                        logger.debug("Column:"+rsmd.getColumnName(i));
//                        columnName = rsmd.getColumnName(i);
//                        xml += "<"+ columnName +">"+columnName +  "</"+ columnName +">";
//                    }
//                    
//                    xml += "</row>";
                        
                        //xml +="</columns><data>";
                        String val = "";
                        
                        while(rs1.next()){
                            
                            writer.print("<row>");
                            for (int x = 1; x <= columnCount; x++ ) {
                                
                                if(rs1.getString(x) == null || rs1.getString(x).equals("")){
                                    val = " ";
                                }
                                else{
                                    val = rs1.getString(x).replaceAll("\\r\\n|\\r|\\n", " ").replaceAll("\\&","&amp;");
                                }
                                
                                writer.print("<"+ rsmd.getColumnName(x) +">" + val + "</"+ rsmd.getColumnName(x) +">");
                            }
                            
                            writer.print("</row>");
                            
                        }
                        
                    }
                    writer.print("</all>");                    
                }
                
                stmt.close();
                myConn.close();
                
                return fileName+".xml";
//                if(browserType.toUpperCase().indexOf("FIREFOX")>0||browserType.toUpperCase().indexOf("CHROME")>0||browserType.toUpperCase().indexOf("SAFARI")>0){
//                    return "http://lebhq-erusdev/erapid/shared/"+fileName+".xml";
//                }
//                else{
//                    return "URL=http:\\\\lebhq-erusdev\\erapid\\shared\\"+fileName+".xml";
//                }
                
                
            }
            catch(Exception e){
                logger.debug("TableMaint.writeExcelFile");
                logger.debug(e.getMessage());
                logger.debug("TableMaint.writeExcelFile end");
                return "";
            }
        }
        
        public String transferTableToExcel(String tableName){
            String xml = "";
            String obj = tableName+"~";
            
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
                            this.dbServerName = "" + getTagValue("dbServerName",eElement);
                            this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
                            this.erapidDB = "" + getTagValue("erapidDB",eElement);
                            this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
                            this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
                            this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
                            this.messageUS = "" + getTagValue("messageUS",eElement);
                            this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
                    }
                }
                Connection myConn;
                Statement stmt;

                myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
                stmt = myConn.createStatement();
                stmt.executeUpdate("set ANSI_warnings off");
                
                ResultSet rs1 = stmt.executeQuery("SELECT * FROM "+tableName);
                ResultSetMetaData rsmd = rs1.getMetaData();
                
                //xml="<?xml version=\\\"1.0\\\" encoding=\\\"utf-8\\\"?><table><columns>";
                
                int columnCount = rsmd.getColumnCount();
                
                
                Vector<String> cols = new Vector<String>();
                String[] colsArr;
                Vector<String> data = new Vector<String>();
                String[] dataArr;
                
                if(rs1.isBeforeFirst()){
                    
                    for (int i = 1; i < columnCount + 1; i++ ) {
                        //xml += "<column>"+rsmd.getColumnName(i).substring(0, 1).toUpperCase() +  "</column>";
                        cols.add(capitalize(rsmd.getColumnName(i)));
                    }
                    colsArr = cols.toArray(new String[cols.size()]);
                    obj += join(colsArr,"   ") + "~";
                    
                    
                    //xml +="</columns><data>";
                    String val = "";
                    
                    Integer colCount = new Integer(columnCount);
                    
                    logger.debug(null!= colCount? colCount.toString(): "0");
                    while(rs1.next()){
                        //xml += "<row>";
                        for (int x = 1; x <= columnCount; x++ ) {
                            //xml += "<"+ rsmd.getColumnName(x) +">" + rs1.getString(x) + "</"+ rsmd.getColumnName(x) +">";
                            
                            logger.debug(rs1.getString(x));
                            if(rs1.getString(x) == null || rs1.getString(x).equals("")){
                                val = "";
                            }
                            else{
//                                if(rsmd.getColumnTypeName(x).equals("varchar")){
//                                    val = rs1.getString(x).replaceAll("\\r\\n|\\r|\\n", " ");
//                                }
//                                else{
                                    val = rs1.getString(x).replaceAll("\\r\\n|\\r|\\n", " ");
                                //}
                            }
                            data.add(val);
                        }
                        dataArr = data.toArray(new String[data.size()]);
                        obj += join(dataArr,"\\t") + "~";
                        
                        data.clear();
                        //xml += "</row>";
                    }
                    
                    //xml+= "</data></table>";
                }
                
                stmt.close();
                myConn.close();
                return obj;
            }
            catch(Exception e){
                logger.debug("TableMaint.transferTableToExcel");
                logger.debug(e.getMessage());
                logger.debug("TableMaint.transferTableToExcel end");
                return obj;
            }
        }
        
        private boolean checkExcelUploaded(String tableName){
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
                            this.dbServerName = "" + getTagValue("dbServerName",eElement);
                            this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
                            this.erapidDB = "" + getTagValue("erapidDB",eElement);
                            this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
                            this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
                            this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
                            this.messageUS = "" + getTagValue("messageUS",eElement);
                            this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
                    }
                }
                Connection myConn;
                Statement stmt;
                
                myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
                stmt = myConn.createStatement();
                stmt.executeUpdate("set ANSI_warnings off");
                
                String query = "SELECT maintLogID FROM cs_tablemaint_logs WHERE tableName = '"+tableName+"' AND CAST(dateModified as DATE) = CAST(CURRENT_TIMESTAMP as DATE)";
                
                ResultSet rs= stmt.executeQuery(query);
                
                if(rs.isBeforeFirst()){
                    return true;
                }
                else{
                    return false;
                }
             }
             catch(Exception e){
                logger.debug("TableMaint.checkExcelUploaded");
                logger.debug(e.getMessage());
                logger.debug("TableMaint.checkExcelUploaded end");
                return false;
             }
        }
        
        public String getHTMLTableRows(String tableName,String[] prods, String userID){
            String result = "";
            String br = "";
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
                            this.dbServerName = "" + getTagValue("dbServerName",eElement);
                            this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
                            this.erapidDB = "" + getTagValue("erapidDB",eElement);
                            this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
                            this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
                            this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
                            this.messageUS = "" + getTagValue("messageUS",eElement);
                            this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
                    }
                }
                Connection myConn;
                Statement stmt;
                Statement stmt2;
                boolean isSuper = false;
                boolean excelUploaded = true;
                
                myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
                stmt = myConn.createStatement();
                stmt2 = myConn.createStatement();
                stmt.executeUpdate("set ANSI_warnings off");
                
                if(checkAdminAccess(userID,tableName) == true){
                    isSuper = true;
                }
                
                if(checkExcelUploaded(tableName) == false){
                    excelUploaded = false;
                }
                
                ResultSet rsCols = stmt.executeQuery("select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='"+ tableName +"'");
                boolean hasProdID = false;
                Map<String,String> charLimit = new HashMap<String,String>();
                
                while (rsCols.next()) {
                    charLimit.put(rsCols.getString("COLUMN_NAME"),rsCols.getString("character_maximum_length"));
                    if(rsCols.getString("COLUMN_NAME") == "Product_Id"){
                        hasProdID = true;
                    }
                    
                }
                
                String query = "SELECT TOP 100 * FROM "+tableName;
                String queryCount = "SELECT COUNT(*) as cnt FROM "+tableName;
                
                if(hasProdID == true){
                    // Use UserSession.java to get productIDs                     
                    query += " WHERE Product_Id IN("+ join(prods,",") +")";
                    queryCount += " WHERE Product_Id IN("+ join(prods,",") +")";
                }
                int rowCount = 0;
                ResultSet rsCount = stmt2.executeQuery(queryCount);
                
                ResultSet rs1 = stmt.executeQuery(query);
                
                rsCount.next();
                rowCount = rsCount.getInt("cnt");
                rsCount.close();
                
                
                ResultSetMetaData rsmd = rs1.getMetaData();
                
                
                ResultSet rs2 = null;
                
                DatabaseMetaData meta = myConn.getMetaData();
                rs2 = meta.getPrimaryKeys(null, null, tableName);
                
                Vector<String> pksVec = new Vector<String>();
                while (rs2.next()) {
                    String columnName = rs2.getString("COLUMN_NAME");
                    pksVec.add(columnName);
                }
                
                
                String[] pks = pksVec.toArray(new String[pksVec.size()]);
                
                if(rs1.isBeforeFirst()){
                    int columnCount = rsmd.getColumnCount();
                    result += "<table id='newtbl'>";
                    
                    result += "<thead><tr>";
                    
                    
                    logger.debug(new Integer(charLimit.size()).toString());
                    for (int x = 1; x < columnCount + 1; x++ ) {
                        
                        result += "<td class='";
                        if(charLimit.size() > 6 && (charLimit.get(rsmd.getColumnName(x)) != null)){
                            if(Integer.parseInt(charLimit.get(rsmd.getColumnName(x))) > 255 && Arrays.asList(pks).contains(rsmd.getColumnName(x))){
                                result += "pk longCol";
                            }
                            else if(Integer.parseInt(charLimit.get(rsmd.getColumnName(x))) <= 255 && Arrays.asList(pks).contains(rsmd.getColumnName(x))){
                                result += "pk";
                            }
                            else if(Integer.parseInt(charLimit.get(rsmd.getColumnName(x))) >= 255 && Arrays.asList(pks).contains(rsmd.getColumnName(x)) == false){
                                result += "longCol";
                            }
                        }
                        else{
                            if(Arrays.asList(pks).contains(rsmd.getColumnName(x))){
                                result += "pk";
                            }
                        }
                        
                        result +="' style='font-weight:bold'>"+ rsmd.getColumnName(x).substring(0, 1).toUpperCase() + rsmd.getColumnName(x).substring(1) +"</td>";
                    }
                    
                    result +="<td class='notEdit' style='font-weight:bold;vertical-align:bottom'>Edit</td>";
                    if(isSuper == true){
                        result +="<td class='notEdit' style='font-weight:bold;vertical-align:bottom'>Delete</td>";
                    }
                    result +="</tr></thead><tbody>";
                    // The column count starts from 1
                    while(rs1.next()){
                        result +="<tr>";
                        for (int i = 1; i < columnCount + 1; i++ ) {
                            if(Arrays.asList(pks).contains(rsmd.getColumnName(i))){
                                result +="<td data-type='pk' data-colname='"+ rsmd.getColumnName(i) +"'>"+ rs1.getString(i) + "</td>";
                            }
                            else{
                                result +="<td data-colname='"+ rsmd.getColumnName(i) +"'>"+ rs1.getString(i) + "</td>";
                            }
//                            }
//                            else{
//                                result +="<span style=\"padding-right:5px;border:1px solid black\">"+ rs1.getString(i) + "</span>";                                
//                            }
                        }
                        result +="<td><a href='#' class='genEdit'>Edit</a></td>";
                        if(isSuper == true){
                            result +="<td><a href='#'><img class='delRow' src='../../images/delete.png' /></a></td>";
                        }
                        
                        result +="</tr>";
                    }
                    
                    result+="</tbody><tfoot><tr></tr></tfoot></table>";
                    
                    br +="<?xml version='1.0' encoding='UTF-8'?><instance><webhtml>" +result;
                    br +="</webhtml><colcount>" + columnCount;
                    br +="</colcount><rowcount>" + rowCount;
                    br +="</rowcount><issuper>" + isSuper;
                    br +="</issuper><checkupload>" + excelUploaded;
                    br += "</checkupload></instance>";
                    
                }
                rs1.close();
                stmt.close();
                myConn.close();

                return br;
            }
            catch(Exception e){
                logger.debug("TableMaint.getHTMLTableRows");
                logger.debug(e.getMessage());
                logger.debug("TableMaint.getHTMLTableRows end");
                return br;
            }
            
            //obj.put("Html",result);
        }
        
        public boolean deleteEntry(String tableName,String data){
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
                            this.dbServerName = "" + getTagValue("dbServerName",eElement);
                            this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
                            this.erapidDB = "" + getTagValue("erapidDB",eElement);
                            this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
                            this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
                            this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
                            this.messageUS = "" + getTagValue("messageUS",eElement);
                            this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
                    }
                }
                Connection myConn;
                Statement stmt;
                CallableStatement cs = null;
                
                myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
                stmt = myConn.createStatement();
                logger.debug("data:"+data);
                DocumentBuilderFactory colFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder colBuilder = dbFactory.newDocumentBuilder();
                InputSource is = new InputSource(new StringReader(data));
                Document colDoc = colBuilder.parse(is);
                colDoc.getDocumentElement().normalize();
                
                Vector<String> cols = new Vector<String>();
                
                String deleteQuery = "DELETE FROM "+tableName + " ";
                String[] colsArr;
                
                NodeList docList = colDoc.getChildNodes();

                for(int x = 0; x < docList.getLength(); ++x){
                    Node rootCol = docList.item(x);
                    NodeList children = rootCol.getChildNodes();
                    for(int i=0;i < children.getLength(); ++i){
                        Element column = (Element) children.item(i);
                        logger.debug(column.getTextContent());
                        cols.add(column.getAttribute("colname")+ " = '"+ column.getTextContent() + "'");
                    }
                }
                
                colsArr = cols.toArray(new String[cols.size()]);
                
                deleteQuery += "WHERE " + join(colsArr," AND ");
                
                
                int prompt = stmt.executeUpdate(deleteQuery);
                if(prompt > 0){
                    return true;
                }
                else{
                    return false;
                }
            }
            catch(Exception e){
                logger.debug("TableMaint.deleteEntry");
                logger.debug(e.getMessage());
                logger.debug("TableMaint.deleteEntry end");
                return false;
            }

        }

        public String uploadExcelFile(String tableName,String file){
            Writer writer = null;
            logger.debug("tester");
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
                            this.dbServerName = "" + getTagValue("dbServerName",eElement);
                            this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
                            this.erapidDB = "" + getTagValue("erapidDB",eElement);
                            this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
                            this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
                            this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
                            this.messageUS = "" + getTagValue("messageUS",eElement);
                            this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
                    }
                }
                Connection myConn;
                Statement stmt;
                CallableStatement cs = null;
                
                myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
                stmt = myConn.createStatement();
                
                String insertStr = "";
                Reader f = new FileReader(file);
                
                File newFile = new File(file);
                String fileName = newFile.getName();
                
                DocumentBuilderFactory colFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder colBuilder = colFactory.newDocumentBuilder();
                InputSource is = new InputSource(f);
                Document colDoc = colBuilder.parse(is);
                
                String csvTblName = fileName;
                
                String[] columnHeaders = null;
                
                Vector<String> cols = new Vector<String>();
                Vector<String> data = new Vector<String>();
                
                colDoc.getDocumentElement().normalize();
                
                NodeList docList = colDoc.getChildNodes();

                Node rootCol = docList.item(0);
                NodeList top = rootCol.getChildNodes();
                
                for(int i=0;i < top.getLength(); i++){
                    NodeList children = top.item(i).getChildNodes();
                    for(int y=0;y < children.getLength(); y++){
                        if(children.item(y).getNodeType() == 1){
                            Element column = (Element) children.item(y);
                            
                            cols.add(column.getTagName().toLowerCase());
                            
                            String txtCol = column.getTextContent().trim();
                            txtCol = txtCol.replaceAll("\n", "").replaceAll("\r", "").replaceAll("'", "''").replaceAll("&amp;", "&").replaceAll("\"","&quot;").trim();
                            data.add("'"+txtCol+"'");
                        }
                        
                        
                    }
                    
                    if(children.item(i).getNodeType() == 1){
                        String[] dataStr = data.toArray(new String[data.size()]);
                        data.clear();

                        columnHeaders = cols.toArray(new String[cols.size()]);

                        cols.clear();

                        insertStr += "INSERT INTO "+ tableName + "(" + join(columnHeaders,",") + ")" + " VALUES("+ join(dataStr,",")+");\n";
                    }
                }
                
                
                
                
//		while ((line = br.readLine()) != null) {
//		        // use comma as separator
//                    if(counter == 1){
//                        columnHeaders = line;
//                    }
//                    else if(counter >= 2){
//                        String[] cols = line.split("\\t");
//                        String[] colsStr = new String[cols.length];
//
//                        for(int x=0; x < cols.length; x ++){
//                            if(!cols[x].isEmpty()){
//                                
//                                cols[x] = cols[x].trim().replace("\n", "").replace("\r", "");
//                                cols[x] = cols[x].replaceAll(",", "&#44;").replaceAll("'", "''");
//                                colsStr[x] =  "'"+ cols[x] +"'";
//                                logger.debug(cols[x]);
//                            }
//                        }
//                        insertStr += "INSERT INTO "+tableName + " ("+columnHeaders+") VALUES("+ join(colsStr,",") +");\n";
//                        logger.debug(join(colsStr,","));
//                    }
//                    else if(counter == 0){
//                        String[] cols = line.split(",");
//                        csvTblName = cols[0];
//                    }
//                    counter ++;
//		}
                
                
                if(csvTblName.startsWith(tableName)){
                    ResultSet rs = stmt.executeQuery("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='"+ tableName +"'");
                    int counterCols = 0;
                    
                    boolean correctCols = true;
                    
                    if(rs.isBeforeFirst()){
                        while(rs.next()){
                            if(!rs.getString("COLUMN_NAME").equalsIgnoreCase(columnHeaders[counterCols])){
                                correctCols = false;
                            }
                            counterCols ++;
                        }
                    }
//                String backup = "{call spTruncateAndBackupTbl(?)}";
//                
//                cs = myConn.prepareCall(backup);
//                cs.setString("tableName", tableName);
                    
                    if(correctCols){
                        Date date = new Date();
                        String fName = "excelupload_"+ tableName +"_"+ (date.getTime()/1000) +".sql";

                        writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("////lebhq-erusdev/transfer/tableBackup/sqlFiles/"+ fName), "utf-8"));

                        writer.write("USE csedev;\n");
                        writer.write("BEGIN TRY\n");
                        writer.write("BEGIN TRANSACTION\n");
                        writer.write(insertStr);
                        writer.write("COMMIT TRANSACTION\n");
                        writer.write("END TRY\n");
                        writer.write("BEGIN CATCH\n");
                        writer.write("ROLLBACK TRANSACTION;\n");

                        writer.write("DECLARE @ErrorNumber INT = ERROR_NUMBER();\n");
                        writer.write("DECLARE @ErrorLine INT = ERROR_LINE();\n");
                        writer.write("DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();\n");
                        writer.write("DECLARE @ErrorSeverity INT = ERROR_SEVERITY();\n");
                        writer.write("DECLARE @ErrorState INT = ERROR_STATE();\n");
                        writer.write("DECLARE @tableHTML NVARCHAR(MAX);\n");
                        writer.write("DECLARE @cmdShellCopy VARCHAR(200);\n");

                        writer.write("RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);\n");
                        writer.write("SET @tableHTML =" +"N'file:\\\\lebhq-erusdev\\transfer\\tableBackup\\sqlFiles_Backup\\"+ fName +" <br /><table><tr><th>Error Number</th><th>Error Line</th>" +
                        "<th>Message</th><th>Severity</th><th>State</th>" +
                        "</tr>" +
                        "<tr><td>'+ CONVERT(VARCHAR(5),@ErrorNumber) +'</td><td>'+ CONVERT(VARCHAR(15),@ErrorLine) +'</td>" +
                        "<td>'+ @ErrorMessage +'</td><td>'+ CONVERT(VARCHAR(max),@ErrorSeverity) +'</td><td>'+ CONVERT(VARCHAR(50),@ErrorState) +'</td>" +
                        "</tr>" +
                        "</table>';\n" +
                        "EXEC msdb.dbo.sp_send_dbmail @recipients='dyachouh@c-sgroup.com',\n" +
                        "@subject = 'Excel Upload Error for file:" + fName + "',\n" +
                        "@body = @tableHTML,\n" +
                        "@profile_name = 'newProfile',\n" +
                        "@body_format = 'HTML';\n");
                        writer.write("SET @cmdShellCopy = 'copy \\\\lebhq-erusdev\\transfer\\tableBackup\\sqlFiles\\"+ fName +" \\\\lebhq-erusdev\\transfer\\tableBackup\\sqlFiles_Backup\\"+ fName +"';\n");
                        writer.write("EXEC xp_cmdshell @cmdShellCopy;\n");
                        writer.write("END CATCH;\n");
                        writer.flush();
                        writer.close();

                        addLog(tableName, "Excel File Uploaded");

                        return "Upload completed successfully!";
                    }
                    else{
                        return "Error: The columns in the excel file do not match the columns in the Database Table. Please make sure the column criteria is correct before re-uploading.";
                    }
                }
                else{
                    return "Error: The table doesn't match the area its being uploaded to.";
                }
//                int success = stmt.executeUpdate("set ANSI_warnings off; "+insertStr);
//                if(success > 0){
//                    return true;
//                }
//                else{
//                    return false;
//                }
            }
            catch(Exception e){
                logger.debug("TableMaint.uploadExcelFile");
                logger.debug(e.getMessage());
                logger.debug("TableMaint.uploadExcelFile end");
                return "false";
            }

        }
        
//        public void downloadCSV(HttpServletResponse resp) throws ServletException, IOException{
//            try{
//                File fXmlFile = new File("d:\\erapid\\erapid.xml");
//                DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
//                DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
//                Document doc = dBuilder.parse(fXmlFile);
//                doc.getDocumentElement().normalize();
//                NodeList nList = doc.getElementsByTagName("instance");
//                for(int temp = 0;temp < nList.getLength();temp++){
//                    Node nNode = nList.item(temp);
//                    if(nNode.getNodeType() == Node.ELEMENT_NODE){
//                            //logger.debug("2.2");
//                            Element eElement = (Element) nNode;
//                            this.dbServerName = "" + getTagValue("dbServerName",eElement);
//                            this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
//                            this.erapidDB = "" + getTagValue("erapidDB",eElement);
//                            //logger.debug("2.4");
//                            this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
//                            this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
//                            this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
//                            //logger.debug("2.6");
//                            this.messageUS = "" + getTagValue("messageUS",eElement);
//                            this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
//                            //logger.debug("2.8");
//                    }
//                }
//                Connection myConn;
//                Statement stmt;
//
//                myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
//                stmt = myConn.createStatement();
//                stmt.executeUpdate("set ANSI_warnings off");
//                
//                WritableWorkbook workbook = Workbook.createWorkbook(new File("output.xls"));
//                WritableSheet sheet = workbook.createSheet("First Sheet", 0);
//                Label label = new Label(0, 2, "A label record"); 
//                sheet.addCell(label); 
//                workbook.close();
//            }
//            catch(Exception e){
//                logger.debug("TableMaint.downloadCSV");
//                logger.debug(e);
//                logger.debug("TableMaint.downloadCSV end");
//            }
//        }

	

	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}
}
