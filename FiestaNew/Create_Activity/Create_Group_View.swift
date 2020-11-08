//
//  Create_Group_View.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/9.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI

struct Create_Group_View: View {
    @State private var GroupName: String = ""
    @State private var Address: String = ""
    @State private var Email: String = (UserDefaults.standard.value(forKey: "Email") as? String)!
    @State private var PhoneNumber: String = ""
    @State private var AddMember: String = ""
    @State private var Once: Bool = false
    @State private var Act_DateTime = Date()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                ZStack {
                    //Color(red: 232/255, green: 172/255, blue: 76/255)
                        //.edgesIgnoringSafeArea(.all)
                    HStack {
                        Spacer()
                        VStack {
                            
                            Text("建立新群組")
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 25))
                            .bold()
                            
                            Divider()
                            .frame(height: 1)
                            .background(Color.black)
                            
                            HStack {
                                VStack {
                                    Group {
                                        Text("群組名稱")
                                        .foregroundColor(Color.black)
                                        .font(Font.system(size: 18))
                                        .bold()
                                        
                                        TextField("", text: $GroupName)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 300, height: 40)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                    }
                                    .padding(.bottom, 10)
                                    
                                    Group {
                                        Text("地址")
                                        .foregroundColor(Color.black)
                                        .font(Font.system(size: 18))
                                        .bold()
                                        
                                        TextField("", text: $Address)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 300, height: 40)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                    }
                                    .padding(.bottom, 10)
 
                                    Group {
                                        Text("信箱")
                                        .foregroundColor(Color.black)
                                        .font(Font.system(size: 18))
                                        .bold()
                                        
                                        TextField("\(self.Email)  系統將自動帶入此信箱", text: $Email)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 300, height: 40)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                    }
                                    .padding(.bottom, 10)
                                    
                                    Group {
                                        Text("聯絡電話")
                                        .foregroundColor(Color.black)
                                        .font(Font.system(size: 18))
                                        .bold()
                                        
                                        TextField("", text: $PhoneNumber)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 300, height: 40)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                    }
                                    .padding(.bottom, 10)
                                    
                                    Group {
                                        Text("新增成員")
                                        .foregroundColor(Color.black)
                                        .font(Font.system(size: 18))
                                        .bold()
                                        
                                        TextField("", text: $AddMember)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 300, height: 40)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                    }
                                    .padding(.bottom, 10)
                                    
                                    Button(action: {
                                        self.Once.toggle()
                                    }){
                                        Group {
                                            Image(systemName: self.Once ? "checkmark.square.fill":"checkmark.square")
                                                .foregroundColor(Color.blue)
                                                .font(Font.system(size: 18))
                                                .padding(.leading, 10)
                                            Text("一次性群組")
                                            .foregroundColor(Color.black)
                                            .font(Font.system(size: 18))
                                            .bold()
                                        }
                                    }
                                    Text("▲ 活動結束後將刪除資料")
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 18))
                                    .padding(.top, 20)
                                }
                            }
                            .padding(.top, 20)
                            
                            Button(action: {
                                PostCreateGroup(GroupName: GroupName, Address: Address, Mail: Email, PhoneNumber: PhoneNumber, DeadLine: Act_DateTime, TimeStatus: Once)
                            }){
                                Text("下一步")
                                .bold()
                                .foregroundColor(Color.white)
                                    .offset(x: 0, y: -12.5)
                                .background(
                                    Image("ShortBtn")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 55, height: 55)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.top, 35)
                        }
                        .padding(.top ,-80)
                        Spacer()
                    }
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct Create_Group_View_Previews: PreviewProvider {
    static var previews: some View {
        Create_Group_View()
    }
}
