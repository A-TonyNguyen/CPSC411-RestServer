//  Name: Tony Nguyen
//  Date: October 25, 2020
//
//  Database.swift
//  RestServer

import Kitura
import Cocoa

print("The REST server is starting.")

let router = Router()

router.all("/ClaimService/add", middleware: BodyParser())

router.get("ClaimService/getAll")
{
    request, response, next in
    let cList = ClaimDao().getAll()
    // JSON Serialization
    let jsonData : Data = try JSONEncoder().encode(cList)
    //JSONArray 
    let jsonStr = String(data: jsonData, encoding: .utf8)
    // set Content-Type
    response.status(.OK)
    response.headers["Content-Type"] = "application/json"
    response.send(jsonStr)
    next()
}

router.post("ClaimService/add")
{
    request, response, next in
    // JSON deserialization on Kitura server 
    let body = request.body
    let jObj = body?.asJSON //JSON object
    
    if let jDict = jObj as? [String:String]
    {
        if let title = jDict["title"],let date = jDict["date"]
        {
            let cObj = Claim(id:UUID(), title:title, date:date, isSolved:false)
            ClaimDao().addClaim(cObj: cObj)
        }
    }
    response.send("The Claim record was successfully inserted (via POST Method).")
    next()
}

Kitura.addHTTPServer(onPort: 8020, with: router)
Kitura.run()

