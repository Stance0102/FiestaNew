//
//  _Search_Group_Info.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/10/13.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

var GroupInfo: [String: String]!

func PostSearchGroup(GroupID: String)
{
    let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Group/select")!
    let json: [String:Any] = [
        "groupId": GroupID
    ]
    let headers: HTTPHeaders = [
        "Accept": "application/json",
        "Authorization": "Bearer \(String(describing: UserDefaults.standard.value(forKey: "Token")!).utf8)"
    ]
    
    AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
        switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data: data)
                debugPrint(DataJSON!)
                let ErrorCode: String = DataJSON!["code"].string!
                if ErrorCode == "001" {
                    let GroupName = DataJSON!["result"][0]["groupName"].string!
                    let GroupId = DataJSON!["result"][0]["groupId"].string!
                    
                    Return_GroupInfo(GroupID, GroupName)
                }
                break
            case .failure(let error):
                print("Error:\(error)")
                break
        }
    }
}

func Return_GroupInfo(_ GroupId: String, _ GroupName: String)
{
    GroupInfo = ["GroupID": GroupId, "GroupName": GroupName]
    print(GroupInfo!)
}
