import Foundation
import Alamofire


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

let defaultSession = URLSession.shared

let url = URL(string: "https://ftc-api.firstinspires.org/v2.0/2022/schedule/USWABES4/qual/hybrid")!

let request = try!URLRequest(url: url, method: HTTPMethod(rawValue: "GET"), headers: headers)

let task = defaultSession.dataTask(with: request) {data, response, error in
    if let data = data {
        // Handle json
        if let jsonString = String(data: data, encoding: .utf8) {
            debugPrint(jsonString)
        }
    } else if let error = error {
        dump(error)
    }
}
task.resume()
