<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Home</title>
    <meta content="" name="description">
    <meta content="" name="keywords">


    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<%--    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">--%>
<%--    <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">--%>
<%--    <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">--%>
<%--    <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">--%>
    <style><%@include file="../css/bootstrap.min.css"%></style>
<%--    <style><%@include file="../css/style.css"%></style>--%>
<%--    <style><%@include file="../css/style.css"%></style>--%>
<%--    <style><%@include file="../css/style.css"%></style>--%>
<%--    <style><%@include file="../css/style.css"%></style>--%>
<%--    <style><%@include file="../css/style.css"%></style>--%>
    <style><%@include file="../css/style.css"%></style>


</head>

<body>
<!-- ======= Header ======= -->
<header id="header" class="d-flex align-items-center">
    <div class="container d-flex align-items-center">

        <h1 class="logo me-auto"><a>BookShop</a></h1>

        <nav id="navbar" class="navbar">
            <c:url var="logoutUrl"  value="/logout"/>
            <security:authorize access="hasRole('ADMIN') ">
                <a class="getstarted scrollto" role="button" href="/BookShop/Books/list" /> Manage</a>
            </security:authorize>
            <form   action="${logoutUrl} " method="post">
            <input class="getstarted scrollto" type="submit" value="Logout" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>

            <i class="bi bi-list mobile-nav-toggle"></i>
        </nav>

    </div>
</header><!-- End Header -->

<main id="main">

    <section id="team" class="team section-bg">
        <div class="container">
            <c:choose>
            <c:when test="${fn:length(bookDatabase) == 0}">
                <i>There are no tickets in the system.</i>
            </c:when>

            <c:otherwise>
            <div class="section-title">
                <h2>Books</h2>
                <p></p>
            </div>

            <div class="row">

                <c:forEach items="${bookDatabase}" var="entry">
                <div class="col-lg-4 col-md-6 d-flex align-items-stretch">
                    <div class="member">
                        <c:if test="${!empty entry.attachments}">
                        <c:forEach items="${entry.attachments}" var="attachment" varStatus="status">
                            <c:if test="${!status.first}">, </c:if>
                            <%--Image of User photos    --%>
                            <img src="<c:url value="/Books/${entry.id}/attachment/${attachment.id}" />">
                        </c:forEach>
                        </c:if>
                        <h4><c:out value="${entry.subject}"/></h4>
                        <span> <c:out value="${entry.customerName}"/></span>

                        <a class="btn btn-primary" role="button" href="<c:url value="/Books/view/${entry.id}"/>">
                            Details
                        </a>
                    </div>
                </div>
                </c:forEach>

            </div>
            </c:otherwise>
            </c:choose>
        </div>
    </section><!-- End Team Section -->


</main><!-- End #main -->

<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<!-- Vendor JS Files -->
<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
<script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
<script src="assets/vendor/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script src="assets/js/main.js"></script>

</body>

</html>