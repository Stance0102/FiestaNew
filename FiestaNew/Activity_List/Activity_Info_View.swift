//
//  Activity_Info_View.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/5/31.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI
import Combine

struct Activity_Info_View: View {
    var Act_Item: Activity_Info
    @ObservedObject var TicketKind = Ticket()
    @State private var HeartFill = false
    
    var body: some View {
        ScrollView(.vertical) {
            ZStack {
                VStack {
                    Image("Logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
                    
                    Divider()
                    .frame(height: 1)
                    .background(Color.black)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(Act_Item.Act_Name)
                                .bold()
                                .font(Font.system(size: 30))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                
                                Spacer()
                                
                                Button(action: {
                                    self.HeartFill.toggle()
                                }){
                                    Image(systemName: self.HeartFill ?  "heart.fill":"heart")
                                    .font(Font.system(size: 40))
                                    .multilineTextAlignment(.center)
                                }
                            }
                            .padding(.bottom, 5)
                            
                            HStack {
                                ForEach(0..<Act_Item.Tags.count){ tag in
                                    Text("#\(self.Act_Item.Tags[tag])")
                                    .font(Font.system(size: 20))
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 75,height: 30)
                                    .background(Color.gray)
                                    .cornerRadius(20)
                                }
                                
                                Spacer()
                                
                                Text(Act_Item.Act_Status)
                                .font(Font.system(size: 20))
                                .bold()
                                .foregroundColor(Color.red)
                                .multilineTextAlignment(.trailing)
                            }
                            .padding(.bottom, 15)
                            
                            Text("- \(Act_Item.StartTime)\n- \(Act_Item.EndTime)")
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .frame(width: 200, height: 50)
                            
                            Text("活動簡介")
                            .bold()
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 20))
                            .padding(.top, 20)
                            
                            Text(Act_Item.Act_Description)
                            .foregroundColor(Color.black)
                            .frame(width: UIScreen.main.bounds.width-100, height: 300, alignment: .topLeading)
                            .padding(.top, 15)
                            
                            VStack {
                                HStack {
                                    ForEach(self.TicketKind.Ticket_Array, id: \.TicketKinds){ ticket in
                                        Text(ticket.TicketKinds)
                                        .font(Font.system(size: 18))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        
                                        Text("NT. \(ticket.Price)")
                                        .font(Font.system(size: 16))
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.leading)
                                        
                                        Text("總共:\(ticket.Mounts)張")
                                        .font(Font.system(size: 18))
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.leading)
                                        .padding(.top, 1)
                                        
                                        Button(action: {
                                            TicketKind.Post_BuyTicket(Act_Id: ticket.Act_Id, TicketKinds: ticket.TicketKinds)
                                        }){
                                            Text("買票")
                                            .foregroundColor(Color.white)
                                            .bold()
                                            .offset(x: 0, y: -12.5)
                                            .background(
                                                Image("ShortBtn")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 55, height: 55)
                                            )
                                            .frame(width: 80, height: 55)
                                            .padding(.top, 20)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .padding(.trailing, 60)
                                    }
                                }
                            }
                            .padding(.bottom, 100)
                        }
                        .frame(width: UIScreen.main.bounds.width-35)
                    }
                    .frame(width: UIScreen.main.bounds.width-15)
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)
                .padding(.top, 10)
                
                Divider()
                .frame(height: 1)
                .background(Color.black)
            }
        }
        .onAppear {
            TicketKind.Post_Ticker_By_Act(ActId: Act_Item.Act_ID)
        }
    }
}

struct Activity_Info_View_Previews: PreviewProvider {
    static var previews: some View {
        Activity_Info_View(Act_Item: Activity().ActivityInfoList[0])
    }
}

