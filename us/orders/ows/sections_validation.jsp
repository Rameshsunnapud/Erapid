<%

boolean singleSection=false;
String errorMessage="";
String section_infox="";
String numSections2="";
String section_groupx="";


if(order_no != null && ! order_no.equals("null")){

	ResultSet rsSections2x=stmt.executeQuery("select section_info,sections,section_group from cs_quote_sections where order_no='"+order_no+"'");
	if(rsSections2x!= null){
		while(rsSections2x.next()){
			section_infox=rsSections2x.getString("section_info");
			numSections2=rsSections2x.getString("sections");
			section_groupx=rsSections2x.getString("section_group");
		}
	}
	rsSections2x.close();

	if(section_infox == null){
		section_infox="";
	}
	if(numSections2==null){
		numSections2="";
	}
	if(section_groupx==null){
		section_groupx="";
	}


	if(numSections2==null||numSections2.trim().length()==0 || numSections2.trim().equals("0") ){
		sectionsGood=true;
	}
	else{
		if(section_infox.trim().length()<1){
			sectionsGood=false;
			errorMessage=errorMessage+"Section names not filled out<BR>";
		}
		if(section_groupx.trim().length()<1){
			sectionsGood=false;
			errorMessage=errorMessage+"Lines not assigned to sections<BR>";
		}
		for(int secNum=1; secNum<= Integer.parseInt(numSections2); secNum++){
			String tempSecName="=s"+secNum+";";
			int position=section_groupx.indexOf(tempSecName);
			if(position<1){
				sectionsGood=false;
				errorMessage=errorMessage+"Section "+secNum+" has no lines assigned to it<BR>";
			}
		}
		Vector lineNos=new Vector();
		ResultSet rsLineNos=stmt.executeQuery("select doc_line from doc_line where doc_number='"+order_no+"'");
		if(rsLineNos != null){
			while(rsLineNos.next()){
				lineNos.addElement(rsLineNos.getString(1));
			}
		}
		rsLineNos.close();
		if(section_groupx.trim().length()>0){
			for (int e=0;e<lineNos.size(); e++){
				int tempIndex=section_groupx.indexOf(";"+lineNos.elementAt(e).toString()+"=");
				//out.println(tempIndex+"::1<BR>");
				if(tempIndex<0){
					tempIndex=section_groupx.substring(0,section_groupx.indexOf(";")).indexOf(lineNos.elementAt(e).toString()+"=");
					//out.println(tempIndex+"::2<BR>");
					if(tempIndex<0){
						//out.println("HERE");
						sectionsGood=false;
						errorMessage=errorMessage+"Line  "+lineNos.elementAt(e).toString()+" is not assigned to a section<BR>";
						//out.println("HERE");
						if(Integer.parseInt(numSections2)==1){
								//out.println(section_groupx+"<BR>");
								section_groupx=section_groupx+lineNos.elementAt(e).toString()+"=s1;";
								//out.println(section_groupx+"after<BR>");
								singleSection=true;
						}
					}

				}
			}
			String secTemp=section_groupx;
			int safety=0;
			Vector lineNos2=new Vector();
			while(secTemp.length()>0&&safety<100){
				String tempSection=secTemp.substring(0,secTemp.indexOf(";"));
				tempSection=tempSection.substring(0,tempSection.indexOf("="));
				lineNos2.addElement(tempSection);
				if(secTemp.length()>secTemp.indexOf(";")){
					secTemp=secTemp.substring(secTemp.indexOf(";")+1);
				}
				else{
					secTemp="";
				}
				//out.println(tempSection+"::<BR>"+secTemp+"::<BR><BR>");
				safety++;
			}
			for(int e=0; e<lineNos2.size(); e++){
				boolean matchFound=false;
				for(int ee=0; ee<lineNos.size(); ee++){
					if(lineNos2.elementAt(e).toString().equals(lineNos.elementAt(ee).toString())){
						matchFound=true;
					}
				}
				if(!matchFound){
					sectionsGood=false;
					errorMessage=errorMessage+"Section Info includes deleted line number "+lineNos2.elementAt(e).toString()+" <BR>";
					String removeSec=lineNos2.elementAt(e).toString()+"=s1;";
					//out.println("::"+section_groupx.indexOf(";"+removeSec)+"::"+removeSec+"::HERE<BR>");
					if(Integer.parseInt(numSections2)==1){
						if(section_groupx.substring(0,removeSec.length()+1).indexOf(removeSec)>=0){
							//out.println("start of string");
							//out.println(section_groupx+"<BR>");
							section_groupx=section_groupx.substring(section_groupx.indexOf(removeSec)+removeSec.length());
							//out.println(section_groupx+"after<BR>");
							singleSection=true;
						}
						else if(section_groupx.indexOf(";"+removeSec)>=0){
							//out.println("middle of string<BR>");
							//out.println(section_groupx+"<BR>");
							section_groupx=section_groupx.substring(0,section_groupx.indexOf(";"+removeSec))+section_groupx.substring(section_groupx.indexOf(";"+removeSec)+removeSec.length());
							//out.println(section_groupx+"after<BR>");
							singleSection=true;
						}
					}
				}
			}



		}

	}

	if(!sectionsGood){
		//out.println("HERE2");
		if(Integer.parseInt(numSections2)==1){
			//out.println("about to fix single section"+section_groupx+"<BR>");
			try{
				java.sql.PreparedStatement update_sections = myConn.prepareStatement("UPDATE cs_quote_sections set section_group= ? where order_no= ? ");
				update_sections.setString(1,section_groupx);
				update_sections.setString(2,order_no);;
				int roCount=update_sections.executeUpdate();
				//out.println("updateFinished");
				sectionsGood=true;
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with updating cs_quote_sections table"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
			myConn.commit();
		}
		else{
			out.println("<font color='red' ><b>Please Fix the following errors before you continue::<BR> "+errorMessage+"</b><BR>");
		}
	}

}


%>