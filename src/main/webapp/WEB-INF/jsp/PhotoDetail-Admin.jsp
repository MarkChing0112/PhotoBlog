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

        <h1 class="logo me-auto"><a href="/BookShop/Books/list" >BookShop</a></h1>

        <nav id="navbar" class="navbar">
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

<security:authorize access="hasRole('ADMIN') or
                principal.username=='${book.customerName}'">
    <h2 style="text-align: center">Book #${bookId}: <c:out value="${book.subject}"/></h2>
    <div class="container">
        <div class="row">
            <div class="col-12">
                <table class="table table-image">
                    <thead>
                    <tr>
                        <th scope="col">Customer Name</th>
                        <th scope="col">Book created</th>
                        <th scope="col">Book updated</th>
                        <th scope="col">Action</th>

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
                    <td><a class="btn btn-primary" href="<c:url value="/Books/edit/${book.id}" />"> <span class="bi bi-pencil-square"/>Edit</a></td>
                        <%--      Display Delete Button--%>

                    </td>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</security:authorize>

<c:if test="${!empty book.photos}">

    <c:forEach items="${book.photos}" var="photo" varStatus="status">
        <c:if test="${!status.first}">, </c:if>

        <%--Image of User photos    --%>
        <div>
            <img class="rounded mx-auto d-block" src="<c:url value="/Books/${bookId}/photo/${photo.id}" />">
        </div>

        <security:authorize access="principal.username=='${book.customerName}'">
            [<a href="<c:url value="/Books/${bookId}/delete/${photo.id}" />">Delete</a>]
        </security:authorize>
    </c:forEach><br/><br/>
</c:if>

<%--Display Comment list--%>
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
                    <security:authorize access="hasRole('ADMIN')">
                        <a href="<c:url value="/Books/${bookId}/deleteComment/${comments.id}" />">Delete</a>
                    </security:authorize>
                    <small> <fmt:formatDate value="${comments.createTime}"
                                            pattern="EEE, d MMM yyyy HH:mm:ss Z"/></small>

                </div>
            </div>

        </c:forEach>
        <%--     End       --%>
    </div>
</div>
</div>
</body>
</html>