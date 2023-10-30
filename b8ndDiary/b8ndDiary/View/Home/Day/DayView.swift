//
//  DayView.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct DayView: View {
    
    @Binding var day: Int
    
    @State var isWritten: Bool = true
    
    var dayList: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    
    var dayStateList: [Bool] = [true, true, true, true, false, false, false]
    
    let today: String = "토"
    
    var body: some View {
        ForEach(0..<7, id: \.self) { i in
            if today == dayList[i] {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 31.54, height: 33)
                    .foregroundColor(dayStateList[i] ? Colors.Blue1.color : Colors.Gray1.color)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Colors.Blue4.color, lineWidth: 1)
                            if dayStateList[i] {
                                VStack {
                                    RoundedRectangle(cornerRadius: 60)
                                        .foregroundColor(Colors.red1.color)
                                        .frame(width: 5, height: 5)
                                        .padding(.bottom, 12)
                                }
                            }
                            Text("\(dayList[i])")
                                .font(.system(size: 12))
                                .foregroundColor(dayStateList[i] ? Colors.Blue4.color : Colors.Black1.color)
                                .padding(.top, 16)
                            
                        }
                    }
            }
            else {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 31.54, height: 33)
                    .foregroundColor(dayStateList[i] ? Colors.Blue1.color : Colors.Gray1.color)
                    .overlay {
                        ZStack {
                            if dayStateList[i] {
                                VStack {
                                    RoundedRectangle(cornerRadius: 60)
                                        .foregroundColor(Colors.red1.color)
                                        .frame(width: 5, height: 5)
                                        .padding(.bottom, 12)
                                }
                            }
                            Text("\(dayList[i])")
                                .font(.system(size: 12))
                                .foregroundColor(dayStateList[i] ? Colors.Blue4.color : Colors.Black1.color)
                                .padding(.top, 16)
                            
                        }
                    }
            }
        }
    }
}

