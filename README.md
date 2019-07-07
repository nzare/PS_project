# PS1 Project
## Content Management System
### A Java based dynamic Content Management System(CMS) to retrieve geo-spatial data from database dynamically and display maps providing flexibility to add and delete departments/sub-departments and manage data for large number of districts or states in admin mode. It is developed using Java, Geoserver, Tomcat Apache, OpenLayers, PostgreSQL and JSP.


### Configuration:
1. Tomcat Apache v9.0: port 8080
2. Geoserver  v2.15.1: port 8083
3. PostgreSQL v11.3: port 5432  
4. pgAdmin v4.6 
5. Eclipse IDE EE for Java and JSP 
6. OpenLayers v5.03 

### Details of Software/Technologies used:
**Tomcat Apache**: An open source software used to deploy java servlet and Java Server Pages(JSP). This software was deployed on tomcat apache.

**Geoserver**: Geoserver is an open source server writtenn in java that allows to share , edit, process geo-spatial data. It is used in the CMS to get maps of various sub-departments.

**PostgreSQL**: An open source object-oriented relational database management system for storing geo-spatial data to load the same in geoserver and information of departments and sub-departments.

**pgAdmin**: User Interface for postgreSQL with query tool for easy access of database.

**Eclipse**: IDE for java development.

**OpenLayers**: A javascript library used with geoservers to display maps in browsers and allow their styling.

### Additional technologies used:
* JDBC (Java Database Connectivity): For connecting Java servlet to postgreSQL
* Javascript: Various functionalitites of web-page
* HTML, CSS, Bootstrap: For making the User Interface
* JSP (Java Server Pages): Main software tool
* PostGIS: Plugin of postgreSQL for coverting geo-spatial data into postgreSQL tables
* CQL (Common Query Language): For displaying part of the map dynamically
* pgcrypto: For password encryption in postgreSQL
* JQuery: Plugin of Javascript for additional functionality
* PostGIS 2.0 ShapeFile and DBF file loader: For loading shape file *(.shp)* in PostGIS.

### Details of the project:
* The first page that user sees is the **login page**. There are two options on login page: **admin** and **guest** mode. The admin needs to login with credentials to get admin rights whereas guest can continue.

* The next page is **Welcome page** providing user option to choose state/district to continue to next page. The page also has option to sign out for admin and sign in for guest.

* The next page is **Menus page** which is the main page to display all maps. As soon as the page is loaded the map of district/state selected is displayed. This page also contains sign out option for admin mode and sign in option for guest mode and choose another state/district for both of them to change their selection.

* The menus on this page contains various departments of the selected district/state and displays its sub-departments on mouse hover. The map of respective sub-department is displayed on selecting it.

* The maps and menus/submenus are only displayed for the guest mode.

* In admin mode the user has option to add/delete department which he wants to show in the menu. Further the user can also add/delete sub-department. For addition of department/sub-department user selects it from the drop down and enters name which will get displayed.
For deletion of department/sub-department user just selects it from the dropdown. 

### Database Structure: 
* Name of database used is **CMS**
* Users table for login
* A master table that maps every state/district with a unique id
* An all departments table for storing information of all departments that we have information of each mapped to an id of format *d_*.
* Tables loaded by PostGIS containing geo-spatial data.
* A ddisplay table for each state containing department which are displayed in their menu.
* Tables for each department conatining all sub-departments that we have information about each mapped to an id of format *d__*.
* Tables for eah department of very district/state that is displayed in the menu.

### Methodology:
* For the admin login, some users have been created in *users* table of postgreSQL and password is encrypted by storing it using **pgcrypto**. Whenever a user enters credentials, **JDBC** connects to postreSQL database **CMS** and username is matched and password is decrypted and matched. If credentials are correct the user is send to next page otherwise error message of *Invalid Credentials* is displayed. On continuing with guest mode the user is just directed to next mode. The information of admin and guest is stored in url and send to next page.

* The mode is whether admin/guest is checked on the Welcome page and option to sign in/sign out is displayed accordingly. The sign in brings user back to login page and logout just changes mode from admin to guest.

* Welcome page connects to postgreSQL database CMS through JDBC and displays drop down to select state/district from master's table. The selected district/state is passed to next page through url.

* The mode of user is checked again and also the state/district selected by the user. The database CMS is connected and the menu of department is displayed from the respective display table and sub-departments from the respective sub-departments table. 

* A map of respective district/state is displayed on the page. The shape file for displaying map is loaded in PostgreSQL by **Import/Export shape file loader** and **PostGIS** process the data from shape file in form of table. In geoserver a layer and workspace is created for the map. There is an option to add stores in geoserver where data from PostGIS can be loaded. Thus a map is generated. The the map is created in OpenLayers in Javascript and **wms** layer from geoserver is added to it. 

* The code for maps is same for displaying every sub-department or main main of state/district. The different maps are called based on the mapping from id.

* The maps of department are of India but only part of them needs to be shown to user on basis of state/district he selected. This is done by using **CQL** . The respective state/district is passed as string and only part of map is displayed.

* On selecting any sub-department respective map is displayed.

* There are additional functionality for admin mode that allows addition and deletion of departments.

* **Addition of Department**: For addition of department the drop down is displayed containing departments in all departments table and not in display department table for that state/district. A text field for user to decide the name displayed for the added department.
On adding the department, the selected department is added to display department table of that state/district so that it appears in the menu.

* **Deletion of Department**: For deletion of department all those departments from display deprtments are shown in the drop down. The department selected is deleted from display departments of that stae/district.

* **Addition and Deletion of Sub-department**: On mouse hover of every department its sub-departments are shown with optioon to add/delete. The drop down contains all sub-departments (which are not already shown in menu) of departments displayed in the menu , all of them are disabled except the sub-department of that department i.e. the user can add only sub-departments for that department only not for any other department. The same logic applies for deletion where in drop down all sub-department displayed in menu are present and disabled except the sub-departments of the respective department. Addition of sub-department takes additional user input of name to be displayed in the menu. 

* An additional check on each page if user tries to change urls for accessing admin mode , he will be directed to guest mode.

### Advantages of the system:
* Easy addition/deletion operation for departments and sub-departments in admin mode. 
* Display of all departments, sub-departments and maps dynamically from postgreSQL.
* Scalability, the system now is a prototype for 3-4 states and can be easily extended to hundreds of districts.
* If any new data is recieved for department/sub-department, it has to be added only once in all depts/sub-depts table and rest can be controlled easily through UI.
* The admin and guest provides a good control over data displayed.

