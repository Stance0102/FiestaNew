//
//  Setting_Map_Location_View.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/10.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI
import CoreLocation
import MapKit

struct Setting_Map_Location_View: View {
    let geoCoder = CLGeocoder()
    
    var body: some View {
        NavigationView {
            VStack {
                GoogleMap_View()
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 120)
                Text("--- 附近地點 ---")
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 20))
                
                PlacesList()
                
                NavigationLink(destination: ContentView()) {
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
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct Setting_Map_Location_View_Previews: PreviewProvider {
    static var previews: some View {
        Setting_Map_Location_View()
    }
}
