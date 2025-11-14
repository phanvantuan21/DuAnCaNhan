<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Usage:
    <jsp:include page="../layout/page-title.jsp">
        <jsp:param name="title" value="Quản Lý ..."/>
        <jsp:param name="icon" value="fa-solid fa-..."/>
    </jsp:include>
--%>
<h2 class="page-title">
    <i class="${empty param.icon ? 'fa-solid fa-folder' : param.icon}"></i>
    <span>${param.title}</span>
</h2>

