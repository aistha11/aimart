
const sentiment = require("./sentiment");


// exports.helloWorld = functions.https.onRequest((req, res) => {
//   res.send("Hello world from cloud function");
// });


exports.sentiment = sentiment.sentiment;
exports.auth = require('./auth');
