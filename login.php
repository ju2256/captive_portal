<?php

    session_start();
    //var_dump($_GET);
        
    if(isset($_GET['inputLogin']) && isset($_GET['inputPassword'])){
        if($_GET['inputLogin'] == 'admin' && $_GET['inputPassword'] == 'oufslan'){
            $_SESSION['login'] = 'admin';
            header('Location: admin.html'); 
        } else {
            echo "erreur" + $_GET['inputLogin'] + $_GET['inputPassword'];
        }
    }

?>
<html lang="fr">
    <head>
        <meta charset="utf-8">
        <title>Les OufsLAN: login partie admin</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">
        <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        
        <style type="text/css">
            #back-btn{
                padding: 10px 16px;
                margin-top: 7px;
                font-size: 18px;
                line-height: 1.3333333;
                border-radius: 6px;   
                color: #fff;
                background-color: #A3A3A3;
                border-color: #2e6da4;
                cursor: pointer;
            }
        </style>
    </head>
    <body>   
        <div class="container">
          <form class="form-signin" style="width: 400px; margin-left: auto; margin-right: auto; padding-top: 100px;" action="login.php" method="get">
            <h4 class="form-signin-heading"><center>Section Staff</center></h4>
            <label for="inputLogin" class="sr-only">login</label>
            <input type="text" name="inputLogin" value="admin" id="inputLogin" class="form-control" required="true" autofocus="">
            <label for="inputPassword" class="sr-only">mot de passe</label>
            <input type="password" name="inputPassword" id="inputPassword" class="form-control" placeholder="Password" required="true">
            <button class="btn btn-lg btn-primary btn-block" type="submit">Go</button>
            <center><div id="back-btn">Retour</div></center>
          </form>
        </div>
        <script src="lib/jquery/jquery-1.11.2.min.js"></script>
        <script src="lib/bootstrap/js/bootstrap.min.js"></script>
        <script>
            $("#back-btn").click(function(){
                $(location).attr('href','index.html');
            });
        </script>
    </body>
</html>