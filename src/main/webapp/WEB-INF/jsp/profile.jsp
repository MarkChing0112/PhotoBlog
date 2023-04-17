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
<header  id="header" class="d-flex align-items-center">
    <div class="container d-flex align-items-center">

        <h1 class="logo me-auto"><a href="/BookShop/Books/home">PhotoShop</a></h1>

        <nav  id="navbar" class="navbar">
            <a class="getstarted scrollto" href="/BookShop/user/profile">Profile</a>
            <a class="getstarted scrollto" href="/BookShop/Books/create">Share Photo</a>
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
<main id="main">
    <section id="team" class="team section-bg">
        <div class="container">
<security:authorize access="isAuthenticated()">
    <h1 style="text-align: center"> Profile </h1>
    <p style="text-align: center"><security:authentication property="principal.username" /></p>
    <p style="text-align: center"> Description</p>
    <p class="text-break" style="text-align: center" ><c:out value="${User.description}" /></p>
</security:authorize>

<form:form method="POST" modelAttribute="descriptionForm">
    <form:textarea placeholder="Type Your Description" path="description" rows="5" cols="100" /></br>
    <input value="Update" class="btn btn-primary" type="submit" />
</form:form>




            <c:choose>
            <c:when test="${fn:length(bookDatabase) == 0}">
                <i>You did not share any books</i>
            </c:when>

            <c:otherwise>
            <div class="section-title">
                <h2>Yours Books</h2>
                <p></p>
            </div>
            <div class="row">

<c:forEach items="${bookDatabase}" var="entry">
    <div class="col-lg-4 col-md-6 d-flex align-items-stretch">
        <div class="member">
            <c:if test="${!empty entry.photos}">
                <c:forEach items="${entry.photos}" var="photo" varStatus="status">
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

            </div>
            </c:otherwise>
            </c:choose>
        </div>
    </section><!-- End Team Section -->

</main><!-- End #main -->


</body>
</html>