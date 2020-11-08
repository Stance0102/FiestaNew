//
//  MyTickets.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/10/27.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import Combine

struct MyTickets: View {
    @ObservedObject var TicketKind = Ticket()
    
    var body: some View {
        Text("1234")
        NavigationView {
            List(self.TicketKind.MyTicket_Array, id: \.Act_Id) { ticket in
                ZStack {
                    VStack(alignment: .leading) {
                        Text("2020-10")
                        .font(Font.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 10)

                        HStack(alignment: .center) {
                            Image("Logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)

                            VStack(alignment: .leading) {
                                Text(ticket.Act_Name)
                                .font(Font.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)

                                Text(ticket.TicketKinds)
                                .font(Font.system(size: 16))
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.leading)

                                Text("地點")
                                .font(Font.system(size: 18))
                                .foregroundColor(Color.orange)
                                .multilineTextAlignment(.leading)
                                .padding(.top, 1)

                                Text(ticket.startTime)
                                .font(Font.system(size: 18))
                                .foregroundColor(Color.orange)
                                .multilineTextAlignment(.leading)
                                .padding(.top, 1)
                            }
                            .frame(width: 150, height: 80, alignment: .leading)
                            .padding(.leading, 5)

                            VStack {
                                Text("已付款")
                                .font(Font.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(Color.green)
                                .multilineTextAlignment(.center)
                            }
                            .frame(width: 80, height: 80, alignment: .center)
                            .padding(.leading, 5)
                        }
                    }
                }
            }
            .onAppear{
                TicketKind.Post_MyTicker_Info()
            }
        }
    }
}
struct MyTickets_Previews: PreviewProvider {
    static var previews: some View {
        MyTickets()
    }
}
