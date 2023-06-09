<!DOCTYPE html>
<html>
<head>
    <title>PhotoShop Login</title>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">

    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous"><link rel="stylesheet" href="./style.css">
<%--    <link rel="stylesheet" href="/css/signin.css" type="text/css">--%>
    <style><%@include file="../css/signin.css"%></style>



</head>

<body>
<c:if test="${param.error != null}">
    <p>Login failed.</p>
</c:if>
<c:if test="${param.logout != null}">
    <p>You have logged out.</p>
</c:if>


<div class="box-form">
    <div class="left">
        <div class="overlay">
            <h1>Photo Blog</h1>
            <p>We are Photo-lovers, like you. And we ship photo, magazines, reference material, travel guides,
                card stock,
            </p>
            <p>
                Put our extensive global network, partner associations, and specialized resources at your disposal.</p>
        </div>
    </div>
    <div class="right">
        <h5>Welcome </h5>
        <p>Type your's Account to watch more book. </a> Enjoy our website.</p>

<form action="login" method="POST">
<%--    <label for="username">Username:</label><br/>--%>
    <input placeholder="Username"  type="text" id="username" name="username"/><br/><br/>
<%--    <label for="password">Password:</label><br/>--%>
    <input placeholder="Password"  type="password" id="password" name="password"/><br/><br/>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input class="loginBtn" type="submit" value="Login" class="col-1"/>
    <div class="remeberMeCheckBox">
        <label for="remember-me" >Remember me</label>
    <input  type="checkbox" id="remember-me" class="remember-me-btn" name="remember-me"/>

    </div>
    <a type="button" href="<c:url value="/user/create"/>">Sign Up</a>
    <a type="button" href="<c:url value="/Photos/home"/>">Visit As Anonymous</a>
</form>
</body>
</html>

