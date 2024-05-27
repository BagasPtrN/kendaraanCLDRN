const express = require("express");
const cors = require("cors");
const mobilRouter = require("./mobil");
const port = "3100";
const app = express();

app.use(cors());
app.use(express.json());
app.use("/mobil", mobilRouter);

app.get("/", (req, res) => {
  res.send("Welcome to mobil-service! 😁");
});

app.listen(port, () => {
  console.log("Server Connected on PORT: " + port + "/");
});
