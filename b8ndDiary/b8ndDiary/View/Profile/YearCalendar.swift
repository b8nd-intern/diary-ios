//
//  YearCalendar.swift
//
//
//  Created by dgsw8th61 on 2023/10/11.
//

import SwiftUI

func createSquareGrid(rows: Int, columns: Int, totalSquares: Int, YearviewModeldate: [Bool]) -> some View {
    return VStack(spacing: 10) {
        var a = 0
        ForEach(0..<rows, id: \.self) { row in
            HStack(spacing: 10) {
                ForEach(0..<columns, id: \.self) { column in
                    let b = row * rows + (column) % columns
                    if b < YearviewModeldate.count{ // 0 ~ 200
                        // 나누기 7 -> 열
                        // 나머지 7 -> 행
                        // +) 날짜 -> 
                        Rectangle()
                            .foregroundColor(YearviewModeldate[b] ? Colors.Blue1.color : Colors.Gray1.color)
                            .frame(width: 15, height: 15)
                            .cornerRadius(3)
                            .onAppear{
                                a+=1
                                print(a)
                                print("yeardata 이동 확인1 :",YearviewModeldate)
                                
                            }
                    } else {
                        Rectangle()
                            .foregroundColor(Colors.Gray1.color)
                            .frame(width: 15, height: 15)
                            .cornerRadius(3)
                            .onAppear{
//                                print("else :")
                                print(a)
                                print("yeardata 이동 확인 :",YearviewModeldate)
                                
                            }
                    }
                }
            }
        }
    }
}

struct YearCalendar: View {
    let totalRows = 7
    let squaresPerRow = 5
    let totalSquares = 35
    
    @StateObject var YearviewModel = YearCalendarViewModel()
    
    let months = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(months, id: \.self) { month in
                    VStack {
                        Text(month)
                            .padding(.trailing,95)
                            .font(.system(size: 10))
                            .foregroundColor(.black)
                        
                        createSquareGrid(rows: totalRows, columns: squaresPerRow, totalSquares: totalSquares, YearviewModeldate: YearviewModel.Yeardate)
                    }
                }
            }
        }
        .onAppear{
            YearviewModel.RecordYear (callback: {
                
            })
            print("실행 : ",YearviewModel.Yeardate)
        }
        
    }
}



