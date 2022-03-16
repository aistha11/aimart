const functions = require("firebase-functions");

exports.orderPlaced = functions.firestore
.document("/orders/{documentId}")
.onCreate((snap, context) => {
  console.log(snap.data);
  return Promise.resolve();
});