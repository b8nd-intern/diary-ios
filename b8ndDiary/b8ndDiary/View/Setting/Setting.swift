//
//  Setting.swift
//  GoogleLogin
//
//  Created by dgsw8th61 on 2023/10/05.
//

import SwiftUI

struct Setting: View {
    @State var lighton : Bool = false
    @State var LogOut : Bool = false
    
    let urlString = "https://www.notion.so/b03fb959d2b34a0981b37db66c1e9a4e?pvs=4"

    var body: some View {
        VStack{
            
            Toggle(isOn: $lighton) {
                if lighton{
                    Label("알람설정", systemImage: "bell.fill")
                        
                }
            
                else{
                    Label("알람설정", systemImage: "bell")
                }
            }
            .toggleStyle(SwitchToggleStyle(tint: .blue)) //토글 색 지정
    //        .toggleStyle(.switch)
    //        .tint(.pink)
            //위와 같은 또 다른 방법
            .padding(.horizontal,30)
            .padding(.vertical, 20)
            
            Button {
                
            } label: {
                Label("로그아웃", systemImage: "rectangle.portrait.and.arrow.right")
                    .foregroundColor(.black)
                    .padding(.trailing, 240)
                    .padding(.bottom,20)
            }

            


            Divider()
            
            Button {
                        if let url = URL(string: urlString) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text("about B8nd")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                            .opacity(0.5)
                            .padding(15)
                            .padding(.leading, 260)
                    }

            
       
            
            Spacer()
            

        }
        
        
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting()
    }
}
