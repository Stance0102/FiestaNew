//
//  _Ticket.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/10/28.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import Combine

struct Ticket_Kinds {
    let Id: String
    let Mounts: String
    let Price: String
    let Remainder: String
    let Useable: String
    let Act_Id: String
    let TicketKinds: String
}

struct Unexpired_Activity {
    let Photo: String
    let Act_Description: String
    let Act_Id: String
    let Act_Name: String
    let StartTime: String
    let TicketKinds: String
    let TicketStatus: String
}

var Ticket_Alert: String = "購票前，請務必確認票種！"

class Ticket: ObservableObject
{
    @Published var Ticket_Array: [Ticket_Kinds] = []
    @Published var MyTicket_Array: [Unexpired_Activity] = []
    
    func Post_Ticker_By_Act(ActId: String)
    {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Ticket/SelectByAct")!
        let json: [String:Any] = [
            "act_Id": ActId
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
                    debugPrint(DataJSON!)
                    let ErrorCode: String = DataJSON!["code"].string!
                    let Result_Count: Int = DataJSON!["result"].count
                    self.Ticket_Array.removeAll()
                    
                    if ErrorCode == "001"
                    {
                        for i in 0..<Result_Count {
                            let Id = DataJSON!["result"][i]["Id"].string!
                            let Mounts = DataJSON!["result"][i]["Mounts"].string!
                            let Price = DataJSON!["result"][i]["Price"].string!
                            let Remainder = DataJSON!["result"][i]["Remainder"].string!
                            let Useable = DataJSON!["result"][i]["Useable"].string!
                            let Act_Id = DataJSON!["result"][i]["act_Id"].string!
                            let TicketKind = DataJSON!["result"][i]["ticketKinds"].string!
                            
                            self.Ticket_Array.append(Ticket_Kinds(Id: Id, Mounts: Mounts, Price: Price, Remainder: Remainder, Useable: Useable, Act_Id: Act_Id, TicketKinds: TicketKind))
                        }
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
    
    func Post_BuyTicket(Act_Id: String, TicketKinds: String?, Notes: String = ""){
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Activity/setJoinedList")!
        var json: [String:Any] = [
            "authId": "\(String(describing: UserDefaults.standard.value(forKey: "AuthID")!))",
            "act_Id" : Act_Id,
            "Notes": Notes
        ]
        
        if TicketKinds != nil {
            json["ticketKinds"] = TicketKinds
        }
        
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
                    debugPrint(DataJSON!)
                    let ErrorCode: String = DataJSON!["code"].string!
                    
                    if ErrorCode == "001"
                    {
                        //
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
    
    func Post_MyTicker_Info()
    {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Account/getUnexpiredAct")!
        let json: [String:Any] = [
            "authId": "\(UserDefaults.standard.value(forKey: "AuthID")!)",
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
                    debugPrint(DataJSON!)
                    let ErrorCode: String = DataJSON!["code"].string!
                    let Result_Count: Int = DataJSON!["result"].count
                    if ErrorCode == "001"
                    {
                        for i in 0..<Result_Count {
                            let Photo = DataJSON!["result"][i]["Photo"].string!
                            let Act_Description = DataJSON!["result"][i]["act_Description"].string!
                            let Act_Id = DataJSON!["result"][i]["act_Id"].string!
                            let Act_Name = DataJSON!["result"][i]["act_Name"].string!
                            let StartTime = DataJSON!["result"][i]["startTime"].string!
                            let TicketKinds = DataJSON!["result"][i]["ticketKinds"].string!
                            let TicketStatusCode = DataJSON!["result"][i]["ticketStatus"].string!
                            var TicketStatus: String
                            
                            if TicketStatusCode == "0" {
                                TicketStatus = "未使用"
                            }else{
                                TicketStatus = "已使用"
                            }
                            
                            self.MyTicket_Array.append(Unexpired_Activity(Photo: Photo, Act_Description: Act_Description, Act_Id: Act_Id, Act_Name: Act_Name, StartTime: StartTime, TicketKinds: TicketKinds, TicketStatus: TicketStatus))
                        
                        }
                    }
                    else if ErrorCode == "013"
                    {
                        Ticket_Alert = "無未過期活動"
                    }
                    break
                case .failure(let error):
                    print("Error:\(error)")
                    break
            }
        }
    }
}
