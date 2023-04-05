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

        <h1 class="logo me-auto"><a>BookShop</a></h1>

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



<h2>Book #${bookId}: <c:out value="${book.subject}"/></h2>
<security:authorize access="hasRole('ADMIN') or
                principal.username=='${book.customerName}'">
[<a href="<c:url value="/Books/edit/${book.id}" />">Edit</a>]
</security:authorize>
<security:authorize access="principal.username=='${book.customerName}'">
[<a href="<c:url value="/Books/delete/${book.id}" />">Delete</a>]<br/><br/>
</security:authorize>
<i>Customer Name - <c:out value="${book.customerName}"/></i><br/>
Book created: <fmt:formatDate value="${book.createTime}"
                              pattern="EEE, d MMM yyyy HH:mm:ss Z"/><br/>
Book updated: <fmt:formatDate value="${book.updateTime}"
                              pattern="EEE, d MMM yyyy HH:mm:ss Z"/><br/><br/>
<c:out value="${book.body}"/><br/><br/>

<c:if test="${!empty book.photos}">
Attachments:
<c:forEach items="${book.photos}" var="photo" varStatus="status">
<c:if test="${!status.first}">, </c:if>

    <%--Image of User photos    --%>
<img src="<c:url value="/Books/${bookId}/photo/${photo.id}" />">

    <%-- <c:out value="${attachment.name}"/>--%>

<security:authorize access="principal.username=='${book.customerName}'">
[<a href="<c:url value="/Books/${bookId}/delete/${photo.id}" />">Delete</a>]
</security:authorize>
</c:forEach><br/><br/>
</c:if>
<a href="<c:url value="/Books/list" />">Return to list tickets</a>
<%--<a href="<c:url value="/Books/create/${bookId}/comment" />">Create Comment</a>--%>

<%--<form:form method="POST" modelAttribute="Commentform">--%>
<%--<form:label path="body">Body</form:label><br/>--%>
<%--    <form:textarea path="body" rows="5" cols="30"/><br/><br/>--%>
<%--<input type="submit" value="Submit"/>--%>

<h2 style="text-align: center;">Comments</h2>
<div style="width: 740px; margin-left: auto; margin-right: auto; "  class="d-flex flex-row add-comment-section mt-4 mb-4">
    <form:form method="POST" modelAttribute="Commentform">
<%--        <form:label path="body">Body</form:label><br/>--%>
        <form:textarea path="body" rows="5" cols="30"/></br>
    <input value="Submit" class="btn btn-primary" type="submit" />
    </form:form>
</div>
<div class="container mt-5">
    <div class="row  d-flex justify-content-center">
        <div class="col-md-8">
            <div class="headings d-flex justify-content-between align-items-center mb-3">
                <h5>Unread comments(6)</h5>
                <div class="buttons">
                    <!-- <span class="badge bg-white d-flex flex-row align-items-center">
                        <span class="text-primary">Comments "ON"</span>
                        <div class="form-check form-switch">
                          <input class="form-check-input" type="checkbox" id="flexSwitchCheckChecked" checked>

                        </div>
                    </span> -->
                </div>
            </div>
            <div class="card p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="user d-flex flex-row align-items-center">
                        <span><small class="font-weight-bold text-primary">james_olesenn</small> </br><small class="font-weight-bold">Hmm, This poster looks cool</small></span>
                    </div>
                    <small>2 days ago</small>

                </div>
                <div class="action d-flex justify-content-between mt-2 align-items-center">
                    <div class="icons align-items-center">
                        <i class="fa fa-star text-warning"></i>
                        <i class="fa fa-check-circle-o check-icon"></i>
                    </div>
                </div>
            </div>
            <div class="card p-3 mt-2">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="user d-flex flex-row align-items-center">
                        <span><small class="font-weight-bold text-primary">james_olesenn</small> </br><small class="font-weight-bold">Hmm, This poster looks cool</small></span>
                    </div>
                    <small>3 days ago</small>
                </div>
                <div class="action d-flex justify-content-between mt-2 align-items-center">
                    <div class="icons align-items-center">
                        <i class="fa fa-check-circle-o check-icon text-primary"></i>
                    </div>
                </div>
            </div>
            <div class="card p-3 mt-2">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="user d-flex flex-row align-items-center">
                        <!-- <img src="https://i.imgur.com/0LKZQYM.jpg" width="30" class="user-img rounded-circle mr-2"> -->
                        <span><small class="font-weight-bold text-primary">james_olesenn</small> </br><small class="font-weight-bold">Hmm, This poster looks cool</small></span>
                    </div>
                    <small>3 days ago</small>
                </div>
                <div class="action d-flex justify-content-between mt-2 align-items-center">
                    <div class="icons align-items-center">
                        <i class="fa fa-user-plus text-muted"></i>
                        <i class="fa fa-star-o text-muted"></i>
                        <i class="fa fa-check-circle-o check-icon text-primary"></i>
                    </div>
                </div>
            </div>
            <div class="card p-3 mt-2">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="user d-flex flex-row align-items-center">
                        <!-- <img src="https://i.imgur.com/ZSkeqnd.jpg" width="30" class="user-img rounded-circle mr-2"> -->
                        <span><small class="font-weight-bold text-primary">james_olesenn</small> </br><small class="font-weight-bold">Hmm, This poster looks cool</small></span>
                    </div>
                    <small>3 days ago</small>
                </div>
                <div class="action d-flex justify-content-between mt-2 align-items-center">
                    <div class="icons align-items-center">
                        <i class="fa fa-check-circle-o check-icon text-primary"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</html>