//
//  PartialView_Selected_Tag.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/3.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI
import Combine

struct PartialView_Selected_Tag: View {
    @ObservedObject var tag_Manager = TagManager()
    
    var body: some View {
        ScrollView(.horizontal) {
            VStack {
                HStack {
                    Button(action: {
                        
                        print(self.tag_Manager.Selected_Tag)
                        print(self.tag_Manager.Selected_Tag.count)
                        print("Delete")
                    }){
                        VStack {
                            Text("")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(width: 75, height: 75)
                            .background(
                                Image("Icon")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75),
                                alignment: .center
                            )
                            .clipShape(Circle())
                            
                            Text("Test")
                            .foregroundColor(Color.black)
                            .padding(.top, 10)
                        }
                        .padding([.leading,.trailing], 6)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(width: UIScreen.main.bounds.size.width-20, height: 120)
                .padding([.leading,.trailing],10)
            }
        }
        .frame(width: UIScreen.main.bounds.size.width, height: 120)
    }
}

struct PartialView_Selected_Tag_Previews: PreviewProvider {
    static var previews: some View {
        PartialView_Selected_Tag()
    }
}
