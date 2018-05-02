//
//  SWFeedbackOverHttpService.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWFeedbackOverHttpService: SWFeedbackService {
    
    private func request(email: String?, isAnonymous: Bool?, stuff: String?) {
        
        var parameters: [String : Any] = [:]
        if let email = email {
            parameters["email"] = email
        }
        if let isAnonymous = isAnonymous {
            parameters["isAnonymous"] = isAnonymous
        }
        if let stuff = stuff {
            parameters["stuff"] = stuff
        }

        //create the url with URL
        let url = URL(string: "http://52.166.112.123:3000/api/iwant?stuff=steps")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func requestStepsFunctionality() -> Void {
        print("steps requested")
        request(email: nil, isAnonymous: true, stuff: "steps")
    }
    
    func requestStepsFunctionality(contact email: String) -> Void {
        print("steps requested, contact @ \(email)")
        request(email: email, isAnonymous: false, stuff: "steps")
    }
    
}
