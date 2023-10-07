//
//  MyPageView.swift
//  GoogleLogin
//
//  Created by dgsw8th61 on 2023/10/03.
//

import SwiftUI
import GoogleSignIn

struct MyPageView: View {
    
    @State var date = Date()
    
    let months = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "9월", "10월", "11월", "12월"]
        @State private var selectedMonth = ""
    // 화면 종료
    @Environment(\.dismiss) private var dismiss
    // 유저 데이터 바인딩
    @Binding var userData:UserData
    
    var body: some View {
        
        
        NavigationStack{
            
            
            VStack{
                
                
                // 프로필
                HStack(alignment: .top){
                    AsyncImage(url: userData.url)
                    
                        .aspectRatio(contentMode: .fit)
                        .imageScale(.small)
                        .frame(width: 100, height: 100, alignment: .center)
                        .cornerRadius(50)
                        .overlay {
                            Circle().stroke(.white, lineWidth: 2)
                        }.shadow(radius: 5)
                        .padding(EdgeInsets(top: 60, leading: 0, bottom: 0, trailing: 0))
                        .overlay(
                            ZStack {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 30, height: 30)
                                
                                Button(action: {
                                    // 버튼 동작 구현
                                }, label: {
                                    NavigationLink(destination: UserPage()) {
                                        Image(systemName: "pencil")
                                            .foregroundColor(.white)
                                            .font(.system(size: 15))
                                    }
                                })
                                
                            }
                                .offset(x: 35, y: 65) // 위치 조정
                        )
                    
                    
                    
                    // 이름
                    Text(userData.name)
                        .font(.system(size: 23 ))
                        .bold()
                        .padding(EdgeInsets(top: 95, leading: 20, bottom: 0, trailing: 0))
                    
                    // 이메일
                    //                Text(userData.email)
                    
                    
                }
                .padding(.trailing, 170)
                
                
                Spacer()
                
                
                VStack{//작성글 시작
                    HStack{
                        Text("작성글")
                            .font(.system(size: 20))
                            .padding(.trailing , 210 )
                        
                        DatePicker(
                            "Start Date",
                            selection: $date,
                            displayedComponents: [.date]
                        )
                        //                            .padding(9)
                        //                            .background(Color.blue.opacity(0.3))
                        .cornerRadius(15)
                        .frame(width: 5, height: 5)
                        .padding(.trailing, 40)
                        
                        
                        
                        
                    }
                    .padding()
                    
                    
                    NavigationView {
                        List(months, id: \.self) { month in
                            NavigationLink(
                                destination: MonthPage(selectedMonth: month),
                                
                                label: {
                                    Text(month)
                                }
                            )
                            
                        }
                      
                    }
                        }
                    }
                    
                    
                }
            }
            
        }
        
        
        



struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView(userData: .constant(UserData(url: nil, name: "이름", email: "이메일")))
    }
}
