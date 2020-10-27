# Rest Server

A REST server which will manage the following Claim entity in its SQLite3 database:  

| Property Name |                      Description                      | Data Type |
|:-------------:|:-----------------------------------------------------:|:---------:|
| id            | Unique claim id, randomly generated UUID              | UUID      |
| title         | Claim tile, brief description about the claim         | String    |
| date          | The data (format “yyyy MM-dd”) when the claim happens | String    |
| isSolved      | This indicates if the claim is closed                 | boolean   |


