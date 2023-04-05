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



<c:if test="${not empty photos}">
    <h2>Photos:</h2>
    <table>
        <tr>
            <th>Photo</th>
            <th>Uploaded Date and Time</th>
        </tr>
        <c:forEach var="photo" items="${photos}">
            <tr>
                <td><img src="${photo.getFilePath()}"></td>
                <td>${photo.getUploadedDateTime()}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>
</body>
</html>