//
//  PartialView_Scroller_Tag.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/3.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI
import Combine


struct PartialView_Scroller_Tag: View {
    @ObservedObject var Tag_Manager = TagManager()
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(0..<Tag_Manager.row) {index in
                HStack {
                    ForEach(0..<4) { item in
                        Button(action: {
                            Tag_Manager.updateData(index, item)
                        }){
                            VStack {
                                Image("Logo")
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 75)
                                        .stroke(Tag_Manager.getData(index, item) ? Color.green : Color.white, lineWidth: 2)
                                )
                                .frame(width: 75, height: 75)
                                
                                
                                Text("\(Tag_Manager.Tag_List[index*4+item+Tag_Manager.others])")
                                .foregroundColor(Color.black)
                                .padding(.top, 10)
                            }
                            .padding([.leading,.trailing], 6)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .frame(width: UIScreen.main.bounds.size.width-20, height: 150)
                .padding([.leading,.trailing],10)
            }
        }
        .frame(width: UIScreen.main.bounds.size.width, height: 450)
    }
}

struct PartialView_Scroller_Tag_Previews: PreviewProvider {
    static var previews: some View {
        PartialView_Scroller_Tag()
    }
}
