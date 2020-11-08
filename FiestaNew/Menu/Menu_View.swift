//
//  Menu_View.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/2.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI

struct Menu_View: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            HStack {
                Spacer()
                VStack {
                    List {
                        ZStack {
                            VStack {
                                HStack {
                                    Spacer(minLength: 50)
                                    Image("Header")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    if UserDefaults.standard.value(forKey: "UserName") != nil {
                                        Text(UserDefaults.standard.value(forKey: "UserName") as! String)
                                        .foregroundColor(Color.black)
                                        .font(Font.system(size: 24))
                                        .bold()
                                    }else{
                                        Text("點擊以登入")
                                        .foregroundColor(Color.black)
                                        .font(Font.system(size: 24))
                                        .bold()
                                        
                                    }
                                    Spacer()
                                }
                                HStack {
                                    if UserDefaults.standard.value(forKey: "Email") != nil {
                                        Text(UserDefaults.standard.value(forKey: "Email") as! String)
                                        .foregroundColor(Color.gray)
                                        .font(Font.system(size: 22))
                                    }else{
                                        Text("Email")
                                        .foregroundColor(Color.gray)
                                        .font(Font.system(size: 22))
                                    }
                                }
                                .padding(.bottom, 15)
                            }
                            
                            NavigationLink(destination: LogIn_View()) {
                                EmptyView()
                            }
                        }
                        
                        NavigationLink(destination: Selected_Act_Group_View()) {
                            VStack {
                                HStack {
                                    
                                    Image("Add")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 5)
                                    
                                    Text("建立活動")
                                    .font(Font.system(size: 20))
                                    
                                    Spacer()
                                    Spacer()
                                }
                                .frame(width: (UIScreen.main.bounds.size.width/10)*5)
                            }
                        }
                        
                        
                        NavigationLink(destination: ContentView()) {
                            VStack {
                                HStack {
                                    
                                    Image(systemName: "doc.text.magnifyingglass")
                                    .font(Font.system(size: 20).bold())
                                    .foregroundColor(Color.gray)
                                        .padding(.trailing, 5)
                                    
                                    
                                    Text("管理活動")
                                    .font(Font.system(size: 20))
                                    
                                    Spacer()
                                    Spacer()
                                }
                                .frame(width: (UIScreen.main.bounds.size.width/10)*5)
                            }
                        }
                        
                        NavigationLink(destination: ContentView()) {
                            VStack {
                                HStack {
                                    
                                    Image("Follow")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 5)
                                    
                                    Text("收藏活動")
                                    .font(Font.system(size: 20))
                                    
                                    Spacer()
                                    Spacer()
                                }
                                .frame(width: (UIScreen.main.bounds.size.width/10)*5)
                            }
                        }
                        
                        NavigationLink(destination: MyTickets()) {
                            VStack {
                                HStack {
                                    
                                    Image("Ticket")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 5)
                                    
                                    Text("票匣")
                                    .font(Font.system(size: 20))
                                    
                                    Spacer()
                                    Spacer()
                                }
                                .frame(width: (UIScreen.main.bounds.size.width/10)*5)
                            }
                        }
                        
                        NavigationLink(destination: ContentView()) {
                            VStack {
                                HStack {
                                    
                                    Image("Setting")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 5)
                                    
                                    Text("設定")
                                    .font(Font.system(size: 20))
                                    
                                    Spacer()
                                    Spacer()
                                }
                                .frame(width: (UIScreen.main.bounds.size.width/10)*5)
                            }
                        }
                    }
                    .navigationBarTitle("Menu",displayMode: .inline)
                    .navigationBarHidden(true)
                    .edgesIgnoringSafeArea([.top, .bottom])
                }
                Spacer()
            }
        }
    }
}

struct Menu_View_Previews: PreviewProvider {
    static var previews: some View {
        Menu_View()
    }
}
