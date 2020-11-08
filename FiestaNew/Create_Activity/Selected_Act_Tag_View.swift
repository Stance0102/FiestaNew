//
//  Selected_Act_Tag_View.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/8.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI

struct Selected_Act_Tag_View: View {
    //@ObservedObject var tag_Manager = TagManager()
    @State var Selected_Group: String
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ZStack {
                    //Color(red: 232/255, green: 172/255, blue: 76/255)
                    //.edgesIgnoringSafeArea(.all)
                    HStack {
                        Spacer()
                        VStack {
                            Text("選擇活動類別Tag")
                            .bold()
                            .font(Font.system(size: 25))
                            .foregroundColor(Color.black)
                            
                            Text("選擇完活動Tag，請點選下一步！")
                            .font(Font.system(size: 15))
                            .foregroundColor(Color.gray)
                            .padding(.top, 10)
                            
                            Divider()
                            .padding([.top,.bottom],5)
                            
                            PartialView_Scroller_Tag()
                            
                            NavigationLink(destination:
                                Create_Act_General_View(GroupId: Selected_Group)) {
                                Text("下一步")
                                .foregroundColor(Color.white)
                                .bold()
                                .offset(x: 0, y: -12.5)
                                .background(
                                    Image("ShortBtn")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 55, height: 55)
                                )
                                .frame(width: 55, height: 55)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.top, 20)
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

struct Selected_Act_Tag_View_Previews: PreviewProvider {
    static var previews: some View {
        Selected_Act_Tag_View(Selected_Group: "")
        
    }
}
