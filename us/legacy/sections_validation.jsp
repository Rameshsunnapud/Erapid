<%
	boolean sectionsGood=true;
	String errorMessage="";
	String section_infox="";
	String numSections="";
	String section_groupx="";
	String overagex="";
	String setup_costx="";
	String handling_costx="";
	String freight_costx="";
	String sec_overage="";
	String sec_setup_cost="";
	String sec_handling_cost="";
	String sec_freight_cost="";	
	String sec_overage_total="";
	String sec_setup_cost_total="";
	String sec_handling_cost_total="";
	String sec_freight_cost_total="";	
	if(q_no != null && ! q_no.equals("null")){
		ResultSet rsProject=stmt.executeQuery("select overage, setup_cost, handling_cost, freight_cost from cs_project where order_no='"+q_no+"'");
		if(rsProject != null){
			while(rsProject.next()){
				overagex=rsProject.getString("overage");
				setup_costx=rsProject.getString("setup_cost");
				handling_costx=rsProject.getString("handling_cost");
				freight_costx=rsProject.getString("freight_cost");
			}
		}
		rsProject.close();
		ResultSet rsSections=stmt.executeQuery("select section_info,sections,section_group,overage, setup_cost, handling_cost, freight_cost from cs_quote_sections where order_no='"+q_no+"'");
		if(rsSections != null){
			while(rsSections.next()){
				section_infox=rsSections.getString("section_info");
				numSections=rsSections.getString("sections");
				section_groupx=rsSections.getString("section_group");
				sec_overage=rsSections.getString("overage");
				sec_setup_cost=rsSections.getString("setup_cost");
				sec_handling_cost=rsSections.getString("handling_cost");
				sec_freight_cost=rsSections.getString("freight_cost");				
			}
		}
		rsSections.close();
		
		
		if(sec_overage != null){
			double costx=0;
			while(sec_overage.trim().length()>0){
				int start=sec_overage.indexOf(";");
				if(start>=0){
					String tempCost=sec_overage.substring(0,start);
					tempCost=tempCost.substring(tempCost.indexOf("=")+1);
					if(tempCost.trim().length()>0){
						costx=costx+new Double(tempCost).doubleValue();
					}
					sec_overage=sec_overage.substring(start+1);
					//out.println(tempCost+"::<BR>"+sec_freight_cost+"::<BR>");
				}
				else{
					sec_overage="";
				}
			}
			if(costx>0 && new Double(overagex).doubleValue() != costx){
				
				sectionsGood=false;
				errorMessage=errorMessage+"Overage and section overage total do not match.  Please reallocate your section overage.<BR>";				
			}
		}		
		
		
		
		if(sec_setup_cost != null){
			double costx=0;
			while(sec_setup_cost.trim().length()>0){
				int start=sec_setup_cost.indexOf(";");
				if(start>=0){
					String tempCost=sec_setup_cost.substring(0,start);
					tempCost=tempCost.substring(tempCost.indexOf("=")+1);
					if(tempCost.trim().length()>0){
						costx=costx+new Double(tempCost).doubleValue();
					}
					sec_setup_cost=sec_setup_cost.substring(start+1);
					//out.println(tempCost+"::<BR>"+sec_freight_cost+"::<BR>");
				}
				else{
					sec_setup_cost="";
				}
			}
			if(costx>0 && new Double(setup_costx).doubleValue() != costx){
				
				sectionsGood=false;
				errorMessage=errorMessage+"Setup cost and section setup cost total do not match.  Please reallocate your section setup cost.<BR>";				
			}
		}		
		
		
		
		
		if(sec_handling_cost != null){
			double costx=0;
			while(sec_handling_cost.trim().length()>0){
				int start=sec_handling_cost.indexOf(";");
				if(start>=0){
					String tempCost=sec_handling_cost.substring(0,start);
					tempCost=tempCost.substring(tempCost.indexOf("=")+1);
					if(tempCost.trim().length()>0){
						costx=costx+new Double(tempCost).doubleValue();
					}
					sec_handling_cost=sec_handling_cost.substring(start+1);
					//out.println(tempCost+"::<BR>"+sec_freight_cost+"::<BR>");
				}
				else{
					sec_handling_cost="";
				}
			}
			if(costx>0 && new Double(handling_costx).doubleValue() != costx){
				
				sectionsGood=false;
				errorMessage=errorMessage+"Handling cost and section handling cost total do not match.  Please reallocate your section handling cost.<BR>";				
			}
		}		
		
		
		
		
		
		
		
		
		
		
		
		
		
		if(sec_freight_cost != null){
			double costx=0;
			while(sec_freight_cost.trim().length()>0){
				int start=sec_freight_cost.indexOf(";");
				if(start>=0){
					String tempCost=sec_freight_cost.substring(0,start);
					tempCost=tempCost.substring(tempCost.indexOf("=")+1);
					if(tempCost.trim().length()>0){
						costx=costx+new Double(tempCost).doubleValue();
					}
					sec_freight_cost=sec_freight_cost.substring(start+1);
					//out.println(tempCost+"::<BR>"+sec_freight_cost+"::<BR>");
				}
				else{
					sec_freight_cost="";
				}
			}
			if(costx>0 && new Double(freight_costx).doubleValue() != costx){
				
				sectionsGood=false;
				errorMessage=errorMessage+"Freight cost and section freight total do not match.  Please reallocate your section freights.<BR>";				
			}
		}
		if(section_infox == null){
			section_infox="";
		}
		if(numSections==null){
			numSections="";
		}
		if(section_groupx==null){
			section_groupx="";
		}
		if(numSections==null||numSections.trim().length()==0 || numSections.trim().equals("0") || numSections.trim().equals("1")){
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
			for(int secNum=1; secNum<= Integer.parseInt(numSections); secNum++){
				String tempSecName="=s"+secNum+";";
				int position=section_groupx.indexOf(tempSecName);
				if(position<1){
					sectionsGood=false;
					errorMessage=errorMessage+"Section "+secNum+" has no lines assigned to it<BR>";
				}
			}
			Vector lineNos=new Vector();
			ResultSet rsLineNos=stmt.executeQuery("select doc_line from doc_line where doc_number='"+q_no+"'");
			if(rsLineNos != null){
				while(rsLineNos.next()){
					lineNos.addElement(rsLineNos.getString(1));
				}
			}
			rsLineNos.close();
			if(section_groupx.trim().length()>0){
				for (int e=0;e<lineNos.size(); e++){
					int tempIndex=section_groupx.indexOf(";"+lineNos.elementAt(e).toString()+"=");
					if(tempIndex<0){
						tempIndex=section_groupx.substring(0,section_groupx.indexOf(";")).indexOf(lineNos.elementAt(e).toString()+"=");
						if(tempIndex<0){
							sectionsGood=false;
							errorMessage=errorMessage+"Line  "+lineNos.elementAt(e).toString()+" is not assigned to a section<BR>";
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
					}
				}



			}

		}

		if(!sectionsGood){
			out.println("<font color='red' ><b>Please Fix the following errors before you continue::<BR> "+errorMessage+"</b><BR>");
		}
	}

%>