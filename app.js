// Mengimport package
const express = require("express");
const cors = require("cors");
const app = express();
const port = 3100;
const motorRouter = require("./motor");

// Supaya API dapat diakses di domain yang berbeda
app.use(cors());

// Buat ngubah request body yang berupa json ke dalam object
app.use(express.json());

app.use("/motor", motorRouter);

app.get("/", (req, res) => {
  res.send("Hello from motor-service! 😁");
});

// Menjalankan server di port 3100
app.listen(port, () => console.log("Server terkoneksi pada port " + port));
