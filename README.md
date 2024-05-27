## Dokumentasi

GET `/mobil`

Response:

Status Code: 200

```
{
  "status": "Success",
  "message": "Berhasil mengambil daftar mobil",
  "data": [
    {
      "id": "0123456789",
      "merek_jenis": "Toyota Innova"
    },
    ...
  ]
}
```

---

GET `/mobil/:id`

Response:

Status Code: 200

```
{
  "status": "Success",
  "message": "Berhasil mengambil mobil',
  "data": {
    "id": "0123456789",
    "merek_jenis": "Toyota Innova"
  },
}
```

---

POST `/mobil`

Content-type: application/json

Request Body:

```
{
  "id": "01231230",
  "merek_jenis": "mobil UPN"
}
```

Response:

Status Code: 201

```
{
  "status": "Success",
  "message": "Berhasil menambahkan mobil",
}
```

---

PUT `/todos/:id`

Content-type: application/json

Request Body:

```
{
  "new_id":"1234567890",
  "merek_jenis": "Toyota Innova"
}
```

Response:

Status Code: 201

```
{
  "status": "Success",
  "message": "Berhasil mengubah mobil",
}
```

---

DELETE `/todos/:id`

Response:

Status Code: 200

```
{
  "status": "Success",
  "message": "Berhasil menghapus mobil",
}
```
