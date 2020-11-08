//
//  Selected_Tag_View.swift
//  
//
//  Created by 李慶毅 on 2020/6/8.
//

import SwiftUI

struct Selected_Tag_View: View {
    var body: some View {
        NavigationView {
            HStack {
                Spacer()
                VStack {
                    Text("選擇活動類別Tag")
                        .bold()
                        .font(Font.system(size: 25))
                    
                    PartialView_Selected_Tag()
                    
                    Divider()
                    .padding([.top,.bottom],5)
                    
                    PartialView_Scroller_Tag()
                    
                    NavigationLink(destination: Selected_Act_Group_View()) {
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
                .padding(.top, 20)
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationBarTitle("")
            .edgesIgnoringSafeArea([.top, .bottom])
        }
    }
}

struct Selected_Tag_View_Previews: PreviewProvider {
    static var previews: some View {
        Selected_Tag_View()
    }
}
