<%@ page import="java.io.*,java.lang.*,java.util.*,java.net.*,java.util.*,java.text.*"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.nodes.Element"%>
<%@ page import="org.jsoup.select.Elements"%>
<%@ page import="org.jsoup.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import= "org.openqa.selenium.JavascriptExecutor"%>
<%@ page import= "org.openqa.selenium.WebDriver"%>
<%@ page import="org.openqa.selenium.chrome.ChromeDriver"%>
<HTML>
    <HEAD>
        <TITLE>Login using JSP</TITLE>
    </HEAD>
 
    <BODY>
        <H1>LOGIN FORM</H1>
        <%
        String myname =  (String)session.getAttribute("username");
        
        if(myname!=null)
            {
             out.println("Welcome  "+myname+"  , <a href=\"logout.jsp\" >Logout</a>");
            }
        else 
            {
            %>
            <form action="Welcome.jsp">
                <table>
                    <tr>
                        <td> Username  : </td><td> <input name="username" size=15 type="text" /> </td> 
                    </tr>
                    <tr>
                        <td> Password  : </td><td> <input name="password" size=15 type="text" /> </td> 
                    </tr>
                </table>
                <input type="submit" value="Login" />
            </form>
            <% 
            }
         
             
            %>
         
    </BODY>
</HTML>