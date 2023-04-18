<!DOCTYPE html>
<html>
<head>
    <title>UserManage</title>
    <style><%@include file="../css/admin-page.css"%></style>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <nav class="navbar navbar-light bg-dark justify-content-between" style="background-color: rgb(46, 52, 63)">
        <a  href="<c:url value="/Photos/list" />" class="navbar-brand mb-0 h1" style="color: rgb(255, 255, 255)"  >PhotoBlog-Admin</a>
        <c:url var="logoutUrl"  value="/logout"/>
        <form  action="${logoutUrl} " method="post">
            <input class="getstarted scrollto" type="submit" value="Logout" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

    </nav>

</head>
<body>
<h2>Users</h2>

<c:choose>
    <c:when test="${fn:length(ticketUsers) == 0}">
        <i>There are no users in the system.</i>
    </c:when>
    <c:otherwise>
<div class="container">
    <div class="row">
        <div class="col-12">
            <table class="table table-image">
                <thead>
                <tr>
                    <th scope="col">Username</th>
                    <th scope="col">Password</th>
                    <th scope="col">Role</th>

                    <th scope="col">Action</th>

                </tr>
                </thead>
                <!--Body Lsit of Book records-->
                <tbody>
                <c:forEach items="${ticketUsers}" var="user">
                <tr>
                </tr>
                <th scope="row">${user.username}:</th>
                <td>${fn:substringAfter(user.password, '{noop}')}</td>
                    <td>
                        <c:forEach items="${user.roles}" var="role" varStatus="status">
                            <c:if test="${!status.first}">, </c:if>
                            ${role.role}
                        </c:forEach>
                    </td>
                    <td><a class="btn btn-danger" href="<c:url value="/user/delete/${user.username}" />"> <span class="bi bi-trash">Delete</a></td>
                        <%--      Display Delete Button--%>

                    </c:forEach>
                </td>
                </tbody>
            </table>
        </div>
    </div>
</div>
    </c:otherwise>
</c:choose>
</body></html>