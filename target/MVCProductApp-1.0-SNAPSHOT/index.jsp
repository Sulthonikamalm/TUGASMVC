<%-- 
    index.jsp
    Redirect otomatis ke Controller Home.
    User tidak akan melihat halaman ini, mereka langsung "dilempar" ke Dashboard.
--%>
<% response.sendRedirect("home"); %>