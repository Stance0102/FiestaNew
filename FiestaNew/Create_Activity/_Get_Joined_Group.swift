//
//  _Get_Joined_Group.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/17.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Combine

struct GroupList_Struct {
    let Name: String
    let Id: String
}

class Group_Cls: ObservableObject {
    @Published var GroupList: [GroupList_Struct] = []
    
    func Get_Joined_Group()
    {
        var GroupCount: Int?
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Account/getJoinedGroup")!
        let json: [String:Any] = [
            "authId": (UserDefaults.standard.value(forKey: "AuthID")!),
        ]
        let header: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(String(describing: UserDefaults.standard.value(forKey: "Token")!).utf8)"
        ]
        var ErrorCode: String = ""
        
        print("Bearer \(String(describing: UserDefaults.standard.value(forKey: "Token")!).utf8)")
        
        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseData { (response) in
            switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    let DataJSON = try? JSON(data: data)
                    debugPrint(DataJSON!["result"])
                    ErrorCode = DataJSON!["code"].string!
                    GroupCount = DataJSON!["result"].count
                    
                    if ErrorCode == "001"
                    {
                        for i in 0..<GroupCount!
                        {
                            let GroupName = DataJSON!["result"][i]["groupName"].string!
                            let GroupId = DataJSON!["result"][i]["groupId"].string!
                            
                            self.GroupList.append(GroupList_Struct(Name: GroupName, Id: GroupId))
                            //debugPrint((GroupList[i]))
                        }
                    }
                    else
                    {
                        debugPrint("GroupList: \(DataJSON)")
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
