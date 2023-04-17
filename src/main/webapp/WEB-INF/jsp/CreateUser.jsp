<!DOCTYPE html>
<html>
<head><title>Customer Support</title>
  <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
  <style><%@include file="../css/register.css"%></style>


</head>
<body>

<div class="main">

  <!-- Sign up form -->
  <section class="signup">
    <div class="container">
      <div class="signup-content">
        <div class="signup-form">
          <h2 class="form-title">Sign up</h2>


          <form:form method="POST" modelAttribute="ticketUser">
            <form:label path="username">Username</form:label><br/>
            <form:input type="text" path="username"/><br/><br/>
            <form:label path="password">Password</form:label><br/>
            <form:input type="text" path="password"/><br/><br/>
            <form:input type="hidden" path="roles" value="ROLE_USER"/>
            <br/><br/>
            <input type="submit" value="Create Account" class="form-submit" />
          </form:form>
        </div>
        <div class="signup-image">
          <figure><img src="https://images.unsplash.com/photo-1532012197267-da84d127e765?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80" alt="sing up image"></figure>
          <a href="<c:url value="/login"/>" class="signup-image-link">I am already member</a>
        </div>
      </div>
    </div>
  </section>
</div>


</body>
</html>