//
//  PartialView_Scroller_Tag.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/3.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI

struct PartialView_Scroller_Tag: View {
    //var Get_Tag_Func: () = GetTag()
    var body: some View {
        ScrollView(.vertical) {
            ForEach(0..<(Tag_List.count)/4) {index in
                HStack {
                    ForEach(0..<4) {item in
                        Button(action: {
                            print("1234")
                        }){
                            VStack {
                                Image("Icon")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                
                                Text("Tag")
                                .foregroundColor(Color.black)
                                .padding(.top, 10)
                            }
                            .padding([.leading,.trailing], 6)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .frame(width: UIScreen.main.bounds.size.width-20, height: 120)
                .padding([.leading,.trailing],10)
            }
        }
        .frame(width: UIScreen.main.bounds.size.width, height: 300)
    }
}

struct PartialView_Scroller_Tag_Previews: PreviewProvider {
    static var previews: some View {
        PartialView_Scroller_Tag()
    }
}
