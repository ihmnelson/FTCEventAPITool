//
//  DataHandler.swift
//  FTCEventAPITool
//
//  Created by Isaac Nelson on 1/22/23.
//

import Foundation
import Alamofire

// MARK: Controller class
class Controller: ObservableObject {
    let userDefaults = UserDefaults.standard
    
    @Published var schedule: Schedule
    @Published var eventCode: String = "USWABES4"
    @Published var eventLevel: String = "qual"
    @Published var season: String = "2022"
    @Published var username: String {
        didSet {
            userDefaults.set(username, forKey: "username")
        }
    }
    @Published var authToken: String {
        didSet {
            userDefaults.set(authToken, forKey: "authToken")
        }
    }
    @Published var encodedToken: String {
        didSet {
            userDefaults.set(encodedToken, forKey: "encodedToken")
        }
    }
    
    init() {
        if (userDefaults.string(forKey: "username") == nil) {
            userDefaults.set("", forKey: "username")
        }
        if (userDefaults.string(forKey: "authToken") == nil) {
            userDefaults.set("", forKey: "authToken")
        }
        if (userDefaults.string(forKey: "encodedToken") == nil) {
            userDefaults.set("", forKey: "encodedToken")
        }
        
        username = userDefaults.string(forKey: "username")!
        authToken = userDefaults.string(forKey: "authToken")!
        encodedToken = userDefaults.string(forKey: "encodedToken")!
//        schedule = Schedule()
    }
    
    func refreshData() {
        // MARK: Schedule refresh
        // TODO: Add actual error handling
        let headers: HTTPHeaders = [
            .authorization(encodedToken)
        ]
        // URLSession
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
        
        // MARK: Match data refresh
        
    }
    
    func refreshEncodedToken() {
        encodedToken = createBasicBase64Token(username: username, authToken: authToken)
    }
    
    func createBasicBase64Token(username: String, authToken: String) -> String {
        let combined = "\(username):\(authToken)"
        if let encoded = combined.data(using: .utf8)?.base64EncodedString() {
            return "Basic \(encoded)"
        } else {
            return "ERROR combined.data(using) returned nil value"
        }
    }
}
