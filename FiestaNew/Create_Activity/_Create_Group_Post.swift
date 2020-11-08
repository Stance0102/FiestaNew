//
//  _Create_Group_Post.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/17.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

var GroupID: String = ""

func PostCreateGroup(GroupName: String, Address: String?, Mail: String, PhoneNumber: String?, Photo: String? = nil, DeadLine: Date, TimeStatus: Bool)
{
    let today = Date()
    let formatter3 = DateFormatter()
    formatter3.dateFormat = "y-M-d HH:mm:ss"
    print(formatter3.string(from: today))
    
    let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Group/upload")!
    let json: [String:Any] = [
        "authId": [(UserDefaults.standard.value(forKey: "AuthID"))],
        "groupName": String(GroupName),
        //"Address": String(Address!),
        "Mail": String(Mail),
        //"Phone": String(PhoneNumber!),
        //"Photo": Photo,
        //"timeStatus": String(TimeStatus),
        "deadLine": String(formatter3.string(from: today)),
        "Useable": "true"
    ]
    
    let headers: HTTPHeaders = [
        "Accept": "application/json",
        "Authorization": "Bearer \(String(describing: UserDefaults.standard.value(forKey: "Token")!).utf8)"
    ]
    
    
    AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
        switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data:data)
                debugPrint(DataJSON!)
                GroupID = DataJSON!["result"][0]["groupId"].string!
                break
            case .failure(let error):
                print("Error:\(error)")
                break
        }
    }
}

/*
func PostCreateGroup(GroupName: String, Address: String? = nil, Mail: String, PhoneNumber: String? = nil, Photo: String? = nil, DeadLine: Date, TimeStatus: Bool)
{
    let json: [String: Any] = [
        "authId": [UserDefaults.standard.value(forKey: "UserID")],
        "groupName": GroupName,
        //"Address": Address,
        "Mail": Mail,
        //"Phone": PhoneNumber,
        //"Photo": Photo,
        "timeStatus": "\(TimeStatus)",
        //"deadLine": formatter3.string(from: today),
        "Useable": "true"
    ]
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Group/upload")!
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
    request.addValue("Authorization", forHTTPHeaderField: "Bearer \(String(describing: UserDefaults.standard.value(forKey: "Token")))")
    
    print((String(describing: UserDefaults.standard.value(forKey: "Token"))))
    
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
}
*/
