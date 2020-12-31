const mysql = require('mysql');

var timestamp = require('timestamp')


var con = mysql.createConnection({
    host: "192.168.1.7:3306",
    user: "root",
    password: "",
    database: "DistroDB",
});



con.connect((err) => {
    if(err)throw err
    console.log("Connected");
})





module.exports = con; //For Exporting a variable