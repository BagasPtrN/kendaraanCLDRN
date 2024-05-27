## Dokumentasi

GET `/motor`

Response:

Status Code: 200

```
{
  "status": "Success",
  "message": "Berhasil mengambil daftar motor",
  "data": [
    {
      "id": "01234567",
      "merek_jenis": "Suzuki Address"
    },
    ...
  ]
}
```

---

GET `/motor/:id`

Response:

Status Code: 200

```
{
  "status": "Success",
  "message": "Berhasil mengambil motor',
  "data": {
    "id": "01234567",
    "merek_jenis": "Suzuki Address"
  },
}
```

---

POST `/motor`

Content-type: application/json

Request Body:

```
{
  "id": "01231230",
  "merek_jenis": "motor UPN"
}
```

Response:

Status Code: 201

```
{
  "status": "Success",
  "message": "Berhasil menambahkan motor",
}
```

---

PUT `/todos/:id`

Content-type: application/json

Request Body:

```
{
  "id": "01234567",
  "merek_jenis": "Suzuki Address"
}
```

Response:

Status Code: 201

```
{
  "status": "Success",
  "message": "Berhasil mengubah motor",
}
```

---

DELETE `/todos/:id`

Response:

Status Code: 200

```
{
  "status": "Success",
  "message": "Berhasil menghapus motor",
}
```
