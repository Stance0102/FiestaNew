//
//  PartialView_Tag.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/17.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI

struct PartialView_Tag: View {
    @State var index: Int
    @State var item: Int
    var Tag_Func: () = GetTag()
    
    var body: some View {
        Button(action: {
            print("1234")
        }){
            VStack {
                Image("Icon")
                .resizable()
                .scaledToFill()
                .frame(width: 75, height: 75)
                .clipShape(Circle())
                
                Text(Tag_List[index*4+item])
                .foregroundColor(Color.black)
                .padding(.top, 10)
            }
            .padding([.leading,.trailing], 6)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct PartialView_Tag_Previews: PreviewProvider {
    static var previews: some View {
        PartialView_Tag(index: 1, item: 1)
    }
}
