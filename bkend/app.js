var express = require("express");
var bodyParser = require("body-parser");
var urlParser = bodyParser.json();
var dp = require("./dp");
const session = require('express-session');
const rand = (Math.random() * 10) + 1
var MemoryStore = require('memorystore')(session);
var cookieParser = require('cookie-parser');

var app = express();
app.use(urlParser);
app.use(cookieParser());
app.use(session({
    secret: "shady",
    name: "mycookie",
    resave: true,
    saveUninitialized: true,
    store:new MemoryStore(),
    cookie: { 
        secure: false,
        maxAge: Date.now() +  6000000
    }
}));
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

var check_authentication = (req, res, next) => {
    if(req.body.token != undefined){
        if (req.body.token == req.session.token) {
            next();
        }
    }else if(req.headers.token != undefined){
        if(req.headers.token == req.session.token) {
        next();
    }
}else {
        res.json({
            "success": false,
            "error": "please log in"
        })
    }
};
 /**Products */
 app.get("/products",(req,res)=>{
    /**Select product by id */
    try{
    let offset = req.headers.offset;
    let num_of_products = req.headers.num_of_products;
    let query = "SELECT * FROM products ";
    //Note to Hamid : LIMIT doesn't work
    dp.query(query, [offset,num_of_products], (err, results) => {
        res.json({
            "success": true,
            "data":results
        })
    })
} catch (error) {
    res.json({
        "success": false,
        "error": error
    })
}

});
 
 app.get("/products/",(req,res)=>{
        /**Select product by id */
        try {
        let product_id = req.body.id;
        let query = "SELECT * FROM products as pr WHERE pr.ID = ?";
        dp.query(query, [product_id], (err, results) => {
            res.json({
                "success": true,
                "data":results
            })
        })
    } catch (error) {
        res.json({
            "success": false,
            "error": error
        })
    }

 });
//  app.post("/products", (req, res) => {
//      //Post new product
//     try {
//         var OwnerID = req.body.token,
//             name = req.body.name,
//             Description = req.body.description,
//             Quantity = req.body.quantity,
//             pic = req.body.pic,
//             price = req.body.price;
//         const query = "INSERT INTO Products (OwnerID,Name,Description,Quantity,pic,price) VALUES (?,?,?,?,?,?);";
//         dp.query(query, [OwnerID, name, Description, Quantity, pic, price], (err, results) => {
//             res.json({
//                 "success": true,
//                 "products": results
//             })
//         })
//     } catch (error) {
//         res.json({
//             "success": false,
//             "error": error
//         })
//     }

//});
app.post("/products/", (req, res) => {
    //edit  Product
    //FIXME : add product insertion here
    try {
        console.log(req.body)
        const query = "UPDATE products SET name=?,Discription=?,Quantity=?,pic=?,price=? WHERE ID = ?";
        dp.query(query, [req.body.name, req.body.description, req.body.quantity, req.body.pic, req.body.price, req.body.id], (err, results) => {
            if(err) throw err;
            res.json({
                "success": true
            })
        })

    } catch (error) {
        res.json({
            "success": false,
            "error": error
        })
    }
});

app.delete("/products/",  (req, res) => {
    try {
        const query = "DELETE FROM Products WHERE ID = ?;";
        dp.query(query,[req.body.token], (err, results) => {
            res.json({
                "success": true
            })
        })
    } catch (error) {
        res.json({
            "success": false,
            "error": error
        })
    }
})
//Search for Product
app.post("/products/search", (req, res) => {
    try {
        const name = req.body.name;
        const query = "SELECT * FROM Products WHERE Name LIKE '% ? %'";
        dp.query(query,[name], (err, results) => {
            res.json({
                "success": true,
                "products": results
            })
        })
    } catch (error) {
        res.json({
            "success": false,
            "error": error
        })
    }
})
//Purchase a Product
app.post("/products/purchase", (req, res) => {
    try {
        const productID = req.body.id,
            buyerID = req.body.token,
            quantity = req.body.quantity;
        let query = "SELECT OwnerID,Quantity,price FROM Products WHERE ID = ?";
        dp.query(query, productID, (err, results) => {
            let productPrice = results[0]['price'];
            let ownerID = results[0]['OwnerID'];
            let totalPrice = productPrice * quantity;
            let newQuantity = results[0]['Quantity'] - quantity;
            dp.query("UPDATE Products SET Quantity=? WHERE ID = ?", [newQuantity, productID], (err, results1) => {
                query = "UPDATE Person SET Credit = Credit + ? WHERE ID = ?;";
                dp.query(query, [totalPrice, ownerID], (err, results2) => {
                    query = "Update Person SET Credit = Credit - ? WHERE ID = ?;";
                    dp.query(query, [totalPrice, buyerID], (err, results3) => {
                        query = "INSERT INTO Transaction (product,buyer) VALUES(?,?)";
                        dp.query(query, [productID, buyerID])
                        res.json({
                            "success": true

                        })
                    })
                })
            })
        })
    } catch (error) {
        res.json({
            "success": false,
            "error": error
        })
    }

})

/**Products */

/** Person */
app.post('/users/edit',(req,res)=>{
    //TODO : Search about session token in express session
    
    try {
        var email = req.body.email,
            pic = req.body.pictureUrl,
            location = req.body.location,
            credit = req.body.credit,
            name = req.body.name;
        let query = "UPDATE person set email = ? , name = ? , pic = ? , Credit = ? , location = ?  where ID = ?";
        dp.query(query, [email, name,pic,credit,location,req.body.token], (err, results) => {
            if (err) throw err;
            if(!err) {
                res.json({
                    "success": true,
                })

            }
        })
    } catch (error) {
        res.json({
            "success": false,
            "error": error
        })
    }
});

app.get('/users/show',(req,res)=>{
        try {
            
            let query = "select * from person  where ID = ?";
            if (req.headers.sellerid){
                dp.query(query, [req.headers.sellerid], (err, results) => {
                    res.json({
                        "success": true,
                        "users":results
                    })
                })
            } else {
                
                dp.query(query, [req.headers.token], (err, results) => {
                    res.json({
                        "success": true,
                        "users":results
                    })
                })
                
            }
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
        let query = "INSERT INTO Person (email,password,name) VALUES (?,?,?);";
        dp.query(query, [email, password,name], (err, results) => {
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

//=======================//
//===== TRANSACTIONS ====//
//=======================//
app.get("/transactions", (req, res) => {
    try {
        const query = "SELECT ID,product,buyer FROM Transaction where buyer = ?;"
        dp.query(query, [req.headers.token],(err, results) => {
            res.json({
                "success": true,
                "products": results
            })
        })
    } catch (error) {
        res.json({
            "success": false,
            "error": error
        })
    }

});
//=======================//
//===== TRANSACTIONS ====//
//=======================//


var server = app.listen(4000, () => {
    var host = server.address().address;
    var port = server.address().port;

    console.log('I am listening to %s %s', host, port);
})