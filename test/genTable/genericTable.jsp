<%@ page language="java" import="java.text.*" errorPage="error.jsp" %>

<jsp:useBean id="tblMaint" class="com.csgroup.general.TableMaint" scope="page"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="page"/>
<%
    userSession.setUserId("dyachouh");
%>
<!DOCTYPE html>
<html>
    <head>
        <!-- jQuery -->
        <script type="text/javascript" charset="utf8" src="DataTables/media/js/jquery.js"></script>
        <script type="text/javascript" charset="utf8" src="jquery.csv.min.js"></script>
        <script type="text/javascript" charset="utf8" src="DataTables/media/js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf8" src="DataTables/extensions/TableTools/js/dataTables.tableTools.js"></script>
        <!-- DataTables CSS -->
        <link rel="stylesheet" type="text/css" href="DataTables/media/css/jquery.dataTables.css">
        <link rel="stylesheet" type="text/css" href="DataTables/extensions/TableTools/css/dataTables.tableTools.css">
        <link rel="stylesheet" type="text/css" href="style.css">

    </head>
    <body>
        <div style="margin:0 auto;width:100%">
            Choose Table for Maintenance: <%= tblMaint.getTables("dyachouh","super") %>
            <br /><br />
            
            <input type="hidden" id="userID" value="dyachouh" />
            <input type="hidden" id="isSuper" value="" />
            <input type="hidden" id="checkExcelUpload" value="" />
            <div id="addRecordSection" style="display:none">
                
            </div>
            
            <div style="display:none" id="originalTbl">
                
            </div>
            
            <div id="tblResults" style="overflow-x: auto"> 

            </div>
            
            <div id="excelForm" style="display:none">
                <!--<form enctype="multipart/form-data" action="http://lebhq-webavdev/erapid/upload.jsp" method="post">-->
                    <input type='file' name="file1" accept='.xml'/>
                    <input type="hidden" name="S1" value="uploadExcel" />
                    
                    <button id='upExcel'>Upload Excel XML File!</button>
                <!--</form>-->
            </div>
            
            <div style="display:none">
                <% 
                String[] prods = userSession.getProducts();
                out.println(tblMaint.getFks(prods));%>
            </div>
        </div>
            
        <script>
            var fks = [];
            var ele = [];
            $(document).ready(function(){
                
//                 $.ajax({
//                    type : "POST",
//                    url:"../../beans/TableMaint",
//                    contentType: "application/json",
//                    data:{cool:"beans",very:"good"},
//                    success: function(){
//                        
//                    }
//                });
                
                $("#fks").each(function(x,element){
                    ele['fkColumnName'] = $(element).val();
                    ele['fkTable'] = $(element).text();
                    fks.push(ele)
                })
                
                
                $("#tables").change(function(event) {
                    
                    tableVal = $(this).val();
                    if(tableVal == ""){
                        $("#tblResults").html("");
                        $("#originalTbl").html("");
                    }
                    else{
                        $.ajax({
                            type : "POST",
                            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                            url : "genericTableAjax.jsp",
                            data : {table:tableVal,method:"getHTMLTableRows",userID:$("#userID").val()},
                            success : function(data) {
                                $("#tblResults").html("");
                                $("#originalTbl").html("");
                                $("#isSuper").val($(data).find("issuper").text());
                                $("#checkExcelUpload").val($(data).find("checkupload").text());
                                
                                var exForm = $('#excelForm');
                                exForm.find('form').attr("id","excelUploadForm");
                                exForm.find("#upExcel").attr("id","uploadExcel");
                                exForm.find("input[name='file']").attr("id","excelFile");

                                var buttonDL = "<br />";
                                if(parseInt($(data).find("rowcount").text()) < 22000){
                                    buttonDL = "<a href='genericTableJExcel.jsp?table="+tableVal+"' target='_blank'>Download</a><br />";
                                }
                                var searchInput = "<label for='search'>Search: <input type='text' id='searchDatatable' value = ''/>"
                                $("#tblResults").html(exForm.html() + buttonDL + searchInput + $(data).find('webhtml').html());

                                $("#originalTbl").html($(data).find('webhtml').html());
                                
                                oTable = $("#tblResults #newtbl").DataTable({
                                    "bProcessing": true,
                                    "sPaginationType": "full_numbers",
                                    "bAutoWidth":false,
                                    /*"aaSorting": [[ 0, "desc" ]],*/
                                    "iDisplayLength": 10,
                                    "fnDrawCallback": function() {
                                      //bind the click handler script to the newly created elements held in the table
                                        $('.genEdit').bind('click',genEdit);
                                    },
                                    "dom": 'T<"clear">lrtip',
//                                    "tableTools": {
//                                        "sSwfPath": "DataTables/extensions/TableTools/swf/copy_csv_xls_pdf.swf",
//                                        "aButtons": [ "copy", "xls","pdf" ]
//                                    },
                                    columnDefs: [
                                        { orderable: false, "targets": "notEdit"},
                                        { width: "300px", "targets": "longCol"}
                                    ]
                                    
                                });
                                
                                
                                

                                // Create Filter for each column
                                $('#tblResults #newtbl thead td:not(td.notEdit)').each( function () {
                                    var index = $(this).index();
                                    var title = $('#tblResults #newtbl thead td').eq( index ).text();

                                    $(this).prepend( '<input class="customFilter" data-col="' + title + '" style="width:75px;margin-bottom:10px" type="text" value="" placeholder="Search '+title+'" /><br />' );
                                    $('#newtbl thead td input.customFilter').eq(index).bind("keyup change",dbMultiSearch);
                                } );

                                $("#tblResults #newtbl thead td > input").bind("click",topSortDT);
                                $("#searchDatatable").bind("keypress",dbSearch);
                                $("#uploadExcel").bind("click",uploadExcelFile);
                                $(".delRow").bind("click",deleteTableRow);
                                


                                generateAddRecord($("#tblResults #newtbl").dataTable().dataTableSettings[0].aoColumns,tableVal);


                            }
                        });
                    }
                    
                });
                
                $('.genEdit').on('click', function () {
                    $('.genEdit').trigger('click');
                });
                
                
//                $("#newtbl tbody").on("click","tr > td input.genEdit",function(){
//                    console.log("click");
//                    $(this).parent("<td>").parent("<tr>").children("<td>").css("{color:red}");
//                });
            });
            
            
            // Disable Sort on input click inside Datatable headers
            function topSortDT(e){
                e.bSort= false;
                return false;
            }
            
            function deleteTableRow(){
                thisRow = $(this);
                var xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?><columns>";
                
                $(this).parents("tr").find("td[data-type='pk']").each(function(i,ele){
                    xml+="<column colname=\"" + $(ele).attr("data-colname") + "\">" + $(ele).html() + "</column>";
                })
                xml+= "</columns>";
                
                console.log(xml);
                $.ajax({
                    url: 'genericTableAjax.jsp',
                    async:false,
                    data: {columns: xml,method:'deleteEntry',table:$("#tables").val()},
                    type: 'POST',
                    success: function(data){
                      if($.trim(data) == "true"){
                          tbl = $('#tblResults #newtbl').DataTable();
                          
                          tbl.row(thisRow.parents("tr")).remove().draw();
                      }
                    }
                });
            }
            
            function uploadExcelFile(){
                //var file = document.getElementById("excelFile").files[0];
                $("#uploadExcel").prop("disabled","disabled");
                file = "////lebhq-erusdev/transfer/tableBackup/cs_ejc_pricing.xml";
                if(file == null){
                    alert("Please choose file to upload!");
                }
                else if($("#checkExcelUpload").val() == "true"){
                    alert("File cannot be upload: An uploaded for the selected table has already been done today. Please try again tomorrow.")
                }
                else{
//                    var selectedTbl = $("#tables").val();
//                    $("#excelUploadForm input[name='table']").val(selectedTbl);
                    
                    $.ajax({
                        url: 'genericTableAjax.jsp',
                        async:false,
                        data: {file:file,method:'uploadExcelFile',table:$("#tables").val()},
                        type: 'POST',
                        success: function(data){
                          alert(data);
                        }
                    });
                    //$("#excelUploadForm").sumbit();
                    
//                    $.ajax({
//                        url: 'http://lebhq-webavdev/erapid/upload.jsp',
//                        async:false,
//                        contentType:"multipart/form-data",
//                        data: {S1: "",file1:file},
//                        type: 'POST',
//                        success: function(data){
//                          alert(data);
//                        }
//                    });
                }
                
                $("#uploadExcel").removeAttr('disabled');
            }
            
            var globalTimeout = null; 
            function dbMultiSearch(event){
                var tableVal = $("#tables").val();
                
//                if (globalTimeout != null) {
//                    clearTimeout(globalTimeout);
//                }
//                globalTimeout = setTimeout(function() {
//                    globalTimeout = null;  

                    var xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?><columns>";
                    var execute = false;
                    var allEmpty = true;
                    
                    $("input.customFilter").each(function(i,element){
                        charCheck = 3;
                        // if is a number
                        if(!isNaN($(element).val())){
                            charCheck = 1;
                        }
                        if($(element).val().length >= charCheck){
                            xml += "<" + $(element).attr("data-col") + ">" + $(element).val() + "</" + $(element).attr("data-col") + ">";
                            execute= true;
                        }
                        if($(element).val() !== ""){
                            allEmpty = false;
                        }
                    });

                    xml += "</columns>";
                    
                    
                    if(allEmpty){
                        //$('#tblResults #newtbl').dataTable().fnDestroy();
                        $("#tblResults #newtbl tbody").html($("#originalTbl tbody").html());       
                        
                    }
                    else{
                        if(execute == true){
                            $.ajax({
                                type : "POST",
                                async:false,
                                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                                url : "genericTableAjax.jsp",
                                data : {table:tableVal,method:"searchTblFilter",query:xml,multi:"1",isSuper:$("#isSuper").val()},
                                success:function(data){
                                    $("#tblResults #newtbl tbody").html(data);

                                    $(event.currentTarget).focus();
                                }
                            });
                        }
                    }
                    
                    
                //}, 200); 
                $('.genEdit').bind('click',genEdit);
                $("#searchDatatable").bind("keypress",dbSearch);
                $(".delRow").bind("click",deleteTableRow);
            }
            
            function dbSearch(event){
                if($("#searchDatatable").val().length >= 3){
                    tableVal = $("#tables").val();
                    query = $("#searchDatatable").val();
                    $.ajax({
                        type : "POST",
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        url : "genericTableAjax.jsp",
                        data : {table:tableVal,method:"searchTblFilter",query:query,multi:"0"},
                        success:function(data){
                            $('#tblResults #newtbl').dataTable().fnDestroy();
                            $("#tblResults #newtbl tbody").html(data);
                            $("#tblResults #newtbl").dataTable();
                            
                            $('.genEdit').bind('click',genEdit);
                        }
                    });
                }
            }
            
            function filterColumn ( i ) {
                $('#tblResults #newtbl').DataTable().column( i ).search(
                    $('#col'+i+'_filter').val(),
                    $('#col'+i+'_regex').prop('checked'),
                    $('#col'+i+'_smart').prop('checked')
                ).draw();
            }
 
            
            function resetInputs(){
                $(".inputEdit").each(function(i,element){
                    html = $(element).val();
                    $(element).parent("td").html(html);
                    
                })
                $("td").removeClass("rowHighlight");
                
                $('.genUpdate').eq(0).parent("td").html("<a href='#' class='genEdit'>Edit</a>");
                $('.genEdit').bind('click',genEdit);
                $('.delRow').bind('click',deleteTableRow);
                return false;
            } 
            
            function has(obj,value){
                for(var id in obj) {
                    if(obj[id]['fkColumnName'] == value) {
                      return obj[id]['fkTable'];
                    }
                }
                return false;
            }
            
            function typeInput(type, setColId, hasPK, tblName){
                inputRet = "";
                addDataAttr = "";
                if(hasPK == true){
                    addDataAttr = " data-type='pk'";
                }
                switch(type){
                    case "string":
                        inputRet = "<input" + addDataAttr +" class='columnInsert' type='text' data-id='"+ setColId.toLowerCase() + "' />";
                    break;
                    case "list":
                        inputRet = "<select" + addDataAttr +" class='columnInsert' data-id='"+ setColId.toLowerCase() + "' >"+$("#"+tblName+"Lookup").html() + "</select>";
                    break;
                    default:
                        inputRet = "<input" + addDataAttr +" class='columnInsert' type='text' data-id='"+ setColId.toLowerCase() + "' />";
                    break;
                }
                
                return inputRet;
            }
            
            function generateAddRecord(cols,incomingTbl){
                var html = "";
                var checkStr = "notEdit";
                var tblName = "";
                
                $.each(cols,function(i,element){
                    className = element.nTh.className;
                    if(className.indexOf(checkStr) == -1){
                        html += "<span class='addRecord'>"+ element.sTitle +"</span> ";
                        
                        tableRet = has(fks,element.nTh.textContent.toLowerCase());
                        if(tableRet != false){
                            element.sType = "list";
                            tblName = tableRet;
                        }
                        html += typeInput(element.sType,element.nTh.textContent,$(element.nTh).hasClass('pk'),tblName);
                        //html+= "<br />";
                    }
                })
                html += "<button id='addRecord' data-tbl='"+ incomingTbl +"'>Add New Record</button>";
                $("#addRecordSection").html(html);
                $("#addRecordSection").slideDown();
                
                $("#addRecord").bind("click",addRecord);
            }
            
            function addRecord(){
                $("#addRecord").prop("disabled");
                var xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?><instance>";
                var obj = [];
                // row is used to populate the datatable if insert is successful
                var row = "";
                
                var t = $('#tblResults #newtbl').DataTable();
                //var t2 = $('#originalTbl #newtbl').DataTable();
                
                // Get each column and value being updated
                $(".columnInsert").each(function(i,element){
                   hasPK = "";
                   if($(element).attr("data-type") == "pk"){
                       hasPK="pk";
                   }
                   
                   xml += "<" + $(element).attr("data-id") + " type=\""+ hasPK +"\">"+$(element).val()+"</" + $(element).attr("data-id") + ">";
                   obj.push($(element).val());
                   row += "<td data-type='"+ hasPK +"' data-colname='" + $(element).attr("data-id") + "'>"+ $(element).val() +"</td>";
                });
                
                obj.push('<td><input type="button" class="genEdit" value="Edit"></td>');
                row +="<td><input type='button' value='Edit' class='genEdit' /></td>";
                
                if($("#isSuper").val() == "true"){
                    row +='<td><a href="#"><img class="delRow" src="../../images/delete.png"></a></td>';
                }
                
                xml += "</instance>";
                
                
                $.ajax({
                    type : "POST",
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    url : "genericTableAjax.jsp",
                    data : {table:$("#addRecord").attr("data-tbl"),method:"insertTableRecord",cols:xml},
                    success : function(data) {
                        
                        if($.trim(data) !== "true"){
                            alert(data)
                        }
                        else{      
                            t.row.add($("<tr class='newRowFaded'>"+row+"</tr>"));                            
                            $("#originalTbl #newtbl tbody").append("<tr class='newRowFaded'>"+row+"</tr>");
                            //t2.row.add($("<tr>"+row+"</tr>")).draw();
                            //t.row.add(obj).draw();
                        }
                        $("#addRecord").prop("disabled","");
                        
                        //$('.dataTables_scrollBody').scrollTo('.'+elementV,2000,{offset: {top:0, left:-130} });

                    }
                })
            }
            
            function genEdit(){
                resetInputs();
                var length = $(this).parents("tr").children("td").length;
                var eachSelector = "td:not(:last-child";
                var insideTxtArea = "";
                if($("#isSuper").val() == "true"){
                    eachSelector += ",:nth-last-child(2)";
                }
                
                eachSelector += ")";
                
                $(this).parents("tr").children(eachSelector).each(function(i,element){
                    
                    $(element).addClass("rowHighlight");
                    if($(element).attr("data-type") !== "pk" ){
                        insideTxtArea = "<textarea class='inputEdit'>"+$(element).html()+"</textarea>";
                        var col = $(element).parent().children().index($(element));
                        var hasLongCol = $("#tblResults #newtbl thead td:eq("+col+")").hasClass("longCol");
                        
                        if(hasLongCol == true){
                            insideTxtArea = "<textarea class='inputEdit' style='width:300px;height:60px'>"+$(element).html()+"</textarea>";
                        }
                        $(element).html(insideTxtArea);
                    }
                    
                    
                    
                });
                
                if($("#isSuper").val() == "true"){
                    $(this).parents("tr").children("td:nth-last-child(2)").html("<input type='button' value='Update' class='genUpdate' /><input type='button' value='Cancel' class='cancelUpdate' />");
                }
                else{
                    $(this).parents("tr").children("td:last-child").html("<input type='button' value='Update' class='genUpdate' /><input type='button' value='Cancel' class='cancelUpdate' />");                    
                }
                
                $('.genUpdate').bind('click',genUpdate);
                $('.cancelUpdate').bind('click',resetInputs);
                
                var new_position = $("td.rowHighlight").eq($("td.rowHighlight").length-1).offset();
                window.scrollTo(new_position.left,new_positon.top);
                return false;
            }
            
            
            function genUpdate(){
                //table = $("#tblResults #newtbl").DataTable();
                var jsonStr = [];
                var xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?><instance>";
                
                // Get each column and value being updated
                $(".inputEdit").each(function(i,element){
                    colname = $(element).parent("td").attr("data-colname");
                    xml += "<" + colname + ">"+$(element).val()+"</" + colname + ">";
                   jsonStr["\""+colname+"\""] = $(element).val(); 
                });
                
                // Get pks for the update where clause in selected row
                $("td[data-type='pk'].rowHighlight").each(function(i,element){
                    colname = $(element).attr("data-colname");
                    xml += "<" + colname + " type='pk'>"+$(element).html()+"</" + colname + ">";
                });
                
                xml +="</instance>";
                
                $.ajax({
                    type : "POST",
                    async:false,
                    dataType:"text",
                    url : "genericTableAjax.jsp",
                    data : {table:$("#tables").val(),method:"updateTableRecord",cols:xml},
                    success : function(data) {
                        console.log(data)
                        if($.trim(data) == "true"){
                            alert("Update successful!")
                        }
                        resetInputs();


                    } ,
                    error:function (xhr, ajaxOptions, thrownError){  
                        console.log('Error xhr : ' + xhr.status);  
                        console.log('Error thrown error: ' + thrownError);  
                    }
                });
                
                return false;
            }
        </script>
    </body>
</html>