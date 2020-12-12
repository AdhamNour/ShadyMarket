const express = require("express");
const bodyParser = require("body-parser");
const urlParser = bodyParser.urlencoded({extended:true});
const app = express();
const rand = (Math.random() * 10) + 1
 
var sess;

app.use(urlParser);
app.use(session({
    secret:rand.toString(),
    saveUninitialized: true,
    resave: true,
    cookie:{maxAge:1},
     }));
app.post('/signin',(req,res)=>{
    sess = req.session;
    sess.email = req.body.email;
    res.end("end");
});
app.get("/admin",(req,res)=>{
    if (sess.email){
        res.end("authenticated")

    } else {
        res.end("plz sign in")
    }
})
app.get("/logout",(req,res)=>{
    req.session.destroy((err)=>{
        if(err){
            return console.log(err)
        }
        return "logged out"
    })
})
app.listen(process.env.PORT || 3000,() => {
    console.log(`App Started on PORT ${process.env.PORT || 3000}`);
});s