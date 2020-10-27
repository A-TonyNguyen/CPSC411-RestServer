# Rest Server

The folder to look at is in Sources/RestServer.

Program Description:

A REST server which will manage the following Claim entity in its SQLite3 database:  

| Property Name |                      Description                      | Data Type |
|:-------------:|:-----------------------------------------------------:|:---------:|
| id            | Unique claim id, randomly generated UUID              | UUID      |
| title         | Claim tile, brief description about the claim         | String    |
| date          | The data (format “yyyy MM-dd”) when the claim happens | String    |
| isSolved      | This indicates if the claim is closed                 | boolean   |


| Service Name         | HTTP Request | HTTP Request |                      HTTP Request                     | HTTP Response |              HTTP Response             |
|----------------------|:------------:|:------------:|:-----------------------------------------------------:|:-------------:|:--------------------------------------:|
|                      |    Method    |  Parameters  |                       Parameters                      |               |                                        |
|                      |              |    Format    |                          Data                         |     Format    |                  Data                  |
| /ClaimService/add    | POST         | JSON         | Claim object without id and isSolved (encoded string) | Plain Text    | Same as the server we implemented      |
| /ClaimService/getAll | GET          |      N/A     |                          N/A                          | JSON          | List of Claim objects (encoded string) |
