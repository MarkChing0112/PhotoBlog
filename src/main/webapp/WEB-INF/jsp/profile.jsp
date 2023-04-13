<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Profile Page</title>

<%--    CSS--%>
    <style><%@include file="../css/bootstrap.min.css"%></style>

    <style><%@include file="../css/style.css"%></style>
</head>
<!-- ======= Header ======= -->
<header id="header" class="d-flex align-items-center">
    <div class="container d-flex align-items-center">

        <h1 class="logo me-auto"><a>BookShop</a></h1>

        <nav id="navbar" class="navbar">
            <a class="getstarted scrollto" href="/BookShop/user/profile">Profile</a>
            <c:url var="logoutUrl"  value="/logout"/>
            <security:authorize access="hasRole('ADMIN') ">
                <a class="getstarted scrollto" role="button" href="/BookShop/Books/list" /> Manage</a>
            </security:authorize>
            <form   action="${logoutUrl} " method="post">
                <input class="getstarted scrollto" type="submit" value="Logout" />
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>

            <i class="bi bi-list mobile-nav-toggle"></i>
        </nav>

    </div>
</header><!-- End Header -->
<body>
<security:authorize access="isAuthenticated()">
    <h1>Welcome, <security:authentication property="principal.username" />!</h1>
    <p>Your profile information:</p>
    <p>Name: ${username}</p>

</security:authorize>


<c:forEach items="${bookDatabase}" var="entry">
    <div class="col-lg-4 col-md-6 d-flex align-items-stretch">
        <div class="member">
            <c:if test="${!empty entry.photos}">
                <c:forEach items="${entry.photos}" var="photo" varStatus="status">
                    <c:if test="${!status.first}">, </c:if>
                    <security:authorize access="principal.username=='${entry.customerName}'">
                        <%--Image of User photos    --%>
                        <img src="<c:url value="/Books/${entry.id}/photo/${photo.id}" />">
                        <fmt:formatDate value="${entry.createTime}"
                                        pattern="EEE, d MMM yyyy HH:mm:ss Z"/></small>
                    </security:authorize>
                </c:forEach>
            </c:if>

        </div>
    </div>
</c:forEach>

</body>
</html>