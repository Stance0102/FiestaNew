//
//  PartialView_SingleTag.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/19.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI

struct PartialView_SingleTag: View {
    @State var Index:Int
    
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
                
                Text("Tag")
                .foregroundColor(Color.black)
                .padding(.top, 10)
            }
            .padding([.leading,.trailing], 6)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct PartialView_SingleTag_Previews: PreviewProvider {
    static var previews: some View {
        PartialView_SingleTag(Index: 1)
    }
}
