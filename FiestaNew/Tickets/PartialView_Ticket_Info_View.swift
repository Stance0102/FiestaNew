//
//  PartialView_Ticket_Info_View.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/11/2.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI

struct PartialView_Ticket_Info_View: View {
    @ObservedObject var TicketKind = Ticket()
    
    var body: some View {
        HStack {
            ForEach(TicketKind.TicketArray, id: \.Id) { (ticket) in
                HStack {
                    
                }
                .frame(width: 300, height: 200, alignment: .leading)
            }
        }
        .frame(width: 200, height: 60)
        .background(Color(red: 0.85, green: 0.8, blue: 0.95))
        .cornerRadius(30.0)
    }
}

struct PartialView_Ticket_Info_View_Previews: PreviewProvider {
    static var previews: some View {
        PartialView_Ticket_Info_View()
    }
}
