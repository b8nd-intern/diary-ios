//
//  YearCalendar.swift
//
//
//  Created by dgsw8th61 on 2023/10/11.
//

import SwiftUI

func createSquareGrid(rows: Int, columns: Int, totalSquares: Int, YearviewModel: YearCalendarViewModel) -> some View {
    return VStack(spacing: 10) {
        var a = 0
        ForEach(0..<rows, id: \.self) { row in
            HStack(spacing: 10) {
                ForEach(0..<columns, id: \.self) { column in
                    if a < YearviewModel.Yeardate.count{
                        Rectangle()
                            .foregroundColor(YearviewModel.Yeardate[a] ? Colors.Blue1.color : Colors.Gray1.color)
                            .frame(width: 15, height: 15)
                            .cornerRadius(3)
                            .onAppear{
                                a+=1
                                print("a < viewModel.Yeardate.count :")
                                print("yeardata 이동 확인 :",YearviewModel.Yeardate)
                                
                                
                            }
                    } else {
                        Rectangle()
                            .foregroundColor(Colors.Gray1.color)
                            .frame(width: 15, height: 15)
                            .cornerRadius(3)
                            .onAppear{
                                print("else :")
                                print("yeardata 이동 확인 :",YearviewModel.Yeardate)
                                
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
    
    @ObservedObject var YearviewModel = YearCalendarViewModel()
    
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
                        
                        createSquareGrid(rows: totalRows, columns: squaresPerRow, totalSquares: totalSquares, YearviewModel: YearviewModel)
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
//class YearviewModel {
//  RecordYear(yeardate: Date, callback: () => void) {
//    // YearviewModel 내부에서 yeardate 사용하는 코드
//    // ...
//
//    // 비동기 작업이 끝난 후에 callback 호출
//    callback();
//  }
//}
//
//// YearviewModel.RecordYear 호출 예제
//const yearViewModelInstance = new YearviewModel();
//const currentDate = new Date();
//
//yearViewModelInstance.RecordYear(currentDate, () => {
//  // YearviewModel의 동작이 끝난 후에 실행되는 코드
//  console.log('YearviewModel 동작 완료!');
//});



