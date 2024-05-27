// Mengimport package
const express = require("express");
const router = express.Router();
const connection = require("./config");

// [GET] Mengambil daftar mobil
router.get("/", async (req, res) => {
  try {
    // Execute query ke database
    const command = "SELECT * FROM mobil";
    const data = await connection.promise().query(command);

    // Mengirimkan respons jika berhasil
    res.status(200).json({
      status: "Success",
      message: "Berhasil mengambil daftar mobil",
      data: data[0],
    });
  } catch (error) {
    // mengirimkan respons jika gagal
    res.status(error.statusCode || 500).json({
      status: "Error",
      message: error.message,
    });
  }
});

// [POST] Memasukkan mobil baru ke dalam daftar mobil
router.post("/", async (req, res) => {
  try {
    // mengambil merek_jenis dan id dari request body
    const { merek_jenis, id } = req.body;

    // kalau merek_jenis/id kosong atau gaada kolom merek_jenis/id di request body
    if (!merek_jenis || !id) {
      const msg = `${!merek_jenis ? "Merek_jenis" : "ID"} gabole kosong 😠`;
      const error = new Error(msg);
      error.statusCode = 401;
      throw error;
    }

    // Execute query ke database
    const command = "INSERT INTO mobil (merek_jenis, id) VALUES (?, ?)";
    await connection.promise().query(command, [merek_jenis, id]);

    // mengirimkan respons jika berhasil
    res.status(201).json({
      status: "Success",
      message: "Berhasil menambahkan mobil",
    });
  } catch (error) {
    // mengirimkan respons jika gagal
    res.status(error.statusCode || 500).json({
      status: "Error",
      message: error.message,
    });
  }
});

// [PUT] Mengubah data mobil berdasarkan id
router.put("/:id", async (req, res) => {
  try {
    // mengambil merek_jenis dan id dari request body
    const { id } = req.params;
    const { merek_jenis } = req.body;

    /// kalau merek_jenis/id kosong atau gaada kolom merek_jenis/id di request body
    if (!merek_jenis || !id) {
      const msg = `${!merek_jenis ? "Merek_jenis" : "ID"} gabole kosong 😠`;
      const error = new Error(msg);
      error.statusCode = 401;
      throw error;
    }

    // Execute query ke database
    const command = "UPDATE mobil SET merek_jenis = ? WHERE id = ?";
    await connection.promise().query(command, [merek_jenis, id]);

    // mengirimkan respons jika berhasil
    res.status(201).json({
      status: "Success",
      message: "Berhasil mengubah mobil",
    });
  } catch (error) {
    // mengirimkan respons jika gagal
    res.status(error.statusCode || 500).json({
      status: "Error",
      message: error.message,
    });
  }
});

// [DELETE] Menghapus suatu mobil berdasarkan id
router.delete("/:id", async (req, res) => {
  try {
    const { id } = req.params;

    // Execute query ke database
    const command = "DELETE FROM mobil WHERE id = ?";
    await connection.promise().query(command, [id]);

    // mengirimkan respons jika berhasil
    res.status(200).json({
      status: "Success",
      message: "Berhasil menghapus mobil",
    });
  } catch (error) {
    // mengirimkan respons jika gagal
    res.status(error.statusCode || 500).json({
      status: "Error",
      message: error.message,
    });
  }
});

// [GET] Mengambil mobil berdasarkan ID
router.get("/:id", async (req, res) => {
  try {
    // mengambil id dari parameter
    const { id } = req.params;

    // Execute query ke database
    const command = "SELECT * FROM mobil WHERE id = ?";
    const [[data]] = await connection.promise().query(command, [id]);

    if (!data) {
      const error = new Error("Mobil tidak ditemukan.");
      error.statusCode = 404;
      throw error;
    }

    // Mengirimkan respons jika berhasil
    res.status(200).json({
      status: "Success",
      message: "Berhasil mengambil mobil",
      data: data,
    });
  } catch (error) {
    // mengirimkan respons jika gagal
    res.status(error.statusCode || 500).json({
      status: "Error",
      message: error.message,
    });
  }
});

module.exports = router;
