const functions = require("firebase-functions");

exports.userAdded = functions.auth.user().onCreate((user) => {
  console.log(`${user.email} is created`);
  return Promise.resolve();
});

exports.userDeleted = functions.auth.user().onDelete((user) => {
  console.log(`${user.email} is deleted`);
  return Promise.resolve();
});
