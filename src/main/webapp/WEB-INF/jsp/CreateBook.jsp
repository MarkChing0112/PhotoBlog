<!DOCTYPE html>
<html>
<head>
    <title>AddBook</title>
    <style><%@include file="../css/admin-page.css"%></style>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <nav class="navbar navbar-light bg-dark justify-content-between" style="background-color: rgb(46, 52, 63)">
        <a  href="<c:url value="/Books/list" />" class="navbar-brand mb-0 h1" style="color: rgb(255, 255, 255)"  >Book Well(Admin)</a>
        <c:url var="logoutUrl"  value="/logout"/>
        <form  action="${logoutUrl} " method="post">
            <input class="getstarted scrollto" type="submit" value="Logout" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

    </nav>

</head>
<body>
<h2>Create a Book</h2>
<form:form method="POST" enctype="multipart/form-data" modelAttribute="bookForm">
    <form:label path="subject">Subject</form:label><br/>
    <form:input type="text" path="subject"/><br/><br/>
    <form:label path="body">Body</form:label><br/>
    <form:textarea path="body" rows="5" cols="30"/><br/><br/>
    <b>Attachments</b><br/>
    <input type="file" name="attachments" multiple="multiple" accept="image/png, image/jpeg"/><br/><br/>
    <input type="submit" value="Submit"/>
</form:form>
</body>
</html>
