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
