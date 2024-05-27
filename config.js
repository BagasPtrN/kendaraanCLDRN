const mysql = require("mysql2");

const config = {
  host: "34.67.40.104",
  user: "root",
  password: "xL+@ggs(UGBz#Lil",
  database: "motomobi",
};

const connect = mysql.createConnection(config);

connect.connect((err) => {
  if (err) throw err;
  console.log("MySQL Connected");
});

module.exports = connect;
