<%
try{
	if(product.equals("EFS")){
		//out.println(request.getParameter("cmd"));
		if(request.getParameter("cmd") != null && request.getParameter("cmd").trim().length()>0){
			//	out.println("in ows");
		}
		if(tax_zip != null && tax_zip.trim().length()>0){
			int taxperccount=0;
			ResultSet rsTaxPerc=stmtRepData.executeQuery("select taxcode,taxpercentage,taxexemptcode from tax_rep2 where zip='"+tax_zip+"'");
			if(rsTaxPerc != null){
				while(rsTaxPerc.next()){
					taxperccount++;
					if(tax_exempt.equals("Y")){
						tax_perc="0";
						tax_code=rsTaxPerc.getString("taxexemptcode");
					}
					else{
						//tax_perc=rsTaxPerc.getString("taxpercentage");
						tax_code=rsTaxPerc.getString("taxcode");
					}
				}
			}
			rsTaxPerc.close();
			if(taxperccount<=0){
				out.println("<CENTER><font color='red' size='3'><B>Zip code not found</b></font></center>");
				tax_code="";
				tax_zip="";
				tax_perc="";
			}
			else if(!tax_exempt.equals("Y")){
				String tax_code_temp="'";
				double temp_tax_perc=0;
				//out.println(tax_code+"::"+"select RTRC01,RTRC02,RTRC03,RTRC04,RTRC05,RTRC06,RTRC07,RTRC08,RTRC09,RTRC10 from ZRT where RTICDE='PROD' and RTCVCD='"+tax_code+"'<BR>");
				ResultSet rsbpcs=stmt_bpcs.executeQuery("select RTRC01,RTRC02,RTRC03,RTRC04,RTRC05,RTRC06,RTRC07,RTRC08,RTRC09,RTRC10 from ZRT where RTICDE='PROD' and RTCVCD='"+tax_code+"'");
				if(rsbpcs != null){
					while(rsbpcs.next()){
						for(int v=1; v<=10; v++){
							if(rsbpcs.getString(v) != null && rsbpcs.getString(v).trim().length()>0){
								tax_code_temp=tax_code_temp+rsbpcs.getString(v)+"','";
							}
						}
					}
				}
				rsbpcs.close();
				if(tax_code_temp.trim().length()>1){
					tax_code_temp=tax_code_temp.substring(0,tax_code_temp.length()-2);
				}
				else{
					out.println("<CENTER><font color='red' size='3'><B>PROBLEM WITH ZIP CODE</b></font></center>");
				}
				ResultSet rsbpcs2=stmt_bpcs.executeQuery("select RCCRTE from ZRC where RCRTCD in ("+tax_code_temp+")");
				if(rsbpcs2 != null){
					while(rsbpcs2.next()){
						if(rsbpcs2.getString(1) != null && rsbpcs2.getString(1).trim().length()>0){
							temp_tax_perc=temp_tax_perc+new Double(rsbpcs2.getString(1)).doubleValue();
						}
					}
				}
				rsbpcs2.close();
				tax_perc=""+temp_tax_perc;
			}
		}

		if(tax_perc != null && tax_perc.trim().length()>0 && !tax_perc.toUpperCase().equals("NULL")&& new Double(tax_perc).doubleValue()>0){
			DecimalFormat df4 = new DecimalFormat("####.####");
			df4.setMaximumFractionDigits(4);
			df4.setMinimumFractionDigits(4);
			DecimalFormat df2 = new DecimalFormat("####.##");
			df2.setMaximumFractionDigits(2);
			df2.setMinimumFractionDigits(2);
			DecimalFormat df0 = new DecimalFormat("####");
			df0.setMaximumFractionDigits(0);
			df0.setMinimumFractionDigits(0);
			DecimalFormat df3 = new DecimalFormat("####.###");
			df3.setMaximumFractionDigits(3);
			df3.setMinimumFractionDigits(3);
			Vector tax_qty=new Vector();
			Vector tax_extended_price=new Vector();
			Vector tax_unit_price=new Vector();
			Vector tax_overage_line=new Vector();
			Vector tax_setup_line=new Vector();
			Vector tax_handling_line=new Vector();
			Vector tax_freight_line=new Vector();
			String tax_overage="0";
			String tax_handling="0";
			String tax_freight="0";
			String tax_setup="0";
			double taxtotalprice=0;
			double temp_tax_total=0;
			double temp_total=0;
			double difference=0;
			if(request.getParameter("cmd") != null && request.getParameter("cmd").trim().length()>0){
				ResultSet rsprojectx=stmt.executeQuery("select setup_cost,freight_cost,handling_cost,overage from cs_project where order_no='"+q_no+"'");
				if(rsprojectx != null){
					while(rsprojectx.next()){
						if(rsprojectx.getString("setup_cost") != null &&rsprojectx.getString("setup_cost").trim().length()>0 && !rsprojectx.getString("setup_cost").toLowerCase().equals("null")){
							tax_setup=rsprojectx.getString("setup_cost");
						}
						if(rsprojectx.getString("handling_cost") != null &&rsprojectx.getString("handling_cost").trim().length()>0 && !rsprojectx.getString("handling_cost").toLowerCase().equals("null")){
							tax_handling=rsprojectx.getString("handling_cost");
						}
						if(rsprojectx.getString("freight_cost") != null &&rsprojectx.getString("freight_cost").trim().length()>0 && !rsprojectx.getString("freight_cost").toLowerCase().equals("null")){
							tax_freight=rsprojectx.getString("freight_cost");
						}
						if(rsprojectx.getString("overage") != null &&rsprojectx.getString("overage").trim().length()>0 && !rsprojectx.getString("overage").toLowerCase().equals("null")){
							tax_overage=rsprojectx.getString("overage");
						}
					}
				}
				rsprojectx.close();
			}
			else{
				if(request.getParameter("overage") != null && request.getParameter("overage").trim().length()>0 && !request.getParameter("overage").toLowerCase().equals("null")){
					tax_overage=request.getParameter("overage");
				}
				if(request.getParameter("handling_cost") != null && request.getParameter("handling_cost").trim().length()>0 && !request.getParameter("handling_cost").toLowerCase().equals("null")){
					tax_handling=request.getParameter("handling_cost");
				}
				if(request.getParameter("freight_cost") != null && request.getParameter("freight_cost").trim().length()>0 && !request.getParameter("freight_cost").toLowerCase().equals("null")){
					tax_freight=request.getParameter("freight_cost");
				}
				if(request.getParameter("setup_cost1") != null && request.getParameter("setup_cost1").trim().length()>0 && !request.getParameter("setup_cost1").toLowerCase().equals("null")){
					tax_setup=request.getParameter("setup_cost1");
				}
				if(request.getParameter("setup_cost") != null && request.getParameter("setup_cost").trim().length()>0 && !request.getParameter("setup_cost").toLowerCase().equals("null")){
					tax_setup=request.getParameter("setup_cost");
				}
				if (tax_handling.equals("noneed")){
					tax_handling="0";
				}
			}
			double linetotal=0;
			ResultSet rstax0=stmt.executeQuery("select extended_price from csquotes where order_no='"+q_no+"' and not extended_price is null and not extended_price=''");
			if(rstax0 != null){
				while(rstax0.next()){
					linetotal=linetotal+rstax0.getDouble(1);
				}
			}
			rstax0.close();
			//out.println(linetotal+":: line total<BR>");

			ResultSet rstax=stmt.executeQuery("select * from csquotes where order_no='"+q_no+"' and not extended_price is null and not extended_price='' and cast(extended_price as numeric)>0 and not block_id='b_frames'");
			if(rstax != null){
				while(rstax.next()){
					//out.println(rstax.getString("extended_price")+"::"+rstax.getString("block_id")+"::"+rstax.getString("line_no")+"::<BR>");
					tax_qty.addElement(""+new Double(df3.format(rstax.getDouble("bpcs_qty"))));
					double temp=new Double(tax_overage).doubleValue()*(rstax.getDouble("extended_price")/linetotal);
					double temp2=new Double(tax_handling).doubleValue()*(rstax.getDouble("extended_price")/linetotal);
					double temp3=new Double(tax_freight).doubleValue()*(rstax.getDouble("extended_price")/linetotal);
					double temp4=new Double(tax_setup).doubleValue()*(rstax.getDouble("extended_price")/linetotal);
					tax_extended_price.addElement(""+new Double(df4.format(rstax.getDouble("extended_price")+temp+temp2+temp3+temp4)).doubleValue());
					//out.println(""+(new Double(df4.format(rstax.getDouble("extended_price")+temp+temp2+temp3+temp4)).doubleValue())+"::test<BR>");
					temp_total=temp_total+rstax.getDouble("extended_price");
				}
			}
			rstax.close();
			double framesqty=0;
			double framesprice=0;

			ResultSet rstax2=stmt.executeQuery("select bpcs_qty, extended_price,*  from csquotes where order_no='"+q_no+"' and not extended_price is null and not extended_price='' and cast(extended_price as numeric)>0 and block_id='b_frames' order by bpcs_gen");
			if(rstax2 != null){
				while(rstax2.next()){
					//out.println(rstax2.getString("extended_price")+"::"+rstax2.getString("block_id")+"::"+rstax2.getString("line_no")+"::<BR>");
					tax_qty.addElement(""+(framesqty+new Double(df3.format(rstax2.getDouble(1))).doubleValue()));
					double temp=new Double(tax_overage).doubleValue()*(rstax2.getDouble(2)/linetotal);
					double temp2=new Double(tax_handling).doubleValue()*(rstax2.getDouble(2)/linetotal);
					double temp3=new Double(tax_freight).doubleValue()*(rstax2.getDouble(2)/linetotal);
					double temp4=new Double(tax_setup).doubleValue()*(rstax2.getDouble(2)/linetotal);
					tax_extended_price.addElement(""+(framesprice+new Double(df4.format(rstax2.getDouble(2)+temp+temp2+temp3+temp4)).doubleValue()));
					//out.println(""+(framesprice+new Double(df4.format(rstax2.getDouble(2)+temp+temp2+temp3+temp4)).doubleValue())+"<BR>");
					temp_total=temp_total+rstax2.getDouble(2);
				}
			}
			rstax2.close();
			//out.println("<BR><BR>");
			tax_qty.addElement(""+framesqty);
			tax_extended_price.addElement(""+framesprice);
			difference=new Double(df0.format(temp_total)).doubleValue()-temp_total;
			//out.println(difference+"::DIFFERENCE<BR>");
			int indexOfMax=0;
			for(int r=0; r<tax_extended_price.size(); r++){
				for(int e=0; e<tax_extended_price.size(); e++){
					if(new Double(tax_extended_price.elementAt(e).toString()).doubleValue()>new Double(tax_extended_price.elementAt(indexOfMax).toString()).doubleValue()){
						indexOfMax=e;
						if(r<e){
							r=e;
						}
						e=tax_extended_price.size();
					}

				}
			}
			if(tax_extended_price.size()>0){
				tax_extended_price.setElementAt(""+(new Double(tax_extended_price.elementAt(indexOfMax).toString()).doubleValue()+difference),indexOfMax);
			}
			for(int w=0; w<tax_extended_price.size(); w++){
				tax_unit_price.addElement(""+new Double(tax_extended_price.elementAt(w).toString()).doubleValue()/new Double(tax_qty.elementAt(w).toString()).doubleValue());
				taxtotalprice=taxtotalprice+new Double(tax_unit_price.elementAt(w).toString()).doubleValue()*new Double(tax_qty.elementAt(w).toString()).doubleValue();
			}
			for(int e=0; e<tax_unit_price.size();e++){
				double temptotal=(new Double(tax_extended_price.elementAt(e).toString()).doubleValue())*(new Double(tax_perc).doubleValue()/100);
				BigDecimal d1 = new BigDecimal(tax_extended_price.elementAt(e).toString());
				BigDecimal d2 = new BigDecimal(df4.format(new Double(tax_perc).doubleValue()/100));
				BigDecimal d3 = d1.multiply(d2);
				//temptotal=new Double(temptotal2).doubleValue();
				temp_tax_total=temp_tax_total+new Double(temptotal).doubleValue();
			}
			String temptotal3=""+(temp_tax_total);
			temp_tax_total=new Double(temptotal3).doubleValue();
			tax_dollar=(float)temp_tax_total;
		}
	}//end efs
	else{
                        String tempProjectType="";
                        ResultSet rsprojectx=stmt.executeQuery("select project_type,tax_exempt from cs_project where order_no='"+q_no+"'");
			if(rsprojectx != null){
				while(rsprojectx.next()){
                                    tempProjectType=rsprojectx.getString(1);
							tax_exempt=rsprojectx.getString(2);
                                }
                        }
                        rsprojectx.close();

		//out.println(product);
		boolean istaxstate=false;

		if(tax_zip != null && tax_zip.trim().length()>0){
			int taxperccount=0;

			String statex="";
			ResultSet rsTaxPerc=stmtRepData.executeQuery("select taxcode,taxpercentage,taxexemptcode,stateabbrev from tax_rep2 where zip='"+tax_zip+"'");
			if(rsTaxPerc != null){
				while(rsTaxPerc.next()){
					taxperccount++;
					if(tax_exempt.equals("Y")){
						tax_perc="0";
						tax_code=rsTaxPerc.getString("taxexemptcode");
					}
					else{
						//tax_perc=rsTaxPerc.getString("taxpercentage");
						tax_code=rsTaxPerc.getString("taxcode");
					}
					statex=rsTaxPerc.getString("stateabbrev");
					//out.println(state +":: tax_rep2<BR>");
				}
			}
			rsTaxPerc.close();
			//out.println(statex+"::<BR>");
			/*
			if(product.equals("GE")||product.equals("IWP")){
				String[] taxable_freight_state = {"AR","CT","GA","IN","KS","KY","MI","MN","MS","NE","NJ","NM","NY","NC","ND","OH","PA","RI","SD","TN","TX","WA","WV","WI"};
				for (int ix = 0; ix < taxable_freight_state.length; ix++) {
					if(statex.equals(taxable_freight_state[ix])){
						istaxstate=true;
					}
				}
			}
			else{
				*/
				ResultSet rstaxstate=stmtRepData.executeQuery("select state from cs_freight_tax_state where state='"+statex+"'");
				if(rstaxstate != null){
					while(rstaxstate.next()){
						istaxstate=true;
						//out.println(rstaxstate.getString(1)+":: freight_max<BR>");
					}
				}
				rstaxstate.close();
			//}
			//out.print(istaxstate+" <!-- is tax state<BR>");

                        if(tempProjectType==null){
                            tempProjectType="";
                        }
			if(taxperccount<=0){
				out.println("<CENTER><font color='red' size='3'><B>Zip code not found</b></font></center>");
				tax_code="";
				tax_zip="";
				tax_perc="";
			}
			else if(!tax_exempt.equals("Y")){
				String tax_code_temp="'";
				double temp_tax_perc=0;
				//out.println(tax_code+"::"+"select RTRC01,RTRC02,RTRC03,RTRC04,RTRC05,RTRC06,RTRC07,RTRC08,RTRC09,RTRC10 from ZRT where RTICDE='PROD' and RTCVCD='"+tax_code+"'<BR>");
				ResultSet rsbpcs=stmt_bpcs.executeQuery("select RTRC01,RTRC02,RTRC03,RTRC04,RTRC05,RTRC06,RTRC07,RTRC08,RTRC09,RTRC10 from ZRT where RTICDE='PROD' and RTCVCD='"+tax_code+"'");
				if(rsbpcs != null){
					while(rsbpcs.next()){
						for(int v=1; v<=10; v++){
							if(rsbpcs.getString(v) != null && rsbpcs.getString(v).trim().length()>0){
								tax_code_temp=tax_code_temp+rsbpcs.getString(v)+"','";
							}
						}
					}
				}
				rsbpcs.close();
				if(tax_code_temp.trim().length()>1){
					tax_code_temp=tax_code_temp.substring(0,tax_code_temp.length()-2);
				}
				else{
					out.println("<CENTER><font color='red' size='3'><B>PROBLEM WITH ZIP CODE</b></font></center>");
				}
				ResultSet rsbpcs2=stmt_bpcs.executeQuery("select RCCRTE from ZRC where RCRTCD in ("+tax_code_temp+")");
				if(rsbpcs2 != null){
					while(rsbpcs2.next()){
						if(rsbpcs2.getString(1) != null && rsbpcs2.getString(1).trim().length()>0){
							temp_tax_perc=temp_tax_perc+new Double(rsbpcs2.getString(1)).doubleValue();
						}
					}
				}
				rsbpcs2.close();
				tax_perc=""+temp_tax_perc;
			}
		}

		if(tax_perc != null && tax_perc.trim().length()>0 && !tax_perc.toUpperCase().equals("NULL")&& new Double(tax_perc).doubleValue()>0){

			//out.println(tax_perc+"::::: tax percent<BR>");
			DecimalFormat df4 = new DecimalFormat("####.####");
			df4.setMaximumFractionDigits(4);
			df4.setMinimumFractionDigits(4);
			DecimalFormat df2 = new DecimalFormat("####.##");
			df2.setMaximumFractionDigits(2);
			df2.setMinimumFractionDigits(2);
			DecimalFormat df0 = new DecimalFormat("####");
			df0.setMaximumFractionDigits(0);
			df0.setMinimumFractionDigits(0);
			DecimalFormat df3 = new DecimalFormat("####.###");
			df3.setMaximumFractionDigits(3);
			df3.setMinimumFractionDigits(3);
			Vector tax_qty=new Vector();
			Vector tax_extended_price=new Vector();
			Vector tax_unit_price=new Vector();
			Vector tax_overage_line=new Vector();
			Vector tax_setup_line=new Vector();
			Vector tax_handling_line=new Vector();
			Vector tax_freight_line=new Vector();
			Vector isTaxable=new Vector();
			String tax_overage="0";
			String tax_handling="0";
			String tax_freight="0";
			String tax_setup="0";
			double taxtotalprice=0;
			double temp_tax_total=0;
			double temp_total=0;
			double difference=0;
			if(request.getParameter("overage") != null && request.getParameter("overage").trim().length()>0 && !request.getParameter("overage").toLowerCase().equals("null")){
				tax_overage=request.getParameter("overage");
			}
			if(request.getParameter("handling_cost") != null && request.getParameter("handling_cost").trim().length()>0 && !request.getParameter("handling_cost").toLowerCase().equals("null")){
				tax_handling=request.getParameter("handling_cost");
			}
			if(request.getParameter("freight_cost") != null && request.getParameter("freight_cost").trim().length()>0 && !request.getParameter("freight_cost").toLowerCase().equals("null")){
				tax_freight=request.getParameter("freight_cost");

				if(product.equals("GCP")){
					String ship_statex = request.getParameter("ship_state");
					if((Double.parseDouble(freight_cost))<=0){
						if (ship_statex.equals("1")){
							freight_cost="0";
						}
						else {
							String query="select * from cs_gcp_ups_charges where State='"+ship_statex+"' ";
							ResultSet myResult2=stmt.executeQuery(query);
							if (myResult2 !=null) {
								while (myResult2.next()){
									tax_freight=myResult2.getString(3);
								}
							}
						}
					}
				}
			}

			if(request.getParameter("setup_cost1") != null && request.getParameter("setup_cost1").trim().length()>0 && !request.getParameter("setup_cost1").toLowerCase().equals("null")){
				tax_setup=request.getParameter("setup_cost1");
			}
			if(request.getParameter("setup_cost") != null && request.getParameter("setup_cost").trim().length()>0 && !request.getParameter("setup_cost").toLowerCase().equals("null")){
				tax_setup=request.getParameter("setup_cost");
			}
			if (tax_handling.equals("noneed")){
				tax_handling="0";
				//out.println(handling_cost+"::HERE2<BR>");
			}

			ResultSet rstax=stmt.executeQuery("select * from csquotes where order_no='"+q_no+"' and not extended_price is null and not extended_price='' and cast(extended_price as float)>0 ");
			if(rstax != null){
				while(rstax.next()){
					//out.println(product);
					//ééout.println(rstax.getString("qty")+"::qty<BR>");
					//out.println(""+new Double(df4.format(rstax.getDouble("extended_price"))).doubleValue()+":: price<BR>");
					if(product.equals("GCP")||product.equals("ADS")){
						//out.println("here1");
						tax_qty.addElement(""+new Double(df3.format(rstax.getDouble("qty"))));
					}
					else{
						//out.println("here2");
						tax_qty.addElement(""+new Double(df3.format(rstax.getDouble("bpcs_qty"))));
					}
					if(rstax.getString("deduct")==null || !rstax.getString("deduct").equals("deduct")){
						tax_extended_price.addElement(""+new Double(df4.format(rstax.getDouble("extended_price"))).doubleValue());
						temp_total=temp_total+rstax.getDouble("extended_price");

					}
					else{
						tax_extended_price.addElement("-"+new Double(df4.format(rstax.getDouble("extended_price"))).doubleValue());
						temp_total=temp_total-rstax.getDouble("extended_price");
					}


					isTaxable.addElement("true");
				}
			}
			rstax.close();


			if(new Double(tax_setup).doubleValue()>0){
				tax_qty.addElement("1");
				tax_extended_price.addElement(""+new Double(tax_setup).doubleValue());
				temp_total=temp_total+new Double(tax_setup).doubleValue();
				isTaxable.addElement("true");
			}
			if(new Double(tax_freight).doubleValue()>0){
				//out.println("<BR>HERE<br>");
				tax_qty.addElement("1");
				tax_extended_price.addElement(""+new Double(tax_freight).doubleValue());
				temp_total=temp_total+new Double(tax_freight).doubleValue();
				if(!istaxstate && (product.equals("GE")||product.equals("ELM"))){
					isTaxable.addElement("false");
					out.println("Freight is not taxable<BR>");
					//out.println("false<BR>");
				}
				else{
					out.println("Freight is taxable<BR>");
					isTaxable.addElement("true");
					//out.println("true<BR>");
				}
			}
			if(new Double(tax_handling).doubleValue()>0){
				tax_qty.addElement("1");
				tax_extended_price.addElement(""+new Double(tax_handling).doubleValue());
				temp_total=temp_total+new Double(tax_handling).doubleValue();
				if(!istaxstate && product.equals("IWP")){
					isTaxable.addElement("false");
				}
				else{
					isTaxable.addElement("true");
				}
			}
			if(!(product.equals("GE")||product.equals("GCP")||(product.equals("IWP")&&tempProjectType.toUpperCase().equals("WEB")))){
				difference=new Double(df0.format(temp_total)).doubleValue()-temp_total;
			}
			int indexOfMax=0;
			for(int r=0; r<tax_extended_price.size(); r++){
				for(int e=0; e<tax_extended_price.size(); e++){
					if(new Double(tax_extended_price.elementAt(e).toString()).doubleValue()>new Double(tax_extended_price.elementAt(indexOfMax).toString()).doubleValue()){
						//out.println("set "+e+"<BR>");
						indexOfMax=e;
						if(r<e){
							r=e;
						}
						e=tax_extended_price.size();
					}

				}
			}
			if(tax_extended_price.size()>0){
				//out.println(difference+":: difference");
				tax_extended_price.setElementAt(""+(new Double(tax_extended_price.elementAt(indexOfMax).toString()).doubleValue()+difference),indexOfMax);
			}
			//out.println(taxtotalprice+"::2a<BR>");
			for(int w=0; w<tax_extended_price.size(); w++){
				tax_unit_price.addElement(""+new Double(tax_extended_price.elementAt(w).toString()).doubleValue()/new Double(tax_qty.elementAt(w).toString()).doubleValue());
				//out.println(tax_extended_price.elementAt(w).toString()+"::1<BR>");
				//out.println(tax_qty.elementAt(w).toString()+"::2<BR>");
				taxtotalprice=taxtotalprice+new Double(tax_unit_price.elementAt(w).toString()).doubleValue()*new Double(tax_qty.elementAt(w).toString()).doubleValue();
				//out.println(taxtotalprice+"::3<BR>");
			}
			for(int q=0;q<tax_extended_price.size(); q++){
				String tempoverage="";
				String tempsetup="";
				String temphandling="";
				String tempfreight="";
				if(new Double(tax_overage).doubleValue()>0){

					tempoverage=""+new Double(tax_overage).doubleValue()*(new Double(tax_extended_price.elementAt(q).toString()).doubleValue()/taxtotalprice);
					//out.println(tempoverage+"::"+tax_extended_price.elementAt(q).toString()+"::"+taxtotalprice+"::<BR>");
					tax_overage_line.addElement(""+df2.format(new Double(tempoverage).doubleValue()));
				}
				else{
					tax_overage_line.addElement("0");
				}
			}
			double testgreg=0;
			double testgreg1=0;
			//out.println(freight_cost+":: not price calc");

			for(int e=0; e<tax_unit_price.size();e++){
				double temptotal=0;
				temptotal=(new Double(tax_extended_price.elementAt(e).toString()).doubleValue()+new Double(tax_overage_line.elementAt(e).toString()).doubleValue());
                                //out.println(temptotal+":::<BR>");
//out.println(temptotal+"::"+tax_extended_price.elementAt(e).toString()+"::"+tax_overage_line.elementAt(e).toString()+":::<BR>");
				//*(new Double(tax_perc).doubleValue()/100);
				//out.println(tax_extended_price.elementAt(e).toString()+"::"+tax_overage_line.elementAt(e).toString()+"::"+tax_perc+"<BR>");
				//out.println(temptotal+"::<BR><br>");
				if(isTaxable.elementAt(e).toString().equals("true")){

					String temptotal2=""+(temptotal*10000);
					temptotal=new Double(temptotal2).doubleValue()/10000;
					temp_tax_total=temp_tax_total+new Double(temptotal).doubleValue();
				}
			}
			DecimalFormat df00 = new DecimalFormat("####");
			df00.setMaximumFractionDigits(0);
			df00.setMinimumFractionDigits(0);

			if(product.equals("GCP")||product.equals("GE")||(product.equals("IWP")&&tempProjectType.toUpperCase().equals("WEB"))){
				//temp_tax_total=new Double(df00.format(temp_tax_total)).doubleValue();
			}
			else{
				temp_tax_total=new Double(df00.format(temp_tax_total)).doubleValue();
			}

		//	out.println(temp_tax_total+":x:"+tax_perc+"<BR>");
			temp_tax_total=temp_tax_total*(new Double(tax_perc).doubleValue()/100);

			String temptotal3=""+(temp_tax_total);
			temp_tax_total=new Double(temptotal3).doubleValue();

			if(product.equals("GCP")){
				temp_tax_total=Math.round(temp_tax_total*100+.5);
				temp_tax_total=temp_tax_total/100;
				/// 100;
				tax_dollar=Float.parseFloat(df2.format(temp_tax_total));
			}
			else{

				tax_dollar=Float.parseFloat(df2.format(temp_tax_total));
			}

		}

	}
}
catch(Exception etax){
	out.println(etax);
}
%>