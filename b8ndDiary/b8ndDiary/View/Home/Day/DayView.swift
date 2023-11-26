//
//  DayView.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct DayView: View {
    
    let dayViewModel: DayViewModel
    
    @State var isWritten: Bool = true
    
    var dayList: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    
    static func getDayOfWeek(date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEEEE"
            formatter.locale = Locale(identifier:"ko_KR")
            let convertStr = formatter.string(from: date)
            return convertStr
        }
    
    var today: String = getDayOfWeek(date: Date())
    
    var dayState: Bool
    
    var i: Int
    
    var body: some View {
        if today == dayList[i] {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 31.54, height: 33)
                .foregroundColor(dayState ? Colors.Blue1.color : Colors.Gray1.color)
                .overlay {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Colors.Blue4.color, lineWidth: 1)
                        if dayState {
                            VStack {
                                RoundedRectangle(cornerRadius: 60)
                                    .foregroundColor(Colors.red1.color)
                                    .frame(width: 5, height: 5)
                                    .padding(.bottom, 12)
                            }
                        }
                        Text("\(dayList[i])")
                            .font(.system(size: 12))
                            .foregroundColor(dayState ? Colors.Blue4.color : Colors.Black1.color)
                            .padding(.top, 16)
                        
                    }
                }
        }
        else {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 31.54, height: 33)
                .foregroundColor(dayState ? Colors.Blue1.color : Colors.Gray1.color)
                .overlay {
                    ZStack {
                        if dayState {
                            VStack {
                                RoundedRectangle(cornerRadius: 60)
                                    .foregroundColor(Colors.red1.color)
                                    .frame(width: 5, height: 5)
                                    .padding(.bottom, 12)
                            }
                        }
                        Text("\(dayList[i])")
                            .font(.system(size: 12))
                            .foregroundColor(dayState ? Colors.Blue4.color : Colors.Black1.color)
                            .padding(.top, 16)
                        
                    }
                }
        }
    }
}
