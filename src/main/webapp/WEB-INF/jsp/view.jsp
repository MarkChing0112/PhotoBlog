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

<h2>Ticket #${ticketId}: <c:out value="${ticket.subject}"/></h2>
<security:authorize access="hasRole('ADMIN') or
                principal.username=='${ticket.customerName}'">
    [<a href="<c:url value="/ticket/edit/${ticket.id}" />">Edit</a>]
</security:authorize>
<security:authorize access="principal.username=='${ticket.customerName}'">
[<a href="<c:url value="/Books/delete/${ticket.id}" />">Delete</a>]<br/><br/>
</security:authorize>
<i>Customer Name - <c:out value="${ticket.customerName}"/></i><br/>
Ticket created: <fmt:formatDate value="${ticket.createTime}"
                               pattern="EEE, d MMM yyyy HH:mm:ss Z"/><br/>
Ticket updated: <fmt:formatDate value="${ticket.updateTime}"
                                pattern="EEE, d MMM yyyy HH:mm:ss Z"/><br/><br/>
<c:out value="${ticket.body}"/><br/><br/>

<c:if test="${!empty ticket.attachments}">
    Attachments:
    <c:forEach items="${ticket.attachments}" var="attachment" varStatus="status">
        <c:if test="${!status.first}">, </c:if>

    <%--Image of User photos    --%>
        <img src="<c:url value="/Books/${ticketId}/attachment/${attachment.id}" />">

        <%-- <c:out value="${attachment.name}"/>--%>

        <security:authorize access="principal.username=='${ticket.customerName}'">
        [<a href="<c:url value="/ticket/${ticketId}/delete/${attachment.id}" />">Delete</a>]
        </security:authorize>
    </c:forEach><br/><br/>
</c:if>
<a href="<c:url value="/ticket" />">Return to list tickets</a>
</body>
</html>
