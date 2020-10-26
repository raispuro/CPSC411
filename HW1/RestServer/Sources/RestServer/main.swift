import Kitura
import Cocoa

let router = Router()
let dbObj = Database.getInstance()

router.all("/ClaimService/add", middleware: BodyParser())
router.get("/"){
    request, response, next in
    response.send("Hello! Welcome to the service")
    next()
}


router.post("/ClaimService/add") {
    //    JSON Deserialization
    request, response, next in
    let body = request.body
    let jObj = body?.asJSON         // JSON Object
    if let jDict = jObj as? [String:String] {
        if let ttl = jDict["title"], let d = jDict["date"] {
            let cObj = Claim(id_: UUID().uuidString, ttl: ttl, d: d, Solved: 0)
            ClaimDAO().addClaim(cObj: cObj)
        }
    }
    response.send("The Claim record was successfully inserted (via POST Method)")
    next()
}

router.get("/ClaimService/getAll") {
    request, response, next in
    let cList = ClaimDAO().getAll()
    //    JSON Serialization
    let jsonData: Data = try JSONEncoder ().encode(cList)
    //    JSONArray
    let jsonStr = String(data: jsonData, encoding: .utf8)
    response.send(jsonStr)
    next()
}




Kitura.addHTTPServer(onPort: 8090, with: router)
Kitura.run()
