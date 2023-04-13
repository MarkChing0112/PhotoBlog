<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Profile Page</title>
</head>
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