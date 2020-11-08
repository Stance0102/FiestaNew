//
//  School_Email_View.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/16.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import Combine

struct School_Email_View: View {
    @State var Email = ""
    @State var SelectedIndex = 0
    @State private var ShowAlert = false
    
    var body: some View {
        NavigationView {
            HStack {
                Spacer()
                VStack {
                    Text("以學校信箱註冊")
                    .foregroundColor(Color.black)
                    .bold()
                    .font(Font.system(size: 25))
                    
                    Divider()
                        .padding([.top,.bottom],20)
                    
                    Picker(selection: $SelectedIndex,
                            label: Text("學校")
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 18))
                            .bold()
                    ){
                        ForEach(0..<School_C_Email.count){ (index) in
                            Text(School_C_Email[index])
                        }
                    }
                    
                    Group {
                        HStack {
                            Text("Email")
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 18))
                            .bold()
                            
                            TextField("\(Email)@\(School_E_Email[SelectedIndex]).edu.tw", text: $Email)
                            .multilineTextAlignment(.center)
                            .frame(width: 250, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        }
                    }
                    
                    NavigationLink(destination: SignUp_Info_View(Skl_Email: self.Email)) {
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
                    .padding(.top, 50)
                    
                    Spacer()
                }
                Spacer()
            }
        }
        .onAppear{
            GetEmail()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct School_Email_View_Previews: PreviewProvider {
    static var previews: some View {
        School_Email_View()
    }
}
