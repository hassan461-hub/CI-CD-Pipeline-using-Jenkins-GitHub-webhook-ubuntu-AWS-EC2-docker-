const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: "db",
  user: "root",
  password: "root123",
  database: "myappdb"
});

app.get("/", (req, res) => {
  res.send("Backend Running");
});

app.get("/data", (req, res) => {
  db.query("SELECT 'Hello from hassan abid", (err, result) => {
    if (err) return res.status(500).json(err);
    res.json(result);
  });
});

app.listen(3000, () => {
  console.log("Backend running on port 3000");
});
