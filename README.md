<!--
SPDX-FileCopyrightText: 2022 Risk.Ident GmbH <contact@riskident.com>

SPDX-License-Identifier: CC-BY-4.0
-->

# gocrud

[![REUSE status](https://api.reuse.software/badge/github.com/RiskIdent/gocrud)](https://api.reuse.software/info/github.com/RiskIdent/gocrud)

Simple CRUD application that exposes an HTTP REST API to store data inside
a MongoDB database.

## Usage

### Configuration

gocrud is configured via command-line flags or environment variables.

| Flag             | Environment variable  | Default                     | Description             |
| ---------------- | --------------------- | --------------------------- | ----------------------- |
| `--bind-address` | `GOCRUD_BIND_ADDRESS` | `0.0.0.0:8080`              | Address to serve API on |
| `--mongo-uri`    | `GOCRUD_MONGO_URI`    | `mongodb://localhost:27017` | MongoDB URI to use      |
| `--mongo-db`     | `GOCRUD_MONGO_DB`     | `gocrud`                    | MongoDB database to use |

### MongoDB authentication

Authentication can be provided via the MongoDB URI. Example:

```properties
GOCRUD_MONGO_URI=mongodb://admin:password@localhost:27017
```

## API

By default, gocrud exposes the following endpoints on port 8080:

- [`POST /v1/pet` Create pet](#create-pet)
- [`GET /v1/pet` Get pet](#get-pet)

### Create pet

Creates a new pet, and returns the ID of the pet created.

```http
POST /v1/pet
Accept: application/json
Content-Type: application/json

{
  "name": "string",
  "species": "string",
  "breed": "string"
}
```

<details><summary>Responses (click to expand)</summary>

> - Object successfully created
>
> ```http
> HTTP/1.1 200 OK
> Content-Type: application/json; charset=utf-8
>
> {
>   "id": "string"
> }
> ```

> - Invalid request body
>
> ```http
> HTTP/1.1 400 Bad Request
> Content-Type: application/json; charset=utf-8
>
> {
>   "error": "string"
> }
> ```

> - Failed to create object in database
>
> ```http
> HTTP/1.1 500 Internal Server Error
> Content-Type: application/json; charset=utf-8
>
> {
>   "error": "string"
> }
> ```

</details>

### Get pet

Retrieves an existing pet.

```http
GET /v1/pet/:id
Accept: application/json
```

Parameters:

- `:id` _(path)_: ID of the pet object,
  formatted as a 24-character long hexadecimal number.

<details><summary>Responses (click to expand)</summary>

> - Object successfully retrieved.
>
> ```http
> HTTP/1.1 200 OK
> Content-Type: application/json; charset=utf-8
>
> {
>   "id": "string",
>   "name": "Grande Hazelnut Mc.Muffin",
>   "species": "dog",
>   "breed": "Dobermann"
> }
> ```

> - Invalid `:id` parameter format.
>
> ```http
> HTTP/1.1 400 Bad Request
> Content-Type: application/json; charset=utf-8
>
> {
>   "error": "string"
> }
> ```

> - No pet was found with the ID of `:id`
>
> ```http
> HTTP/1.1 404 Not Found
> Content-Type: application/json; charset=utf-8
>
> {
>   "error": "string"
> }
> ```

> - Failed to retrieve object from database.
>
> ```http
> HTTP/1.1 500 Internal Server Error
> Content-Type: application/json; charset=utf-8
>
> {
>   "error": "string"
> }
> ```

</details>

## Development

### Prerequisites

- Go 1.20 (or higher)
- A way to run MongoDB locally, e.g via a container using [Podman](https://podman.io/)

### Running locally

1. Start up a local MongoDB instance, for example via [Podman](https://podman.io/):

   ```sh
   podman run --rm -it -p 27017:27017 mongo
   ```

2. Run gocrud locally, e.g:

   ```bash
   go run .
   ```

3. To test out the webhooks, you can make use of our example webhook like so:

   ```console
   $ curl localhost:8080/v1/pet --json @examples/pet.json
   {"id":"63d00f3a87cb268ed07657e6"}

   $ curl localhost:8080/v1/pet/63d00f3a87cb268ed07657e6
   {"id":"63d00f3a87cb268ed07657e6","name":"Grande Hazelnut Mc.Muffin","species":"dog","breed":"Dobermann"}
   ```

## License

This repository complies with the [REUSE recommendations](https://reuse.software/).

Different licenses are used for different files. In general:

- Go code is licensed under GNU General Public License v3.0 or later ([LICENSES/GPL-3.0-or-later.txt](LICENSES/GPL-3.0-or-later.txt)).
- Documentation licensed under Creative Commons Attribution 4.0 International ([LICENSES/CC-BY-4.0.txt](LICENSES/CC-BY-4.0.txt)).
- Miscellaneous files, e.g `.gitignore`, are licensed under CC0 1.0 Universal ([LICENSES/CC0-1.0.txt](LICENSES/CC0-1.0.txt)).

Please see each file's header or accompanied `.license` file for specifics.
