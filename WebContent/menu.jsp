
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSetMetaData" %>

<%@page import="javax.script.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta charset="ISO-8859-1">
<!-- Linking various style sheets -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  
  <!-- Styling  -->
<style>
body{
	 background-image:url("bg.png");
     height: 100%; 
     background-position: center;
     background-size: cover;
     background-repeat:repeat-y;
}
ul {
 clear: right;
 padding: 0;
 list-style: none;
 width: 150px;
 border-bottom: 1px solid #ccc;
 float:right;
 }
 
 ul li {
 position:relative;
 }
li ul {
 position:absolute;
 right:150px;
 top: 0;
 display: none;
 }
 li:hover ul{ display:block;}
ul li a {
 display: block;
 text-decoration: none;
 color: #777;
 background: rgb(224,211,250);
 padding: 5px;
 border: 1px solid #ccc;
 border-bottom: 0;
 }
 ul li .btn-group .button  {
 
 text-decoration: none;
 color: white;
 background: Dodgerblue;
 padding: 5px;
 border: 1px solid #ccc;
 border-bottom: 0;
 margin-left:auto;
 margin-right:0;
 }
 .btn-group .button {
  /*margin-left:57.1em;
  margin-top:2em;
  margin-bottom: 1.5em;*/
  margin-left:auto;
  margin-right:0;
  background-color:Dodgerblue; 
  border: none;
  color: white;
  padding: 10px 22px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 14px;
  cursor: pointer;
  float:right;
  position:relative;
}
.btn-group .button:hover {
  background-color:rgb(0,128,158);
}
#adddept {  
  font-weight: bold;
  position:fixed;
  left:0;
  right:0;
  margin: auto;
  top: 50%;
  -webkit-transform: translateY(-50%);
  -ms-transform: translateY(-50%);
  transform: translateY(-50%);
  width: 400px;
  height: auto;
  padding: 15px;  
  background: LightGray;
  text-align: center;
  box-sizing: content-box;
  border: 4px double black;
}
#deldept {  
  font-weight: bold;
  position:fixed;
  left:0;
  right:0;
  margin: auto;
  top: 50%;
  -webkit-transform: translateY(-50%);
  -ms-transform: translateY(-50%);
  transform: translateY(-50%);
  width: 400px;
  height: auto;
  padding: 15px;  
  background: LightGray;
  text-align: center;
  box-sizing: content-box;
  border: 4px double black;
}
#asubdept {  
  font-weight: bold;
  position:fixed;
  left:0;
  right:0;
  margin: auto;
  top: 50%;
  -webkit-transform: translateY(-50%);
  -ms-transform: translateY(-50%);
  transform: translateY(-50%);
  width: 400px;
  height: auto;
  padding: 15px;  
  background: LightGray;
  text-align: center;
  box-sizing: content-box;
  border: 4px double black;
}
#dsubdept {  
  font-weight: bold;
  position:fixed;
  left:0;
  right:0;
  margin: auto;
  top: 50%;
  -webkit-transform: translateY(-50%);
  -ms-transform: translateY(-50%);
  transform: translateY(-50%);
  width: 400px;
  height: auto;
  padding: 15px;  
  background: LightGray;
  text-align: center;
  box-sizing: content-box;
  border: 4px double black;
}
#firstmap {  
  font-weight: bold;
  position:fixed;
  left:0;
  right:0;
  margin: auto;
  top: 60%;
  -webkit-transform: translateY(-50%);
  -ms-transform: translateY(-50%);
  transform: translateY(-50%);
  width: 50%;
  height: 50%;
  padding: 15px;  
  background: LightGray;
  text-align: center;
  box-sizing: content-box;
  border: 4px double black;
}

</style>

<title>Menus</title>

<!-- Including Open Layers Library -->
<script src="http://openlayers.org/api/OpenLayers.js"></script>

</head>
<body>
 
<%
// Display the name of district selected
String name=request.getParameter("name");
String m=request.getParameter("mode");
String mode="";
if(m==null){
	mode="guest";
}
else if(m.equals("ahjdeifirnf")){
	mode="admin";
}
else {
	mode="guest";
}
//Connect to database postgresql
Class.forName("org.postgresql.Driver");
Connection conn=null;
		
		String url = "jdbc:postgresql://localhost:5432/CMS";
		String user ="postgres";
		String password = "geoserver";
		conn= DriverManager.getConnection(url,user,password); 
		PreparedStatement pst_first;
		
	String state="";	
if(name!=null){
		String sql_first="select * from public.master where id= ? ";
		pst_first= conn.prepareStatement(sql_first);
		pst_first.setString(1,name);
		ResultSet rs_first=pst_first.executeQuery();
		while(rs_first.next()){
			state=rs_first.getString(2);
			%>
			<div>
			<center><h2 style="font:Raleway;"> <i class="fa fa-map-o"></i>  <i class="fa fa-map-marker"></i>
			 State: <b><%out.println(rs_first.getString(2)); %></b></h2></center>
			 <div style="margin-left:85%;color:rgb(224,211,250);font-size:15px;"><b>Welcome <%out.println(mode); %></b></div>
		  </div>
		<% }
			
}%>

<!-- Heading -->



<!-- Back button -->

<button type="button" onclick="back()" style="background-color:Dodgerblue; border: none;color: white;padding: 10px 22px;text-align: center;
  text-decoration: none;display: inline-block;font-size: 14px;cursor: pointer; position:relative;">
  Choose Another State</button>
  <button type="button" onclick="login()" style="background-color:Dodgerblue; border: none;color: white;padding: 10px 22px;text-align: center;
  text-decoration: none;display: inline-block;font-size: 14px;cursor: pointer; position:relative;">
  
  <%if(mode.equals("admin")){ 
  	out.println("Sign Out");
  }
  else{
	  out.println("Admin Sign In");
  }%>
  </button>
<!-- Buttons for adding and deleting Department -->


  
  <!-- Buttons for adding and deleting sub-departments -->
  
  
<%

		
		PreparedStatement pst2;
		PreparedStatement pst3;
		
				
		String sql2 = "select * from alldept_x" +" where id not in (select id from alldept_x" +" natural join display_" + name+")"; // Select all districts for addition option
		String sql3 = "SELECT * FROM public.display_" + name; // Select districts present in menu for deletion option
		pst2= conn.prepareStatement(sql2);
		pst3= conn.prepareStatement(sql3);
		
		String val1,val2;
		%>
		 <%        
    String a = request.getParameter("menuname");
	String b = request.getParameter("dept");
	String c = request.getParameter("ddept");
	String d = request.getParameter("subname");
	String e = request.getParameter("subadept");
	String f = request.getParameter("subddept");
	String g,h;
	if(c!=null){
		// Update database on deletion of department
		PreparedStatement pst5;
    	String sql5 = "DELETE FROM display_" +name+ " WHERE ID=?";
    	pst5= conn.prepareStatement(sql5);
    	pst5.setString(1,c);
    	pst5.executeUpdate();
    	
	}
    if(a != null && b!=null){
    	
    	//Update database on addition of department
    	PreparedStatement pst4;
    	String sql4 = "INSERT INTO display_"+name +" VALUES (?, ?)";
    	pst4= conn.prepareStatement(sql4);
    	pst4.setString(1,b);
    	pst4.setString(2,a);
    	pst4.executeUpdate();
    	
    }
    if(d !=null && e!=null){
    	
    	// Update database on addition of sub- department
    	
    	g = e.substring(0, e.length()-1) + name;
    	PreparedStatement pst40;
    	String sql40 = "INSERT INTO "+g +" VALUES (?, ?)";
    	pst40= conn.prepareStatement(sql40);
    	pst40.setString(1,e);
    	pst40.setString(2,d);
    	pst40.executeUpdate();
    }
    
    if(f!=null){
		// Update database on deletion of sub-department
		PreparedStatement pst50;
		h = f.substring(0, f.length()-1) + name;
    	String sql50 = "DELETE FROM "+ h + " WHERE ID=?";
    	pst50= conn.prepareStatement(sql50);
    	pst50.setString(1,f);
    	pst50.executeUpdate();
    	
	}
    
    %>
		
		<% 
		
	PreparedStatement pst;
	String sql = "SELECT * FROM public.display_"+name; // Select departments which are to be displayed in the menu
	pst= conn.prepareStatement(sql);
	ResultSet rs= pst.executeQuery();
	ResultSetMetaData meta = rs.getMetaData();
	String temp;
	String temp1,temp2;
	%> 
	
	<br><br><br><br>
<ul id='menu'>
<%while(rs.next()){
	temp2=rs.getString(2);
%>
        <li value="<%=temp2%>"><a href="#"><%out.println(rs.getString(2));
        	temp=rs.getString(1);
        	String sql1 = "SELECT * FROM public."+temp+name; // Select sub-departments table
            PreparedStatement pst1;
        	pst1= conn.prepareStatement(sql1);
        	ResultSet rs1= pst1.executeQuery(); 
        	
        	String sql11 = "SELECT count(*) FROM public."+temp+name; // Select sub-departments table
            PreparedStatement pst11;
        	pst11= conn.prepareStatement(sql11);
        	ResultSet rs11= pst11.executeQuery(); 
        	rs11.next();
        	int count=rs11.getInt(1);
        %></a>
        
        <ul id='submenu'>
        <%
         //Select all sub-departments
    	if(count==0){%>
    		<li>
    		<div style="background-color:rgb(224,211,250);">
    		<div class="btn-group">
    		
 			<button class="button" onclick="subdel()"><i class="fa fa-trash"></i>Delete</button>
 			 <button class="button" onclick="subadd()"><i class="fa fa-plus-square"></i> Add </button>
 			 </div>
  			</div>
  			
  			</li>
    	<%}
        while(rs1.next()){
        	temp1=rs1.getString(1);
        %>
        	<li value="<%=temp1%>" ><a href="#"><%out.println(rs1.getString(2));%></a>
        	<div >
  			<div style="background-color:rgb(224,211,250);">
			<div class="btn-group">
 			<button class="button" onclick="subdel()"><i class="fa fa-trash"></i>Delete</button>
 			 <button class="button" onclick="subadd()"><i class="fa fa-plus-square"></i> Add </button></div>
  			</div>
  			</div>
  			</li>
        <%}
        %>   

        </ul>
  	
    

        </li>

           <%} %>

    </ul>
    <br>
    <div style="margin-left:80%; margin-bottom:2%;margin-top:4%;">
 
	<div class="btn-group">
	<br>
	<br>
  <button class="button" onclick="del()"><i class="fa fa-trash"></i>Delete</button>
  <button class="button" onclick="add()"><i class="fa fa-plus-square"></i> Add </button></div>
  </div>
  <center>
  <div id="firstmap">
  	
  </div>
  </center>
    <!-- Pop up Addition of Department -->
    
    <div id="adddept" style="display:none">
    <h4>Add Department</h4> <br>
    	<form action="#" method="post">
			 
			Department Name: 
			  <input type="text" name="menuname"  required>
			  <br> <br>	
			  Select Department: 
	  <select name="dept" style="width:43%;">
	  <%
	  ResultSet rs2= pst2.executeQuery();
		ResultSet rs3= pst3.executeQuery();
	  while(rs2.next()){
		  val1=rs2.getString(1);
	  %>
	    <option value="<%=val1 %>"><%out.println(rs2.getString(2));%></option>
	     <% }%>
	  </select>
  <br><br>
  <input type="submit" class="btn btn-success" value="Submit">
  <button type="button" class="btn btn-danger" onclick="cancel()">Cancel</button>
</form>
    
    </div> 
    
    <!-- Pop up Deletion of Department-->
    
<div id="deldept" style="display:none">
<h4>Delete Department</h4> <br>
    	<form action="#" method="post">
			 	
	  <select name="ddept" style="width:43%;">
	  <%while(rs3.next()){
		  val2=rs3.getString(1);
	  %>
	    <option value="<%=val2 %>"><%out.println(rs3.getString(2));%></option>
	     <% }%>
	  </select>
  <br><br>
	 <input type="submit" class="btn btn-success" value="Submit"> 
     <button type="button" class="btn btn-danger" onclick="cancel()">Cancel</button>
 
</form>
 
 
 
    </div> 
     
    <script>
	   var d = "";
	   
	    var d = "";
	    $("#menu li").mouseover(function() {
	       d=$(this).attr('value');
	       document.cookie = "visits="+d+"; path=/;";
	      
	       //alert(document.cookie);
	     
	    });
	   
  </script> 
  <%
  Cookie[] cookies = request.getCookies();
String dept="";

  if (cookies != null) {
   for (Cookie cookie : cookies) {
     if (cookie.getName().equals("visits")) {
    	 
       	dept=cookie.getValue();
      }
    }
  }
  
  %>
     <!-- Pop up Addition of Sub-Department-->
    
    <div id="asubdept" style="display:none">
	<%out.println(dept); %>
      <form action="#" method="post">
    Sub-Department Name: 
			  <input type="text" name="subname"  required>
			  <br> <br>	
			  Select Sub-Department: 
	   <select name="subadept" style="width:43%;">
	  <% 
	  rs3= pst3.executeQuery();
	  while(rs3.next()){
		  val2=rs3.getString(1);
		  String sql10 = "SELECT * FROM public."+val2 + " where id not in (select id from " +val2+" natural join " +val2 + name+")"; 
          PreparedStatement pst10;
      	pst10= conn.prepareStatement(sql10);
      	ResultSet rs10= pst10.executeQuery(); 
      	while(rs10.next()){
      		val1=rs10.getString(1);
      		 %>
     	    <option value="<%=val1 %>"><%out.println(rs10.getString(2));%></option>
     	     <% 
      	}
	  }
	  %>
	  </select>
	  <br> <br>
	   <input type="submit" class="btn btn-success" value="Submit" > 
     <button type="button" class="btn btn-danger" onclick="cancel()">Cancel</button>
	  </form>
    </div> 
    
     <!-- Pop up Deletion of Sub-Department-->
   
     <div id="dsubdept" style="display:none">
    <h4>Delete Sub-Department</h4> <br>
    	<form action="#" method="post">
    
	   <select name="subddept" style="width:43%;">
	  <% 
	  rs3= pst3.executeQuery();
	  while(rs3.next()){
		  val2=rs3.getString(1);
		  String sql10 = "SELECT * FROM public."+val2+name; 
          PreparedStatement pst10;
      	pst10= conn.prepareStatement(sql10);
      	ResultSet rs10= pst10.executeQuery(); 
      	while(rs10.next()){
      		val1=rs10.getString(1);
      		 %>
     	    <option value="<%=val1 %>"><%out.println(rs10.getString(2));%></option>
     	     <% 
      	}
	  }
	  %>
	  </select>
	  <br> <br> 
	   <input type="submit" class="btn btn-success" value="Submit" > 
     <button type="button" class="btn btn-danger" onclick="cancel()">Cancel</button>
	  </form>
	  
    </div> 
    
	<!-- Div to display map -->
    <div style="width:50%; height:50%; visibility: hidden;" id="map" >
    </div>
   
<script defer="defer" type="text/javascript">
// Display map from geoserver using open layers
// function to make map visible

// function to display addition of department dropdown 
var m="<%=m%>";
var mode="<%=mode%>";
function add(){
	document.getElementById("map").style.display = "none"; 
	document.getElementById("adddept").style.display = "inline-block";
	document.getElementById("deldept").style.display = "none"; 
	document.getElementById("firstmap").style.display = 'none';
	document.getElementById("asubdept").style.display = "none";
	document.getElementById("dsubdept").style.display = "none";
}

//function to display deletion dropdown
function del(){
	document.getElementById("map").style.display = "none"; 
	document.getElementById("deldept").style.display = "inline-block";
	document.getElementById("adddept").style.display = "none"; 
	document.getElementById("firstmap").style.display = 'none';
	document.getElementById("asubdept").style.display = "none";
	document.getElementById("dsubdept").style.display = "none";
}
//function to display addition of sub-department dropdown 
function subadd(){
	
	document.getElementById("map").style.display = "none"; 
	document.getElementById("deldept").style.display = "none";
	document.getElementById("adddept").style.display = "none"; 
	document.getElementById("asubdept").style.display = "inline-block"; 
	document.getElementById("dsubdept").style.display = "none";
	document.getElementById("firstmap").style.display = 'none';

	
}

//function to display deletion of sub-department dropdown

function subdel(){
	document.getElementById("map").style.display = "none"; 
	document.getElementById("deldept").style.display = "none";
	document.getElementById("adddept").style.display = "none"; 
	document.getElementById("dsubdept").style.display = "inline-block"; 
	document.getElementById("asubdept").style.display = "none";
	document.getElementById("firstmap").style.display = 'none';
	
}

// Function to return to page after cancel is pressed either from add/delete window
function cancel(){
	var test= window.location.href; // get current page url
	var lastChar = test.substr(test.length -1); 
	if(lastChar=="#"){
		var newStr = test.substring(0, test.length-1);
		window.location.replace(newStr);
	}
	else{
	 window.location.replace(test);
	}
}
// Return to first page to choose another district
function back(){
	window.location.replace("Welcome.jsp?mode="+m);
}
function login(){
	var test= window.location.href; // get current page url
	var lastChar = test.substr(test.length -1); 
	if(lastChar=="#"){
		test = test.substring(0, test.length-12);
	}
	else{
	 	test = test.substring(0, test.length-11);
	}
	if(mode=="admin"){
		test+="genjcjernjrj";
		window.location.replace(test);
	}
	else if(mode=="guest"){
		window.location.replace('login.jsp');
	}
}

//display map

var map = new OpenLayers.Map('map');
var state="<%=state%>";
var wms;
$("#submenu li").click(function() {
  var id = $(this).attr('value');
	//alert(id);
	if (wms) {
     window.map.removeLayer(wms);
  }
	var cql_filter="st_nm='"+state+ "'";
	wms = new OpenLayers.Layer.WMS( "OpenLayers WMS",
	    "http://localhost:8083/geoserver/wms", {layers: [id], 'CQL_Filter': cql_filter}    );
	map.addLayer(wms);
	map.zoomToMaxExtent();
	document.getElementById("firstmap").style.display = 'none';
	document.getElementById("map").style.visibility = 'visible';
 
});
var map1 = new OpenLayers.Map('firstmap');
var wms1;
	
var state1="<%=state%>";
var cql_filter1="st_nm='"+state1+ "'";
		wms1 = new OpenLayers.Layer.WMS( "OpenLayers WMS",
	    "http://localhost:8083/geoserver/wms", {layers: 'india:india', 'CQL_Filter': cql_filter1}    );
	map1.addLayer(wms1);
	map1.zoomToMaxExtent();
	
document.getElementById("firstmap").style.visibility = 'visible';
 




 

</script>
</body>
</html> 

