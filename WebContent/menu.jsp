<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSetMetaData" %>
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
 .btn-group .button {
  /*margin-left:57.1em;
  margin-top:2em;
  margin-bottom: 1.5em;*/
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

</style>

<title>Menus</title>

<!-- Including Open Layers Library -->
<script src="http://openlayers.org/api/OpenLayers.js"></script>

</head>
<body>
 
<%
// Display the name of district selected
String name=request.getParameter("name");
if(name!=null){
%>

<!-- Heading -->

<center><h2 style="font:Raleway;"> <i class="fa fa-map-o"></i>  <i class="fa fa-map-marker"></i>
 District: <b><% out.println(name);%></b></h2></center>
<% }
%>

<!-- Back button -->
<button type="button" onclick="back()" style="background-color:Dodgerblue; border: none;color: white;padding: 10px 22px;text-align: center;
  text-decoration: none;display: inline-block;font-size: 14px;cursor: pointer; position:relative;">
  Choose Another District</button>
</h2>


<!-- Addition and deletion buttons -->

<div style="margin-left:80%; margin-bottom:2%;margin-top:3%;">
	<div class="btn-group">
  <button class="button" onclick="del()"><i class="fa fa-trash"></i>Delete</button>
  <button class="button" onclick="add()"><i class="fa fa-plus-square"></i> Add </button></div>
  </div>
<%

//Connect to database postgresql
Class.forName("org.postgresql.Driver");
Connection conn=null;
		
		String url = "jdbc:postgresql://localhost:5432/CMS";
		String user ="postgres";
		String password = "geoserver";
		conn= DriverManager.getConnection(url,user,password); 
		
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
	
	
	if(c!=null){
		// Update database on deletion
		PreparedStatement pst5;
    	String sql5 = "DELETE FROM display_" +name+ " WHERE ID=?";
    	pst5= conn.prepareStatement(sql5);
    	pst5.setString(1,c);
    	pst5.executeUpdate();
    	
	}
    if(a != null && b!=null){
    	
    	//Update database on addition
    	PreparedStatement pst4;
    	String sql4 = "INSERT INTO display_"+name +" VALUES (?, ?)";
    	pst4= conn.prepareStatement(sql4);
    	pst4.setString(1,b);
    	pst4.setString(2,a);
    	pst4.executeUpdate();
    	
    }
    %>
		
		<% 
		
	PreparedStatement pst;
	String sql = "SELECT * FROM public.display_"+name; // Select departments which are to be displayed in the menu
	pst= conn.prepareStatement(sql);
	ResultSet rs= pst.executeQuery();
	ResultSetMetaData meta = rs.getMetaData();
	String temp;
	String temp1;
	%> 
<ul>
<%while(rs.next()){%>
        <li id="<%rs.getString(2);%>"><a href="#"><%out.println(rs.getString(2));
        	temp=rs.getString(1);
        	String sql1 = "SELECT * FROM public."+temp; // Select sub-departments table
            PreparedStatement pst1;
        	pst1= conn.prepareStatement(sql1);
        	ResultSet rs1= pst1.executeQuery(); 
        %></a>
        
        <ul id='submenu'>
        <%
         //Select all sub-departments
    	
        while(rs1.next()){
        	temp1=rs1.getString(1);
        %>
        	<li value="<%=temp1%>" ><a href="#"><%out.println(rs1.getString(2));%></a></li>
        <%}
        %>   

        </ul>
  	
    

        </li>

           <%} %>

    </ul>
  
    <!-- Pop up Addition -->
    
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
    
    <!-- Pop up Deletion -->
    
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
  
	<!-- Div to display map -->
    <div style="width:50%; height:50%; visibility: hidden;" id="map" >
    </div>
    
  
<script defer="defer" type="text/javascript">
// Display map from geoserver using open layers
// function to make map visible

// function to display addition dropdown 
function add(){
	document.getElementById("map").style.display = "none"; 
	document.getElementById("adddept").style.display = "inline-block";
	document.getElementById("deldept").style.display = "none"; 
	document.getElementById("submit1").style.display = "none";
	document.getElementById("submit2").style.display = "none";
}

//function to display deletion dropdown
function del(){
	document.getElementById("map").style.display = "none"; 
	document.getElementById("deldept").style.display = "inline-block";
	document.getElementById("adddept").style.display = "none"; 
	document.getElementById("submitadd").style.display = "none";
	document.getElementById("submitdel").style.display = "none";
}
// Function to return to page after cancel is pressed either fro add/delete window

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
	 window.location.replace("Welcome.jsp");
}

var map = new OpenLayers.Map('map');
var wms;
$("#submenu li").click(function() {
  var id = $(this).attr('value');
	//alert(id);
	if (wms) {
     window.map.removeLayer(wms);
  }
	wms = new OpenLayers.Layer.WMS( "OpenLayers WMS",
	    "http://localhost:8083/geoserver/wms", {layers: [id]}     );
	map.addLayer(wms);
	map.zoomToMaxExtent();
	
document.getElementById("map").style.visibility = 'visible';
 
});

</script>
</body>
</html> 
