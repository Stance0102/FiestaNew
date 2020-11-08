//
//  _School_Email.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/16.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

var School_C_Email: [String] = []
var School_E_Email: [String] = []

func GetEmail() {
    let url = URL(string: "http://163.18.42.222:4000/Fiestadb/getSchool")
    AF.request(url!).validate().responseJSON { (response) in
        switch response.result {
            case .success(let value):
                let SchoolJSON = JSON(value)
                let DataCount:Int? = SchoolJSON["result"][0].count
                for i in 0..<DataCount! {
                    School_E_Email.insert(SchoolJSON["result"][0][i].string!, at: i)
                    School_C_Email.insert(SchoolJSON["result"][1][i].string!, at: i)
                }
            
            case .failure(let error):
                print(error)
                
        }
    }
}
