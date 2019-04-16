<?php

// If you want to use the COMP3311 DB Access Library, include the following two lines
//
// define("LIB_DIR","/import/adams/1/cs3311/public_html/19s1/assignments/a2");
// require_once(LIB_DIR."/db.php");
require_once("db.php");

// Your DB connection parameters, e.g., database name
//
// define("DB_CONNECTION","dbname=a2");
define("DB_CONNECTION","dbname=mydb host=localhost user=postgres password=apple123");

//
// Include your other common PHP code below
// E.g., common constants, functions, etc.
//


function dd($var){
    // handy function from laravel 
    var_dump ($var);
    exit();
}
?>
