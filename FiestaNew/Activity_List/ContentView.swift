//
//  ContentView.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/5/25.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var ShowMenuView = false
    @ObservedObject var ActivityList = Activity()
    
    var body: some View {
        
        NavigationView {
            List(self.ActivityList.ActivityInfoList) { Act_Item in
                ZStack {
                    VStack {
                        HStack {
                            Spacer()
                            VStack(alignment: .center) {
                                Spacer(minLength: 10)

                                Text(Act_Item.Act_Name)
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)

                                HStack {
                                    ScrollView(.horizontal) {
                                        Text(Act_Item.Tag)
                                            .font(Font.system(size: 18))
                                            .foregroundColor(Color.gray)
                                            .multilineTextAlignment(.leading)
                                            .padding(.leading, 10)
                                    }
                                    .frame(width: 140, height: 45)

                                    Spacer()

                                    Text("- \(Act_Item.StartTime)  \n- \(Act_Item.EndTime)")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.trailing)
                                        .padding(.trailing, 10)
                                }
                                .frame(height: 45)

                                HStack {
                                    Spacer()
                                    Text(Act_Item.Act_Status)
                                    .font(.headline)
                                    .foregroundColor(Color.red)
                                    .multilineTextAlignment(.trailing)
                                    .padding(.trailing, 10)
                                }
                                .frame(height: 20)

                                Image("Logo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 250, height: 200)

                                Spacer()
                            }
                            .frame(width: 325, height: 355)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )

                            Spacer()
                        }
                    }
                    .padding(.bottom, 20)

                    NavigationLink(destination: Activity_Info_View(Act_Item: Act_Item)) {
                        EmptyView()
                    }.buttonStyle(PlainButtonStyle())
                }
            }

            .navigationBarItems(leading:
                HStack {
                    Button(action: {
                        withAnimation {
                            self.ShowMenuView = true
                        }
                    }){
                        Image(systemName: "list.dash")
                            .font(Font.system(size: 25).bold())
                            .foregroundColor(Color.orange)
                    }
                    
                    Image("Title")
                    .resizable()
                        .aspectRatio(contentMode: .fit)
                    .scaledToFill()
                    .frame(width: 75, height: 50, alignment: .center)
                    .padding(UIScreen.main.bounds.size.width/4+5)
                }
            )
            .onAppear {
                UITableView.appearance().separatorStyle = .none
                ActivityList.Get_Activity_Info()    
            }
            .sheet(isPresented: $ShowMenuView) {
                Menu_View()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

