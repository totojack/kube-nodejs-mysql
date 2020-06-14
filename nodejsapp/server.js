'use strict';

const PORT = 8080;
const HOST = '0.0.0.0';

var express = require("express"),
    mysql = require('mysql');
var app = express();
var connection = mysql.createConnection({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DB
});
app.get('/', function(req, res) {
    function fetchText(callback) {
        connection.query('SELECT the_text FROM response LIMIT 1',       
              function(err, rows) {
            if (err) {
                callback(err, null);
            } else 
                callback(null, rows[0].the_text);
        });
    }
    var resp;
    fetchText(function(err, content) {
        if (err) {
          console.log(err);
          res.send(err);  
          // Do something with your error...
        } else {
          resp = content;
          console.log(resp);
          res.send(resp);
        }
    });
})

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
