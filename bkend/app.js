var express = require("express");
var bodyParser = require("body-parser");
var urlParser = bodyParser.json();
var dp = require("./dp");
const session = require('express-session');
const rand = (Math.random() * 10) + 1
var MemoryStore = require('memorystore')(session);

var app = express();
app.use(urlParser);
app.use(session({
    resave:false,
    secret:"shady",
    store: new MemoryStore({checkPeriod:10000}),
    cookie:{maxAge  : 10000}, 
    saveUninitialized:false
}));
var sess = "";
/***
 * Entity
 * /signup
 * Authentication
 * /signin => authentication_token [user[seller,customer],admin,guest]
 * /users :GET for all
 * /users/{authentication_token} =>[show:get,edit:put,edit:get]
 * products/
 * products/{authentication_token,product_id} =>[show:get,edit:put,delete,buy:post]
 * transactions/{authentication_token} [show:get]
 */

let check_authentication = (req, res, next) => {
    if (req.body.token == req.session.token) {
        next();
    } else {
        res.json({
            "success": false,
            "error": "please log in"
        })
    }
};
 /**Products */
 app.get("/products/",(req,res)=>{
        /**Select product by id */
 });
 app.post("/products/",check_authentication,(req,res)=>{
        /**update product details */

});
app.delete("/products/",check_authentication,(req,res)=>{
    /**delete product */
});
app.post("/products/",check_authentication,(req,res)=>{
        /**make transaction */
});
/**Products */

/** Person */
app.post('/users/edit',check_authentication,(req,res)=>{
    try {
        var email = req.body.email,
            password = req.body.password,
            pic = req.body.pictureUrl,
            location = req.body.location,
            credit = req.body.credit
            console.log(req.body);
        let query = "UPDATE person set email = ? , password = ?  where ID = ?";
        dp.query(query, [email, password,req.session.token], (err, results) => {
            console.log(req.session.token);
            res.json({
                "success": true,
            })
        })
    } catch (error) {
        res.json({
            "success": false,
            "error": error
        })
    }
});
/** Person */
/**Person Sign in */
app.post("/sign_up", (req, res) => {
    try {
        var email = req.body.email,
            password = req.body.password,
            name = req.body.name
        console.log(req.body);
        let query = "INSERT INTO Person (email,password,name) VALUES (?,?,?);";
        dp.query(query, [email, password,name], (err, results) => {
            console.log(results);
            res.json({
                "success": true,
            })
        })
    } catch (error) {
        res.json({
            "success": false,
            "error": error
        })
    }

});
app.post("/sign_in", (req, res) => {
    var email = req.body.email,
        password = req.body.password;
        console.log(req.body);
    const query = "SELECT ID FROM Person WHERE email = ? AND password = ?;";
    dp.query(query, [email, password], (err, results) => {
        if (results.length == 0) {
            res.json({
                "success": false
            })
        } else {
            req.session.token = results[0]['ID']
            res.json({
                "success": true,
                "token": req.session.token
            })
        }
    })
})


var server = app.listen(4000, () => {
    var host = server.address().address;
    var port = server.address().port;

    console.log('I am listening to %s %s', host, port);
})