<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSetMetaData" %>

<html>
<head>
<meta charset="ISO-8859-1">

<title>Login</title>

<!-- Linking Bootstarp and JQuery -->

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

</head>

<!-- Styling  -->
<style>

@import url('https://fonts.googleapis.com/css?family=Numans');

html,body{
background-image: url('CMS_login.jpg');
background-size: cover;
background-repeat: no-repeat;
height: 100%;
font-family: 'Numans', sans-serif;
}

.container{
height: 100%;
align-content: center;
}

.card{
height: 370px;
margin-top: auto;
margin-bottom: auto;
width: 400px;
background-color: rgba(0,0,0,0.7) !important;
}

.card-header h3{
color: white;
}

.input-group-prepend span{
width: 50px;
background-color: #FFC312;
color: black;
border:0 !important;
}

input:focus{
outline: 0 0 0 0  !important;
box-shadow: 0 0 0 0 !important;

}

.remember{
color: white;
}

.remember input
{
width: 20px;
height: 20px;
margin-left: 15px;
margin-right: 5px;
}

.login_btn{
color: black;
background-color: #FFC312;
width: 100px;
}

.login_btn:hover{
color: black;
background-color: white;
}

.links{
color: white;
}

.links a{
margin-left: 4px;
}

</style>

	<title>Login Page</title>
 
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
 
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">


	<!--Custom styles-->
	<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<%
	//Get username and password
	
	String user_name=request.getParameter("username");  
	String pass=request.getParameter("password");
	
	String mode="guest"; // Default mode is Guest Mode
	
	if(user_name!=null && pass !=null ){
		//Connect to postgreSQL database
		
		Class.forName("org.postgresql.Driver");
		Connection conn=null;
				
				String url = "jdbc:postgresql://localhost:5432/CMS";
				String user ="postgres";
				String password = "geoserver";
				conn= DriverManager.getConnection(url,user,password);
				
				//Check for credentials 
				
				PreparedStatement pst;
				String sql = "SELECT count(*) FROM public.users where username=? and password=crypt(?,password)"; 
				pst= conn.prepareStatement(sql);
				pst.setString(1,user_name);
				pst.setString(2, pass);
				ResultSet rs= pst.executeQuery();
				rs.next();
	        	int count=rs.getInt(1);
				if(count==0){
				%>
				
				<div class="d-flex justify-content-center " style="color:red;">
					<br><br>Invalid Credentials
				</div>
				
				<% 
			}
			else{
				mode="admin";
				%>
				<script>window.location.replace("Welcome.jsp?mode=ahjdeifirnf");</script>
				
				<% 
			}
	}

%>
<!-- Login  -->

<div class="container">
	<div class="d-flex justify-content-center h-100">
		<div class="card">
			<div class="card-header">
				<h3>Admin Sign In</h3>
				
			</div>
			<div class="card-body">
				<form action="#" method="post">
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-user"></i></span>
						</div>
						<input type="text" name="username" class="form-control" placeholder="username" required>
						
					</div>
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-key"></i></span>
						</div>
						<input type="password" name="password" class="form-control" placeholder="password" required>
					</div>
					
					<div class="form-group">
						<input type="submit" value="Login" class="btn float-right login_btn">
					</div>
				</form>
				<br><br><br>
				<div class="d-flex justify-content-center">
					<button type="button" class="btn btn-outline-warning" onclick="guestmode()">Continue as Guest</button>
				</div>
			</div>
			
				
				
			
		</div>
	</div>
</div>
<script>

//If user press guest button

function guestmode(){
	window.location.replace("Welcome.jsp?mode=genjcjernjrj");
}

</script>
</body>

</html>
