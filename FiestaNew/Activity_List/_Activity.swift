//
//  _Activity.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/5/30.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//
import Foundation
import SwiftyJSON
import Alamofire
import Combine

struct Activity_Info {
    var Act_ID: String
    var Act_Name: String
    var Act_Image: String
    var GroupID: String
    var Tag: String
    var Tags: [String]
    //var PeopleMaium: Int
    var Location: String
    var StartTime: String
    var EndTime: String
    //var Price: Int
    var Act_Description: String
    var Act_Status: String
    //var ViewStatus: Bool
    //var Latitude: Float
    //var Longitude: Float
}

class Activity: ObservableObject {
    @Published var ActivityInfoList: [Activity_Info] = []
    @Published var Act_ID_Array: [String] = []
    
    func Get_Activity_Info()
    {
        //UserDefaults.standard.set("stance0102", forKey: "UserID")
        //let UserID = String(describing: UserDefaults.standard.value(forKey: "UserID")!)
        let json: [String: Any] = [
            "act_Id" : Act_ID_Array
        ]
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Activity/getRecommend")!
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            //"Authorization": "Bearer \(String(describing: UserDefaults.standard.value(forKey: "Token")!).utf8)"
        ]
        print(json)
        
        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    let DataJSON = try? JSON(data:data)
                    let ErrorCode: String = DataJSON!["code"].string!
                    let Result_Count: Int = DataJSON!["result"].count
                    var Act_Status: String = ""
                    
                    debugPrint(DataJSON!)
                    
                    if ErrorCode == "001"
                    {
                        for i in 0..<Result_Count {
                            let Act_ID = DataJSON!["result"][i]["Id"].string!
                            let Act_Name = DataJSON!["result"][i]["act_Name"].string!
                            let Act_Image = DataJSON!["result"][i]["Photo"].string!
                            let GroupID = DataJSON!["result"][i]["groupId"].string!
                            let Location = DataJSON!["result"][i]["Location"].string!
                            let StartTime = DataJSON!["result"][i]["startTime"].string!
                            let EndTime = DataJSON!["result"][i]["endTime"].string!
                            let Act_Description = DataJSON!["result"][i]["act_Description"].string!
                            var Act_Status: String
                            //let PeopleMaium: Int
                            //let Price: Int
                            //let ViewStatus: Bool
                            //let Latitude: Float
                            //let Longitude: Float
                            var Tag: String = ""
                            var Tags: [String] = []
                            var ReadTagCount_Tag: Int = 0

                            self.Act_ID_Array.append(Act_ID)

                            if DataJSON!["result"][i]["act_Status"].string == "1" {
                                Act_Status = "熱賣中"
                            }else{
                                Act_Status = "售鑿"
                            }

                            for _ in 0..<DataJSON!["result"][i]["Tag"].count
                            {
                                if ReadTagCount_Tag == 0
                                {
                                    Tag = DataJSON!["result"][i]["Tag"][ReadTagCount_Tag].string!
                                }
                                else
                                {
                                    Tag += "、\(DataJSON!["result"][i]["Tag"][ReadTagCount_Tag].string!)"
                                }
                                ReadTagCount_Tag += 1
                            }

                            for ReadTagCount_Tags in 0..<DataJSON!["result"][i]["Tag"].count
                            {
                                Tags.append(DataJSON!["result"][i]["Tag"][ReadTagCount_Tags].string!)
                            }

                            self.ActivityInfoList.append(
                                Activity_Info(
                                    Act_ID: Act_ID,
                                    Act_Name: Act_Name,
                                    Act_Image: Act_Image,
                                    GroupID: GroupID,
                                    Tag: Tag,
                                    Tags: Tags,
                                    //PeopleMaium: DataJSON!["result"][i]["peopleMaxium"].int!,
                                    Location: Location,
                                    StartTime: StartTime,
                                    EndTime: EndTime,
                                    //Price: DataJSON!["result"][i]["Price"].int!,
                                    Act_Description: Act_Description,
                                    Act_Status: Act_Status
                                    //ViewStatus: DataJSON!["result"][i]["view_Status"].bool!,
                                    //Latitude: DataJSON!["result"][i]["Latitude"].float!,
                                    //Longitude: DataJSON!["result"][i]["Longitude"].float!
                                )
                            )
                        }
                        UserDefaults.standard.set(self.Act_ID_Array, forKey: "Act_ID")
                    }
                    else if ErrorCode == "013"
                    {
                        Ticket_Alert = "此活動僅提供免費票"
                    }
                    break
                    
                case .failure(let error):
                    print("Error:\(error)")
                    break
            }
        }
    }
}
