//
//  _Create_Act_Post.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/10/15.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

func PostCreateAct(GroupId: String, Act_Name: String, StartTime: Date, EndTime: Date ,Act_Des: String, PeopleMaxium: String)
{
    let Selected_Tag_String: String = TagName
    let formatter3 = DateFormatter()
    formatter3.dateFormat = "y-M-d HH:mm:ss"
    let StartTime_Str: String = formatter3.string(from: StartTime)
    let EndTime_Str: String = formatter3.string(from: EndTime)
    let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Activity/upload")!
    let json: [String:Any] = [
        "act_Name": String(Act_Name),
        "groupId": String(GroupId),
        "Tag": Selected_Tag_String,
        "act_Description": Act_Des,
        "startTime": StartTime_Str,
        "endTime": EndTime_Str,
        "act_Status": "true",
        "viewStatus": "true",
        "peopleMaxium": String(PeopleMaxium),
        "Useable": "true"
    ]
    
    let headers: HTTPHeaders = [
        "Accept": "application/json",
        "Authorization": "Bearer \(String(describing: UserDefaults.standard.value(forKey: "Token")!).utf8)"
    ]
    
    print(json)
    
    AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
        switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data:data)
                debugPrint(DataJSON)
                //GroupID = DataJSON!["result"][0]["groupId"].intValue
                break
            case .failure(let error):
                print("Error:\(error)")
                break
        }
    }
}
