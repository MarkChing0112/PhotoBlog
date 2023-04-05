<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<body style="background-color: rgb(142, 172, 172);">


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<section >
    <div class="container my-5 py-5 text-dark">
        <div class="row d-flex justify-content-center">
            <div class="col-md-10 col-lg-8 col-xl-6">
                <div class="card">
                    <div class="card-body p-4">
                        <div class="d-flex flex-start w-100">
                            <div class="w-100">
                                <h5>User Name</h5>

                                <form:form method="POST" enctype="multipart/form-data" modelAttribute="CommentFrom">
                                    <form:label path="body">Body</form:label><br/>
                                    <form:textarea path="body" rows="5" cols="30"/><br/><br/>
                                    <input type="submit" value="Submit"/>
                                </form:form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>