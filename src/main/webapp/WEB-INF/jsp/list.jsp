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
<h2>Books</h2>
<security:authorize access="hasRole('ADMIN')">
  <a href="<c:url value="/user" />">Manage User Accounts</a><br /><br />
</security:authorize>
<a href="<c:url value="/Books/create" />">Create a Book</a><br/><br/>
<c:choose>
  <c:when test="${fn:length(bookDatabase) == 0}">
    <i>There are no tickets in the system.</i>
  </c:when>

  <c:otherwise>
    <c:forEach items="${bookDatabase}" var="entry">
      Ticket ${entry.id}:
      <a href="<c:url value="/Books/view/${entry.id}" />">
        <c:out value="${entry.subject}"/></a>
      (customer: <c:out value="${entry.customerName}"/>)
<%--   Display Edit Button   --%>
      <security:authorize access="hasRole('ADMIN') or
                principal.username=='${entry.customerName}'">
        [<a href="<c:url value="/Books/edit/${entry.id}" />">Edit</a>]
      </security:authorize>

<%--      Display Delete Button--%>
      <security:authorize access="principal.username=='${entry.customerName}'">
        [<a href="<c:url value="/Books/delete/${entry.id}" />">Delete</a>]<br/><br/>
      </security:authorize>
    </c:forEach>

    <table>
      <tr><th>Username</th><th>Password</th><th>Roles</th><th>Action</th></tr>
      <c:forEach items="${ticketUsers}" var="user"><tr>
        <td>${user.username}</td>
        <td>${fn:substringAfter(user.password, '{noop}')}</td>
        <td>
          <c:forEach items="${user.roles}" var="role" varStatus="status">
            <c:if test="${!status.first}">, </c:if>
            ${role.role}
          </c:forEach>
        </td>
        <td>[<a href="<c:url value="/user/delete/${user.username}" />">Delete</a>]</td>
      </tr></c:forEach>
    </table>
  </c:otherwise>
</c:choose>
</body>
</html>
