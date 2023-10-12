//
//  YearCalendar.swift
//
//
//  Created by dgsw8th61 on 2023/10/11.
//

import SwiftUI


func createSquareGrid(rows: Int, columns: Int, totalSquares: Int) -> some View {
    VStack(spacing: 10) {
        ForEach(0..<rows, id: \.self) { row in
            HStack(spacing: 10) {
                ForEach(0..<columns, id:\.self){ column in
                    if (row * columns + column < totalSquares){
                        Rectangle()
                            .foregroundColor(Colors.Gray1.color)
                            .frame(width :15 , height :15 )
                            .cornerRadius(3)
                    } else{
                        Rectangle().hidden()
                    }
                }
            }
        }
    }
}



 



struct YearCalendar: View {
    let totalRows = 7
    let squaresPerRow = 3
    let totalSquares = 21
    
    let months = ["1월", "2월", "3월", "4월", "5월", "6월", "7월","8월", "9월", "10월", "11월", "12월"]
    let days = ["일", "월", "화", "수", "목", "금","토"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) { // 수평 방향으로 스크롤
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    ForEach(months, id:\.self){ month in
                        
                        VStack{
                            Text(month)
                                .font(.system(size :10))
                                .padding(.trailing ,60 )
                                .foregroundColor(.black)
                            
                            createSquareGrid(rows :totalRows , columns:squaresPerRow , totalSquares :totalSquares )
                        }
                        
                    }
                    
                }
                
            }
        }
        
    }
    
}




struct YearCalendar_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView(userData: .constant(UserData(url: nil, name: "이름", email: "이메일")))
    }
}
