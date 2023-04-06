<!DOCTYPE html>
<html>
<head id="header" class="d-flex align-items-center">
  <title>Admin Page</title>
    <style><%@include file="../css/admin-page.css"%></style>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <nav class="navbar navbar-light bg-dark " style="background-color: rgb(46, 52, 63)">
        <a class="navbar-brand mb-0 h1" style="color: rgb(255, 255, 255)">Book Well(Admin)</a>
        <c:url var="logoutUrl"  value="/logout"/>
        <form   action="${logoutUrl} " method="post">
            <input class="getstarted scrollto" type="submit" value="Logout" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
    </nav>

</head>
<body>


<h1>Book Well Admin System</h1>

<a class="btn btn-success " href="<c:url value="/Books/home" />"> <i class="bi bi-house"></i> Home</a><br/><br/>
<security:authorize access="hasRole('ADMIN')">
    <a class="btn btn-success " href="<c:url value="/user" />"> <i class="bi bi-person"></i> Manage User Accounts</a><br/><br/>
</security:authorize>
<a href="<c:url value="/Books/create" />" class="btn btn-success btn-light" style="color: rgb(248, 248, 248); background-color: green;" role="button"><span class="bi bi-file-plus"></span> Create Book</a><br/><br/>
<c:choose>
  <c:when test="${fn:length(bookDatabase) == 0}">
    <i>There are no tickets in the system.</i>
  </c:when>

  <c:otherwise>
<div class="container">
    <div class="row">
        <div class="col-12">
            <table class="table table-image">
                <thead>
                <tr>
                    <th scope="col">Book ID</th>
                    <th scope="col">Book_Name</th>
                    <th scope="col">User_Name</th>

                    <th scope="col">Action</th>

                </tr>
                </thead>
                <!--Body Lsit of Book records-->
<tbody>
    <c:forEach items="${bookDatabase}" var="entry">
      <tr>

      </tr>
<th scope="row">Book ${entry.id}:</th>
    <td> <a href="<c:url value="/Books/view/${entry.id}" />">
        <c:out value="${entry.subject}"/></a></td>
     <td>(customer: <c:out value="${entry.customerName}"/>)</td>

      <%--   Display Edit Button   --%>
<td>
      <security:authorize access="hasRole('ADMIN') or
                principal.username=='${entry.customerName}'">
        <a class="btn btn-primary" role="button" href="<c:url value="/Books/edit/${entry.id}" />"> <i class="bi bi-pencil-square"></i>Edit</a>
      </security:authorize>


<%--      Display Delete Button--%>
    <security:authorize access="hasRole('ADMIN') or principal.username=='${entry.customerName}'">
        <a class="btn btn-danger" href="<c:url value="/Books/delete/${entry.id}" />"> <span class="bi bi-trash"></span>Delete</a><br/><br/>
    </security:authorize>
    </c:forEach>
    </td>

</tbody>
            </table>
        </div>
    </div>
</div>
  </c:otherwise>
</c:choose>
</body>
</html>
