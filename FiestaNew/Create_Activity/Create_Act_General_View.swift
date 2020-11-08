//
//  Create_Act_General_View.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/9.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI
import Alamofire
import Combine
import SwiftyJSON

struct Create_Act_General_View: View {
    var GroupId: String
    //var Search_Group: () = PostSearchGroup(GroupID: GroupId)
    //@State var Act_Group_Name: String
    @State private var Act_Name: String = ""
    @State private var Act_Descripts: String = ""
    @State private var Act_Maximum: String = ""
    @State private var StartDate = Date()
    @State private var EndDate = Date()
    @State private var Act_Image: Image?
    @State private var links = [URL]()
    @State private var cancellable: AnyCancellable?
    @State private var ShowImgPicker: Bool = false
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        return dateFormatter
    }()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                HStack {
                    Spacer()
                    
                    VStack {
                        Text("創建活動")
                        .foregroundColor(Color.black)
                        .font(Font.system(size: 25))
                        .bold()
                        
                        Divider()
                        .frame(height: 1)
                        .background(Color.black)
                        
                        
                        HStack {
                            VStack {
                                Group {
                                    HStack {
                                        Spacer()
                                        
                                        Button(action: {
                                            self.ShowImgPicker.toggle()
                                        }) {
                                            Text("選擇圖片")
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
                                        
                                        Button(action: {
                                            
                                        }) {
                                            Text("上傳圖片")
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
                                        
                                        Spacer()
                                    }
                                }
                                .padding(.bottom, 50)
                                
                                if (ShowImgPicker) {
                                    ImagePicker(isShown: $ShowImgPicker, image: $Act_Image)
                                }
                                /*
                                (Act_Image ?? Image(systemName: "photo"))
                                .resizable()
                                .scaledToFit()
                                .onAppear {
                                    let uiImage = UIImage(named: "peter")!
                                    NetworkManager.shared.Upload_Image(uiImage: uiImage, Upload_Class: "act", Id: Group_Id!)
                                        { (resultImage) in
                                            if let resultImage = resultImage {
                                                self.Act_Image = Image(uiImage: resultImage)
                                            }
                                        }
                                    }
                                */
                                Group {
                                    Text("活動名稱")
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 18))
                                    .bold()
                                    
                                    TextField("", text: $Act_Name)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 300, height: 40)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                }
                                .padding(.bottom, 10)
                                /*
                                Group {
                                    Text("活動主辦方")
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 18))
                                    .bold()
                                    
                                    Text("\(GroupName)")
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 18))
                                    .bold()
                                    .multilineTextAlignment(.center)
                                }
                                .padding(.bottom, 10)
                                */
                                Group {
                                    Text("活動簡介")
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 18))
                                    .bold()
                                    
                                    TextField("", text: $Act_Descripts)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 300, height: 180)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                }
                                .padding(.bottom, 10)
                                
                                Group {
                                    Text("活動最大人數")
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 18))
                                    .bold()
                                    
                                    TextField("", text: $Act_Maximum)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 300, height: 40)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                }
                                .padding(.bottom, 10)
                                
                                Group {
                                    Text("開始時間")
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 18))
                                    .bold()
                                    
                                    DatePicker("", selection: $StartDate,in: Date()...DateComponents(calendar: Calendar.current, year: 9999,month: 12, day: 31).date!)
                                    .padding()
                                    .labelsHidden()
                                }
                                .padding(.bottom, 10)
                                
                                Group {
                                    Text("結束時間")
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 18))
                                    .bold()
                                    
                                    DatePicker("", selection: $EndDate,in: Date()...DateComponents(calendar: Calendar.current, year: 9999,month: 12, day: 31).date!)
                                    .padding()
                                    .labelsHidden()
                                }
                                .padding(.bottom, 10)
                                
                                Button(action: {
                                    PostCreateAct(GroupId: GroupId, Act_Name: self.Act_Name, StartTime: self.StartDate, EndTime: self.EndDate, Act_Des: self.Act_Descripts, PeopleMaxium: self.Act_Maximum)
                                }){
                                    Text("下一步")
                                    .bold()
                                    .foregroundColor(Color.white)
                                        .offset(x: 0, y: -12.5)
                                    .background(
                                        Image("ShortBtn")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 55, height: 55)
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.top, 5)
                            }
                        }
                    }
                    .padding(.top ,-80)
                    Spacer()
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct Create_Act_General_View_Previews: PreviewProvider {
    static var previews: some View {
        Create_Act_General_View(GroupId: "")
    }
}

struct NetworkManager {
    static let shared = NetworkManager()
    
    func Upload_Image(uiImage: UIImage, Upload_Class: String, Id: Int, completion: @escaping(UIImage?) -> Void){
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Content-Disposition" : "form-data",
            "Authorization":"Bearer  eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1OTIyMjgxMzksIm5iZiI6MTU5MjIyODEzOSwianRpIjoiYzVlNmMwMmMtOTc1ZS00NjUxLTk5ODItNjRlNGE5NDFlM2E2IiwiZXhwIjoxNTkyNDg3MzM5LCJpZGVudGl0eSI6MTQsImZyZXNoIjpmYWxzZSwidHlwZSI6ImFjY2VzcyJ9.6B0gHoPg8QgEMdSz81BweCt5tdxG0d45CMVQw4Ozkdk"
        ]
        
        AF.upload(multipartFormData: { (data) in
            let imageData = uiImage.jpegData(compressionQuality: 1)
            data.append(imageData!, withName: "Image", fileName:  UUID().uuidString, mimeType: "image/jpeg")
        }, to: "http://163.18.42.222:8888/Fiestadb/uploadImage?type=\(Upload_Class)&Id=\(Id)", headers: headers).responseData { (response) in
                if let data = response.data {
                    print(data)
                }else{
                    completion(nil)
                }
            }
            
    }
}
