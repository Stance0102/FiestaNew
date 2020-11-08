//
//  _TagManager.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/8/13.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Combine

var TagName: String = ""

class TagManager: ObservableObject, Identifiable {
    @Published var Selected_Tag: [String: Bool] = [:]
    @Published var Tag_List: [String] = []
    var Tag_Array: [String] = []
    var TagCount: Int = 0
    var others: Int
    var row: Int
    
    init()
    {
        func GetTag() {
            let url = URL(string: "http://163.18.42.222:4000/Fiestadb/Tag/select")
            AF.request(url!).validate().responseJSON { (response) in
                switch response.result {
                    case .success(let value):
                        
                        let TagJSON = JSON(value)
                        let DataCount:Int = TagJSON["result"][0].count
                        self.TagCount = DataCount
                        
                        for i in 0..<DataCount {
                            self.Tag_List.append(TagJSON["result"][0][i].string!)
                        }
                    
                    case .failure(let error):
                        print(error)
                }
            }
        }
        
        others = TagCount%4
        row = TagCount/4
        
        var test: Int = 0
        var j = 0
        var Tag_Func: () = {
            if others != 0 {
                row += 1
            }else{
                test = 4
                others = others - test
            }
        }()
        
        for tagName in Tag_List
        {
            Selected_Tag[tagName] = false
        }
    }
    
    func updateData(_ Index: Int, _ Item: Int)
    {
        if Selected_Tag[Tag_List[Index*4+Item+others]]! == false
        {
            Selected_Tag[Tag_List[Index*4+Item+others]] = true
            Add_Tag_Array(Tag_List[Index*4+Item+others])
            print("\n")
            print("------")
            print(Selected_Tag)
            print("------")
            print(Tag_Array)
            print("\n")
        }
        else
        {
            Selected_Tag[Tag_List[Index*4+Item+others]] = false
            Remove_Tag_Array(Tag_List[Index*4+Item+others])
            print("\n")
            print("------")
            print(Selected_Tag)
            print("------")
            print(Tag_Array)
            print("\n")
        }
    }
    
    func getData(_ Index: Int, _ Item: Int) -> Bool
    {
        return Selected_Tag[Tag_List[Index*4+Item+others]]!
    }
    
    func Add_Tag_Array(_ Tag: String)
    {
        Tag_Array.append(Tag)
        Tag_String()
    }
    
    func Remove_Tag_Array(_ Tag: String)
    {
        Tag_Array.removeAll { (tag) -> Bool in
           let isRemove = tag == Tag
           return isRemove
        }
        Tag_String()
    }
    
    func Tag_String()
    {
        TagName = ""
        for i in 0..<Tag_Array.count {
            if TagName == "" {
                TagName = "\(Tag_Array[i])"
                print("-----")
                print(TagName)
                print("-----")
            }else{
                TagName += ",\(Tag_Array[i])"
                print("-----")
                print(TagName)
                print("-----")
            }
        }
        print(Tag_Array)
        print("I'm \(TagName)")
    }
}
