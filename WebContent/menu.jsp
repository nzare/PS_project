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
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  
  <!-- Styling  -->
<style>
ul {
 margin: 0;
 padding: 0;
 list-style: none;
 width: 150px;
 border-bottom: 1px solid #ccc;
 float:right;
 }
 
 ul li {
 position: relative;
 }
li ul {
 position: absolute;
 right:150px;
 top: 0;
 display: none;
 }
 li:hover ul{ display:block;}
ul li a {
 display: block;
 text-decoration: none;
 color: #777;
 background: #fff;
 padding: 5px;
 border: 1px solid #ccc;
 border-bottom: 0;
 }
</style>

<title>Menus</title>

<!-- Including Open Layers Library -->
<script src="http://openlayers.org/api/OpenLayers.js"></script>

</head>
<body>
<h2> District: 
<%

// Display the name of district selected
String name=request.getParameter("name");
if(name!=null){
out.println(name);
}
%>
</h2>
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
		String sql2 = "select * from alldept where id not in (select id from alldept natural join district_x)"; // Select all districts for addition option
		String sql3 = "SELECT * FROM public.district_x "; // Select districts present in menu for deletion option
		pst2= conn.prepareStatement(sql2);
		pst3= conn.prepareStatement(sql3);
		ResultSet rs2= pst2.executeQuery();
		ResultSet rs3= pst3.executeQuery();
		String val1,val2;
		%>
		 <%        
    String a = request.getParameter("menuname");
	String b = request.getParameter("dept");
	String c = request.getParameter("ddept");
	if(c!=null){
		PreparedStatement pst5;
    	String sql5 = "DELETE FROM district_x WHERE ID=?";
    	pst5= conn.prepareStatement(sql5);
    	pst5.setString(1,c);
    	pst5.executeUpdate();
	}
    if(a != null && b!=null){
    	PreparedStatement pst4;
    	String sql4 = "INSERT INTO district_x VALUES (?, ?)";
    	pst4= conn.prepareStatement(sql4);
    	pst4.setString(1,b);
    	pst4.setString(2,a);
    	pst4.executeUpdate();
    	
    }
    %>
		<!-- Drop Down for addition of menu -->
		
		<div id="adddept" style="visibility:hidden;">
		<form action="#" method="post">
			 
			Name:<br>
			  <input type="text" name="menuname" placeholder="MenuName" required>
			  <br> <br>	
	  <select name="dept">
	  <%while(rs2.next()){
		  val1=rs2.getString(1);
	  %>
	    <option value="<%=val1 %>"><%out.println(rs2.getString(2));%></option>
	     <% }%>
	  </select>
  <br><br>
  <input type="submit" value="Submit">
</form>
			
			
		</div>
		<!-- Drop Down for deletion of menu -->
			<div id="deldept" style="visibility:hidden;">
		<form action="#" method="post">
			 	
	  <select name="ddept">
	  <%while(rs3.next()){
		  val2=rs3.getString(1);
	  %>
	    <option value="<%=val2 %>"><%out.println(rs3.getString(2));%></option>
	     <% }%>
	  </select>
  <br><br>
  <input type="submit" value="Submit">
</form>
			
			
		</div>
		<% 
		
	PreparedStatement pst;
	String sql = "SELECT * FROM public.district_x "; // Select departments which are to be displayed in the menu
	pst= conn.prepareStatement(sql);
	ResultSet rs= pst.executeQuery();
	ResultSetMetaData meta = rs.getMetaData();
	String temp;
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
    	
        while(rs1.next()){%>
        	<li id="<%rs1.getString(1);%>" onclick="myFunction()"><a href="#"><%out.println(rs1.getString(1));%></a></li>
        <%}
        %>   

        </ul>


        </li>

           <%} %>

    </ul>
    
    
    <!-- buttons for addition and deletion option -->
    
    <button type="button" class="btn btn-warning" onclick="add()">Add</button>
  	<button type="button" class="btn btn-danger" onclick="del()">Delete</button>
	<div style="visibility:hidden;">
	
</div>
	<!-- Div to display map -->
    <div style="width:50%; height:50%; visibility: hidden;" id="map" >
    </div>
  
<script defer="defer" type="text/javascript">
// Display map from geoserver using open layers
var map = new OpenLayers.Map('map');
var wms = new OpenLayers.Layer.WMS( "OpenLayers WMS",
    "http://localhost:8083/geoserver/wms", {layers: 'ind:ind'}     );
map.addLayer(wms);
map.zoomToMaxExtent();

// function to make map visible

function myFunction() {
  document.getElementById("map").style.visibility = 'visible';
}

// function to display addition dropdown 
function add(){
	document.getElementById("map").style.visibility = 'hidden';
	document.getElementById("adddept").style.visibility = 'visible';
	document.getElementById("deldept").style.visibility = 'hidden';
}

//function to display deletion dropdown
function del(){
	document.getElementById("map").style.visibility = 'hidden';
	document.getElementById("deldept").style.visibility = 'visible';
	document.getElementById("adddept").style.visibility = 'hidden';
}

</script>
</body>
</html> 
