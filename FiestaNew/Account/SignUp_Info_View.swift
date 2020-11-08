//
//  SignUp_Info_View.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/16.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI

struct SignUp_Info_View: View {
    @State var UserName: String = ""
    @State var RealName: String = ""
    @State var Password: String = ""
    @State var VerityPassword: String = ""
    @State var Skl_Email: String
    @State private var ShowAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                HStack {
                    Spacer()
                    VStack {
                        Text("填寫個人資料")
                        .foregroundColor(Color.black)
                        .bold()
                        .font(Font.system(size: 25))
                        
                        Divider()
                        .padding([.top,.bottom],40)
                        
                        Group {
                            Text("帳號")
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 18))
                            .bold()
                            
                            TextField("", text: $UserName)
                            .multilineTextAlignment(.center)
                            .frame(width: 300, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        }
                        .padding(.bottom, 10)
                        
                        Group {
                            Text("本名")
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 18))
                            .bold()
                            
                            TextField("", text: $RealName)
                            .multilineTextAlignment(.center)
                            .frame(width: 300, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        }
                        .padding(.bottom, 10)
                        
                        Group {
                            Text("密碼")
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 18))
                            .bold()
                            
                            SecureField("", text: $Password)
                            .multilineTextAlignment(.center)
                            .frame(width: 300, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        }
                        .padding(.bottom, 10)
                        
                        Group {
                            Text("再次輸入密碼")
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 18))
                            .bold()
                            
                            SecureField("", text: $VerityPassword)
                            .multilineTextAlignment(.center)
                            .frame(width: 300, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        }
                        .padding(.bottom, 10)
                        
                        Button(action: {
                            self.ShowAlert = true
                        }) {
                           Text("註冊")
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
                        .padding(.top, 50)
                        .alert(isPresented: $ShowAlert) { () -> Alert in
                            let result: String
                            
                            if self.RealName != "" && self.UserName != "" && self.Skl_Email != "" {
                                if self.Password == self.VerityPassword {
                                    postSignUpJSON(UserName: self.RealName, UserId: self.UserName, Password: self.Password, Email: self.Skl_Email)
                                    SendConfirmJSON(UserId: self.UserName, SendConfirmType: "1")
                                    result = "註冊成功！可以下滑視窗囉！"
                                    //self.presentationMode.wrappedValue.dismiss()
                                }else{
                                    result = "兩次密碼必須一致歐！"
                                }
                            }else{
                                result = "請填入帳號及本名歐！"
                            }
                            
                            return Alert(title: Text(result))
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct SignUp_Info_View_Previews: PreviewProvider {
    static var previews: some View {
        SignUp_Info_View(Skl_Email: "")
    }
}
