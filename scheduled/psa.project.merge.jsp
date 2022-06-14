<html>
	<head>
		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body>
	<center>
		<table>
			<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.math.*" import="java.io.*" import="java.net.*" errorPage="error.jsp" %>
			<%@ include file="../db_con_psa.jsp"%>
			<%

			String dir_path="\\\\"+"lebhq-psa.c-sgroup.com\\project_merge";
				  CallableStatement cs = myConn_psa.prepareCall("{call dba.sp_merge_projects(?,?)}");
				   String s1="";String s2="";String final_string="";
				  File file = new File(dir_path+"\\project_merge.txt");
				 out.println(file.length()+"<br>");
			if(file.length()>10){
							try {
								   BufferedReader in = new BufferedReader(new FileReader(dir_path+"\\project_merge.txt"));
								   String str;
								   while ((str = in.readLine()) != null) {
											int nt=str.indexOf(",");
											if (nt >=0 ){
											   s1=str.substring(0,nt);
											   s2=str.substring(nt+1,str.length());
											   if(s1.length()==10&s2.length()==10){
											  cs.setString(1,s1.trim());
											   cs.setString(2,s2.trim());
											  cs.execute();
											   final_string=final_string+str+"---Merged\n";
											   }else{
												final_string=final_string+str+"---Not Merged\n";
											   }
											 out.println(str+"1st part"+s1.length()+"2nd part"+s2.length()+"done"+"<br>");
											}
								   }
								   in.close();
							    } catch (IOException e) {
							    }

								// sending the output to text file
								try {
									java.util.Date uDate = new java.util.Date(); // Right now
									Format formatter = new SimpleDateFormat("yyyyMMdd");
									String tdate=formatter.format(uDate);
								   BufferedWriter out1 = new BufferedWriter(new FileWriter(dir_path+"\\merged_history\\"+tdate+".txt"));
									final_string=final_string+"\r\n"+"Projects merged on::"+uDate;
								   out1.write(final_string);
								   out1.close();
								   BufferedWriter out2 = new BufferedWriter(new FileWriter(dir_path+"\\project_merge.txt"));
								   out2.write("\n");
								   out2.close();

							    } catch (IOException e) {
							    }
								cs.close();
								myConn_psa.close();
			}

			// Getting data from PSA done
			%>
			</body>
			</html>







			</body>
			</html>
