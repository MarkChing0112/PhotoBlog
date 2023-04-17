<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <link href="css/style.css" rel="stylesheet">
    <style><%@include file="../css/style.css"%></style>
    <style><%@include file="../css/bootstrap.min.css"%></style>



</head>

<body>
<!-- ======= Header ======= -->
<header id="header" class="d-flex align-items-center">
    <div class="container d-flex align-items-center">

        <h1 class="logo me-auto"><a href="/BookShop/Books/home">PhotoShop</a></h1>

        <nav id="navbar" class="navbar">
            <security:authorize access="isAuthenticated()">
                <a class="getstarted scrollto" href="/BookShop/user/profile">Profile</a>
                <a class="getstarted scrollto" href="/BookShop/Books/ShareBook">Share Photo</a>
            </security:authorize>
            <c:url var="logoutUrl"  value="/logout"/>
            <security:authorize access="hasRole('ADMIN') ">
                <a class="getstarted scrollto" role="button" href="/BookShop/Books/list" /> Manage</a>
            </security:authorize>

            <security:authorize access ="isAnonymous() ">
                <a class="getstarted scrollto" role="button" href="/BookShop/login" /> Login</a>
            </security:authorize>
            <%--LOGOUT--%>
            <security:authorize access="isAuthenticated() ">
                <form  action="${logoutUrl} " method="post">
                    <input class="getstarted scrollto" type="submit" value="Logout" />
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
            </security:authorize>



            <i class="bi bi-list mobile-nav-toggle"></i>
        </nav>


    </div>
</header><!-- End Header -->





<h2 style="text-align: center">Photo #${bookId}: <c:out value="${book.subject}"/></h2>
<div class="container">
    <div class="row">
        <div class="col-12">
            <table class="table table-image">
                <thead>
                <tr>
                    <th scope="col">writer</th>
                    <th scope="col">Photo created</th>
                    <th scope="col">Photo updated</th>
                </tr>
                </thead>
                <!--Body Lsit of Book records-->
                <tbody>
                    <th scope="row"><c:out value="${book.customerName}"/></th>
                    <td><fmt:formatDate value="${book.createTime}"
                                        pattern="EEE, d MMM yyyy HH:mm:ss Z"/></td>
                    <td>
                        <fmt:formatDate value="${book.updateTime}"
                                        pattern="EEE, d MMM yyyy HH:mm:ss Z"/>
                    </td>
                </td>
                </tbody>
            </table>
        </div>
    </div>
</div>

<c:if test="${!empty book.photos}">
<section id="team" class="team section-bg">
    <div class="container">
        <div class="row">

<c:forEach items="${book.photos}" var="photo" varStatus="status">
    <div class="col-lg-4 col-md-6 d-flex align-items-stretch">
        <div class="member">
    <%--Image of photo    --%>
        <img  src="<c:url value="/Books/${bookId}/photo/${photo.id}" />">
        </div>
    </div>
</c:forEach><br/><br/>
        </div>
    </div>
    </section>
</c:if>
<%--Start Display comment--%>
<h2 style="text-align: center;">Comments</h2>

<div class="container mt-5">
    <div class="row  d-flex justify-content-center">
        <br class="col-md-8">
            <div class="headings d-flex justify-content-between align-items-center mb-3">
                <h5>User Comment</h5>
            </div>
            <%--      Start Loop      --%>
            <c:forEach items="${Comments}" var="comments" varStatus="status">
            <div class="card p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="user d-flex flex-row align-items-center">
                        <span><small class="font-weight-bold text-primary">${comments.customerName}</small> </br>
                            <small class="font-weight-bold">${comments.body}</small></span>
                    </div>
                    <small> <fmt:formatDate value="${comments.createTime}"
                                            pattern="EEE, d MMM yyyy HH:mm:ss Z"/></small>

                </div>
            </div>
            </c:forEach>
            <%--     End       --%>
        <security:authorize access="isAuthenticated ">
            <form:form method="POST" modelAttribute="Commentform">
                <form:textarea placeholder="Type Your Comments" path="body" rows="5" cols="30" /></br>
                <input value="Submit" class="btn btn-primary" type="submit" />
            </form:form>
        </security:authorize>
        </div>
    </div>
</div>
</body>
</html>