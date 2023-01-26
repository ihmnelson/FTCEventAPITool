import Foundation
import Alamofire

var scheduleDataString = ""


func createBasicBase64Token(username: String, authToken: String) -> String {
    let combined = "\(username):\(authToken)"
    if let encoded = combined.data(using: .utf8)?.base64EncodedString() {
        return "Basic \(encoded)"
    } else {
        return "ERROR combined.data(using) returned nil value"
    }
}

let encodedToken = createBasicBase64Token(username: "ihmnelson", authToken: "909C9EF4-45C5-4B23-BFCF-0716E02BD6C0")

debugPrint(encodedToken)

let headers: HTTPHeaders = [
    .authorization(encodedToken)
]

let season = "2022"
let eventCode = "USWABES4"
let eventLevel = "qual"

let defaultSession = URLSession.shared
let url = URL(string: "https://ftc-api.firstinspires.org/v2.0/\(season)/schedule/\(eventCode)/\(eventLevel)/hybrid")!
let request = try!URLRequest(url: url, method: HTTPMethod(rawValue: "GET"), headers: headers)
defaultSession.dataTask(with: request) {data, response, error in
 if (error != nil) {print(error as Any)}
 // Handle json
 if let data = data {
     do {
         let schedule = try JSONDecoder().decode(Schedule.self, from: data)
         print("SCHEDULE BELOW HERE")
         print(schedule)
     } catch let error {
         print("ERROR BELOW HERE")
         print(error)
     }
 }
}.resume()
