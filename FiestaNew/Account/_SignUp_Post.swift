//
//  _SignUp_Post.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/17.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

func postSignUpJSON(UserName MyUserName: String, UserId MyUserId: String, Password MyPassword: String, Email: String) -> String
{
    
    let json: [String: Any] = ["userName" : MyUserName, "userId" : MyUserId, "userPassword" : MyPassword, "Mail_1" : Email,  "Useable" : "true"]
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Account/upload")!
    var request = URLRequest(url: url)
    var ErrorCode: String?
    
    request.httpMethod = "POST"
    request.httpBody = jsonData
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }catch let error{
        print(error.localizedDescription)
    }
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No Data")
            return
        }
        
        if let responseJSON = try? JSON(data: data){
            ErrorCode = responseJSON["code"].string
            print(responseJSON)
        }
        
    }
    task.resume()
    usleep(3000000)
    
    return ErrorCode!
}

func SendConfirmJSON(UserId MyUserId: String, SendConfirmType Type: String) -> String
{
    
    let json: [String: Any] = ["userId" : MyUserId, "type": Type]
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    let url = URL(string: "http://163.18.42.222:4000/Fiestadb/Account/SendConfirm")!
    var request = URLRequest(url: url)
    var ErrorCode: String?
    
    request.httpMethod = "POST"
    request.httpBody = jsonData
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }catch let error{
        print(error.localizedDescription)
    }
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No Data")
            return
        }
        
        if let responseJSON = try? JSON(data: data){
            ErrorCode = responseJSON["code"].string
            print(responseJSON)
        }
        
    }
    task.resume()
    usleep(3000000)
    
    return ErrorCode!
}
