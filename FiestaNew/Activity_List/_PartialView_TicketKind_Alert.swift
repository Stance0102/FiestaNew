//
//  _PartialView_TicketKind_Alert.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/10/29.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI

struct _PartialView_TicketKind_Alert: View {
    var Ticket_Cls = Ticket()
    
    var body: some View {
        HStack {
            ForEach(Ticket_Array, id: \.Id) { (ticket) in
                HStack {
                    Text(ticket.TicketKinds)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                    Text(ticket.Price)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                    Text(ticket.Remainder)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                    Text(ticket.Mounts)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                }
                .frame(width: 150, height: 80, alignment: .leading)
            }
        }
        .frame(width: 200, height: 60)
        .background(Color(red: 0.85, green: 0.8, blue: 0.95))
        .cornerRadius(30.0)
    }
}

struct _PartialView_TicketKind_Alert_Previews: PreviewProvider {
    static var previews: some View {
        _PartialView_TicketKind_Alert()
    }
}
