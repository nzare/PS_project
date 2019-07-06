<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSetMetaData" %>

<html>
<!-- Linking various stylesheets ,fonts and Js -->

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- Styling  -->
<style>
body{
	 background-image:url("cms.jpg");
     height: 100%; 
     background-position: center;
     background-size: cover;
     background-repeat:no-repeat;
}
h3
{
font-family:Raleway;
font-size:40px;
text-align: center;

}
.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown .dropdown-menu {
    position: absolute;
    top: 100%;
    display: none;
    margin: 0;
    list-style: none; /** Remove list bullets */
    width: 100%; /** Set the width to 100% of it's parent */
    padding: 0;
}

.dropdown:hover .dropdown-menu {
    display: block;
}

/** Button Styles **/
.dropdown button {
    background: #cc3399;
    color: #FFFFFF;
    border: none;
    margin: 0;
    padding: 0.4em 0.8em;
    font-size: 1.2em;
    
}

/** List Item Styles **/
.dropdown a {
    display: block;
    padding: 0.2em 0.8em;
    text-decoration: none;
    background: #CCCCCC;
    color: #333333;
}

/** List Item Hover Styles **/
.dropdown a:hover {
    background: #BBBBBB;
}
}

/* Scroll text effect*/
.welcome {
 height: 50px;	
 overflow: hidden;
 position: relative;
}
.welcome h5 {
 font-size: 1.5em;
 color: #ff0000;
 position: absolute;
 font-weight: 800;
 width: 100%;
 height: 100%;
 margin-top: 20px;
 line-height: 50px;
 text-align: center;
 /* Starting position */
 -moz-transform:translateX(100%);
 -webkit-transform:translateX(100%);	
 transform:translateX(100%);
 /* Apply animation to this element */	
 -moz-animation: welcome 0.5s linear infinite;
 -webkit-animation: welcome 0.5s linear infinite;
 animation: welcome 12s linear infinite;
}
/* Move it (define the animation) */
@-moz-keyframes welcome {
 0%   { -moz-transform: translateX(100%); }
 100% { -moz-transform: translateX(-100%); }
}
@-webkit-keyframes welcome {
 0%   { -webkit-transform: translateX(100%); }
 100% { -webkit-transform: translateX(-100%); }
}
@keyframes welcome {
 0%   { 
 -moz-transform: translateX(100%); /* Firefox bug fix */
 -webkit-transform: translateX(100%); /* Firefox bug fix */
 transform: translateX(100%); 		
 }
 100% { 
 -moz-transform: translateX(-100%); /* Firefox bug fix */
 -webkit-transform: translateX(-100%); /* Firefox bug fix */
 transform: translateX(-100%); 
 }
}
</style>

<head>
<meta charset="ISO-8859-1">
<title>Java CMS</title>
</head>
<body>


<%
String mode=request.getParameter("mode"); //Get mode from url of previous page redirect

if(mode==null){
	mode="guest";  //Check if user tries to visit this page directly
}
else if(mode.equals("ahjdeifirnf")){
	mode="admin";
}
else{
	mode="guest";
}
// Connect with database

Class.forName("org.postgresql.Driver");
Connection conn=null;
		
		String url = "jdbc:postgresql://localhost:5432/CMS";
		String user ="postgres";
		String password = "geoserver";
		conn= DriverManager.getConnection(url,user,password);
		
	PreparedStatement pst;
	String sql = "SELECT * FROM public.master "; // Select states from master table postgresql
	pst= conn.prepareStatement(sql);
	ResultSet rs= pst.executeQuery();
	ResultSetMetaData meta = rs.getMetaData();
	int colCount = meta.getColumnCount(); 
	String temp;
	// get no of columns
	%> 
	<br>
	<!-- If guest mode then give option to sign In -->
	
	<% if(mode.equals("guest")){%>
	<div class="float-left" >
	<button type="button" class="btn btn-secondary btn-sm" onclick="back_button()"><i class="fa fa-sign-in" aria-hidden="true"></i>Admin Sign In</button>
	
	</div>
	<%} 
	
	//If Admin mode then option to Sign Out 
	
	if(mode.equals("admin")){%>
	<div class="float-left" >
	<button type="button" class="btn btn-secondary btn-sm" onclick="back_button()"><i class="fa fa-sign-out" aria-hidden="true"></i>Sign Out</button>
	
	</div>
	<%} %>
	
	<!-- Welcome guest/admin -->
	
	<div class="float-right" >
	<% out.println("Welcome " + mode);%>
	
	</div>
	<div class="my-container">
<br>

<div class="welcome">
<h5>Welcome to CMS. Select a state to continue...</h5>
</div>
	<br> <br>
<center>

	<div class="dropdown" style="margin-top:10%; width: 40%;">
	
<!-- Select state from dropdown -->

    <button style="width: 100%; font-family: "Lucida Console", Monaco, monospace;"><b><em>
    Select State</b></button>

    <ul class="dropdown-menu" id='myid'>
    <%while(rs.next()){
    	temp=rs.getString(1);
    %>
        <li id="<%=temp%>"><a href="#"><b><em><%out.println(rs.getString(2));%></em></b></a></li>

           <%} %>
    </ul>
    </div>
	</div>
	
</center>


<script>
var m="<%=mode%>";
$("#myid li").click(function() {
   var v=this.id; // get text contents of clicked li
   var q=$(this).text();
   
   if (window.confirm("You selected state: " + q +"Do you want to continue?")) { 
	   if(m=="guest"){
		   window.location.replace("menu.jsp?name="+v+"&&mode=genjcjernjrj");
	   }
	   else{
		   window.location.replace("menu.jsp?name="+v+"&&mode=ahjdeifirnf");
	   }
	  //reconfirmation window
	  // Visit menus page only if user press Yes 
	  // If user press No, it stays on the same page
	  //Store information in url regarding state selected and mode
	}
  
});

//To go back to login page

function back_button(){
	var test= window.location.href; // get current page url
	var lastChar = test.substr(test.length -1); 
	if(lastChar=="#"){
		test = test.substring(0, test.length-12);
	}
	else{
	 	test = test.substring(0, test.length-11);
	}
	if(m=="admin"){
		test+="genjcjernjrj";
		window.location.replace(test);
	}
	else if(m=="guest"){
		window.location.replace('login.jsp');
	}
}
</script>

 

<br><br>

</body>
</html>



