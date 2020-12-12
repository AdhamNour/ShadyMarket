const mysql = require('mysql');

var timestamp = require('timestamp')


var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "DistroDB",
});



con.connect((err) => {
    console.log("Connected");
})





module.exports = con; //For Exporting a variable