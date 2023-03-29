<!DOCTYPE html>
<html>
<head>
    <title>Customer Support</title>
</head>
<body>
<c:url var="logoutUrl" value="/logout"/>
<form action="${logoutUrl}" method="post">
    <input type="submit" value="Logout" />
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>

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

<c:if test="${!empty book.attachments}">
    Attachments:
    <c:forEach items="${book.attachments}" var="attachment" varStatus="status">
        <c:if test="${!status.first}">, </c:if>

    <%--Image of User photos    --%>
        <img src="<c:url value="/Books/${bookId}/attachment/${attachment.id}" />">

        <%-- <c:out value="${attachment.name}"/>--%>

        <security:authorize access="principal.username=='${book.customerName}'">
        [<a href="<c:url value="/Books/${bookId}/delete/${attachment.id}" />">Delete</a>]
        </security:authorize>
    </c:forEach><br/><br/>
</c:if>
<a href="<c:url value="/Books" />">Return to list tickets</a>
</body>
</html>
