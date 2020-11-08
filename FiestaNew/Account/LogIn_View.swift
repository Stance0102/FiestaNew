//
//  LogIn_View.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/17.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI

struct LogIn_View: View {
    @State var UserName = ""
    @State var Password = ""
    @State private var ShowAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            HStack {
                Spacer()
                VStack {
                    Image("Logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 100)
                    .padding([.bottom], 60)
                    .padding(.top, 20)
                    
                    Group {
                        TextField("帳號", text: $UserName)
                        .multilineTextAlignment(.center)
                        .frame(width: 300, height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                    .padding(.bottom, 20)
                    
                    Group {
                        SecureField("密碼", text: $Password)
                        .multilineTextAlignment(.center)
                        .frame(width: 300, height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                    .padding(.bottom, 20)
                    
                    Button(action: {
                        self.ShowAlert = true
                    }) {
                       Text("登入")
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
                    .padding(.top, 20)
                    .alert(isPresented: $ShowAlert) { () -> Alert in
                        let result: String
                        
                        if self.UserName != "" && self.Password != ""
                        {
                            PostLoginJSON(UserId: self.UserName, Password: self.Password)
                            result = "登入成功！"
                            self.presentationMode.wrappedValue.dismiss()
                        }else{
                            result = "請填入帳號及密碼歐！"
                        }
                        
                        return Alert(title: Text(result))
                    }
                    
                    NavigationLink(destination: School_Email_View())
                    {
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
                    .padding(.top, 30)
                    
                    Spacer()
                }
                Spacer()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct LogIn_View_Previews: PreviewProvider {
    static var previews: some View {
        LogIn_View()
    }
}
