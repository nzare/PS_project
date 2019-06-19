<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSetMetaData" %>
<html>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
h3
{
font-family:verdana;
text-color:red;
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
    background: #FF6223;
    color: #FFFFFF;
    border: none;
    margin: 0;
    padding: 0.4em 0.8em;
    font-size: 1em;
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
</style>
<head>
<meta charset="ISO-8859-1">
<title>Java CMS</title>
</head>
<body>
<h3> Welcome to CMS</h3>
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
	<div class="dropdown">
<!-- Select district from dropdown -->

    <button>Select District</button>

    <ul class="dropdown-menu" id='myid'>
    <%while(rs.next()){%>
        <li id="<%rs.getString(2);%>"><a href="#"><%out.println(rs.getString(2));%></a></li>

           <%} %>
    </ul>
    </center>
</div>

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



