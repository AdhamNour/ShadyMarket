
/**Person Sign in */

// //Get user info/transactions
// app.get("/users/:id", (req, res) => {
//     try {
//         let user_id = req.params.id;
//         let query = "SELECT email,Credit FROM Person WHERE ID = ?;";
//         dp.query(query, [user_id], (err, results) => {
//             query = "SELECT Products.Name as Product " + //Returns Sold Transactions
//                 "FROM Transaction INNER JOIN Person ON Person.ID = Transaction.Buyer " +
//                 "INNER JOIN Products ON Products.ID = Transaction.Product WHERE Transaction.Buyer = ? ;";
//             dp.query(query, [user_id], (err, results1) => {
//                 query = "SELECT Products.Name as Product " +
//                     "FROM Transaction INNER JOIN Products ON Products.ID = Transaction.Product " +
//                     "INNER JOIN Person ON Products.OwnerID = Person.ID WHERE Products.OwnerID = ? ;";
//                 dp.query(query, [user_id], (err, results2) => {
//                     query = "SELECT Name FROM Products WHERE OwnerID = ?;"
//                     dp.query(query, [user_id], (err, results3) => {
//                         res.json({
//                             "success": true,
//                             "user_info": results,
//                             "bought_items": results1,
//                             "sold_items": results2,
//                             "items_on_sale": results3
//                         })
//                     })
//                 })
//             })
//         })
//     } catch (error) {
//         res.json({
//             "success": false,
//             "error": error
//         })
//     }
// })

// // Deposit cash
// app.put("/users/:id", check_authentication, (req, res) => {
//     let credit = req.body.credit;
//     const query = "UPDATE Person SET Credit = Credit + ? WHERE ID = ?;"
//     dp.query(query, [credit, req.params.id], (err, result) => {
//         res.json({
//             "success": true
//         })
//     })
// })

// //=============================//
// //===== PERSON APIS ========//
// //===========================//






// //=============================//
// //===== PRODUCTS APIS ========//
// //===========================//

// app.get("/products", (req, res) => {
//     try {
//         const query = "SELECT * FROM products"
//         dp.query(query, (err, results) => {
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

// });

// app.post("/products", check_authentication, (req, res) => {
//     try {
//         var OwnerID = req.body.ownerID,
//             name = req.body.name,
//             Discription = req.body.description,
//             Quantity = req.body.quantity,
//             pic = req.body.pic,
//             price = req.body.price;
//         const query = "INSERT INTO Products (OwnerID,Name,Description,Quantity,pic,price) VALUES (?,?,?,?,?,?);";
//         dp.query(query, [OwnerID, name, Discription, Quantity, pic, price], (err, results) => {
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

// });

// app.delete("/products/:id", check_authentication, (req, res) => {
//     try {
//         const query = "DELETE FROM Products WHERE ID =" + req.params.id + ";";
//         dp.query(query, (err, results) => {
//             res.json({
//                 "success": true
//             })
//         })
//     } catch (error) {
//         res.json({
//             "success": false,
//             "error": error
//         })
//     }
// })

// app.put("/products/:id", check_authentication, (req, res) => {
//     try {
//         const query = "UPDATE Products SET Name=?,Description=?,Quantity=?,pic=?,price=? WHERE ID = ?";
//         dp.query(query, [req.body.name, req.body.description, req.body.quantity, req.body.pic, req.body.price, req.params.id], (err, results) => {
//             res.json({
//                 "success": true
//             })
//         })

//     } catch (error) {
//         res.json({
//             "success": false,
//             "error": error
//         })
//     }
// });


// //Search for Product
// app.post("/products/search", (req, res) => {
//     try {
//         const name = req.body.name;
//         const query = "SELECT * FROM Products WHERE Name LIKE '%" + name + "%'";
//         dp.query(query, (err, results) => {
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
// })

// //Purchase a Product
// app.post("/products/purchase/:id", check_authentication, (req, res) => {
//     try {
//         const productID = req.params.id,
//             buyerID = req.body.buyerID,
//             quantity = req.body.quantity;
//         let query = "SELECT OwnerID,Quantity,price FROM Products WHERE ID = ?";
//         dp.query(query, productID, (err, results) => {
//             let productPrice = results[0]['price'];
//             let ownerID = results[0]['OwnerID'];
//             let totalPrice = productPrice * quantity;
//             let newQuantity = results[0]['Quantity'] - quantity;
//             dp.query("UPDATE Products SET Quantity=? WHERE ID = ?", [newQuantity, productID], (err, results1) => {
//                 query = "UPDATE Person SET Credit = Credit + ? WHERE ID = ?;";
//                 dp.query(query, [totalPrice, ownerID], (err, results2) => {
//                     query = "Update Person SET Credit = Credit - ? WHERE ID = ?;";
//                     dp.query(query, [totalPrice, buyerID], (err, results3) => {
//                         query = "INSERT INTO Transaction (product,buyer) VALUES(?,?)";
//                         dp.query(query, [productID, buyerID])
//                         res.json({
//                             "success": true
//                         })
//                     })
//                 })
//             })
//         })
//     } catch (error) {
//         res.json({
//             "success": false,
//             "error": error
//         })
//     }

// })

// //=============================//
// //===== PRODUCTS APIS ========//
// //===========================// 



// //=======================//
// //===== TRANSACTIONS ====//
// //=======================//
// app.get("/transactions", (req, res) => {
//     try {
//         const query = "SELECT ID,product,buyer FROM Transaction;"
//         dp.query(query, (err, results) => {
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

// });
//=======================//
//===== TRANSACTIONS ====//
//=======================//






