//
//  _LogIn_Post.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/17.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

func PostLoginJSON(UserId MyUserId: String, Password MyPassword: String)
{
    let json: [String: Any] = ["userId": MyUserId, "userPassword": MyPassword]
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Account/select")!
    var request = URLRequest(url: url)
    
    
    var AccountData: JSON?
    var errorCode: String?
    var authID: Int = 0
    var userID: String?
    var userName: String?
    var userPassword: String?
    var email: String?
    var token: String?
    
    request.httpMethod = "POST"
    request.httpBody = jsonData
    
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }catch let error{
        print(error.localizedDescription)
    }
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let serialQueue: DispatchQueue = DispatchQueue(label: "SerialQueue")
    serialQueue.sync {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let TestResponseJSON = try? JSON(data: data){
                    print(TestResponseJSON)
                    errorCode = TestResponseJSON["code"].string!
                    if errorCode! as AnyObject !== "001" as AnyObject {
                        ErrorCodeAction(ErrorCode: errorCode!, AuthID: authID, UserID: "", UserName: "",  Email: "", Token: "")
                        print(errorCode!)
                    }
                    else
                    {
                        authID = TestResponseJSON["result"][0]["Id"].intValue
                        userID = TestResponseJSON["result"][0]["userId"].string!
                        userName = TestResponseJSON["result"][0]["userName"].string!
                        //userPassword = TestResponseJSON["result"][0]["userPassword"].string!
                        email = TestResponseJSON["result"][0]["Mail_1"].string!
                        token = TestResponseJSON["result"][0]["token"].string!
                        
                        ErrorCodeAction(ErrorCode: errorCode!, AuthID: authID, UserID: userID!, UserName: userName!,  Email: email!, Token: token!)
                        
                        print(TestResponseJSON["result"])
                    }
                }
            }
        }
        task.resume()
    }
}

func ErrorCodeAction(ErrorCode: String, AuthID: Int, UserID: String, UserName: String, Email: String, Token: String)
{
    switch ErrorCode {
    case "001":
        // keyChain.synchronizable = true
        // keyChain.set(UserID, forKey: "UserID")
        // keyChain.set(Token, forKey: "DeviceToken")
        UserDefaults.standard.set(AuthID, forKey: "AuthID")
        UserDefaults.standard.set(UserID, forKey: "UserID")
        UserDefaults.standard.set(UserName, forKey: "UserName")
        UserDefaults.standard.set(Email, forKey: "Email")
        UserDefaults.standard.set(Token, forKey: "Token")
        
        print((UserDefaults.standard.value(forKey: "AuthID")!))
        print("Bearer \(String(describing: UserDefaults.standard.value(forKey: "Token")!).utf8)")
    case "002":
        print("沒有這個帳號歐！")
    case "003":
        print("密碼錯誤歐！")
    default:
        print("不知道是哪裡出了問題...")
    }
}
    


