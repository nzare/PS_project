<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSetMetaData" %>
<html>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

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
 font-weight: 900;
 width: 100%;
 height: 100%;
 margin: 0;
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
<div class="my-container">

<div class="welcome">
<h5>Welcome to CMS. Select a district to continue...</h5>
</div>
<%
//Connect to database postgresql
Class.forName("org.postgresql.Driver");
Connection conn=null;
		
		String url = "jdbc:postgresql://localhost:5432/CMS";
		String user ="postgres";
		String password = "geoserver";
		conn= DriverManager.getConnection(url,user,password);
	PreparedStatement pst;
	String sql = "SELECT * FROM public.master "; // Select districts from master table postgresql
	pst= conn.prepareStatement(sql);
	ResultSet rs= pst.executeQuery();
	ResultSetMetaData meta = rs.getMetaData();
	int colCount = meta.getColumnCount(); // get no of columns
	%> 
	<br> <br>
<center>
	<div class="dropdown" style="margin-top:10%; width: 40%;">
	
<!-- Select district from dropdown -->

    <button style="width: 100%; font-family: "Lucida Console", Monaco, monospace;"><b><em>
    Select District</em></b></button>

    <ul class="dropdown-menu" id='myid'>
    <%while(rs.next()){%>
        <li id="<%rs.getString(2);%>"><a href="#"><b><em><%out.println(rs.getString(2));%></em></b></a></li>

           <%} %>
    </ul>
    </div>
	</div>
	
</center>

<script>
$("#myid li").click(function() {
   var v=$(this).text(); // get text contents of clicked li
   if (window.confirm("You selected district: " + v +"Do you want to continue?")) { 
	  window.location.replace("menu.jsp?name="+v);
	  //reconfirmation window
	  // Visit menus page only if user press Yes 
	  // If user press No, it stays on the same page
	}
  
});
</script>

 

<br><br>

</body>
</html>



