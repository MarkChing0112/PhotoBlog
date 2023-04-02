<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
    <title> Admin Login Page </title>
    <style>
        Body {
            font-family: Calibri, Helvetica, sans-serif;
            background-color: rgb(255, 255, 255);

        }
        button {
            background-color: #4CAF50;
            width: 100px;
            color: rgb(0, 0, 0);
            padding: 15px;
            margin: 50 auto;
            border: none;
            text-align: center;
            border-radius: 10px;

        }
        form {
            border: 40px solid #ffffff;
            border-radius: 10px;
        }
        input[type=text], input[type=password] {
            width: 100%;
            margin: 8px 0;
            padding: 12px 20px;
            display: inline-block;
            border: 2px solid green;
            box-sizing: border-box;
            border-radius: 10px;
        }
        button:hover {
            opacity: 0.7;
            border-radius: 10px;
        }



        .container {
            padding: 25px;
            background-color: lightblue;
            border-radius: 10px;
        }
    </style>
</head>
<body>
<center> <h1> Admin Login  </h1> </center>
<form action="/admin" method="post">
    <div class="container">
        <label>Username : </label>
        <input type="text" placeholder="username" id="username" name="username" required>
        <label>Password : </label>
        <input type="password" placeholder="Password" id="password" name="password" required>
        <button type="submit">Login</button>
    </div>
</form>
</body>
</html>