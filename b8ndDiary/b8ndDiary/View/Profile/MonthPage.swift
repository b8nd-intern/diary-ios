//
//  MonthPage.swift
//  GoogleLogin
//
//  Created by dgsw8th61 on 2023/10/06.
//
import SwiftUI

struct MonthPage: View {
    var selectedMonth: String
    @Environment(\.presentationMode) var presentationMode
        var body: some View {
            VStack{
                Text( "\(selectedMonth)")
                    .foregroundColor(.black)
                    .font(.system(size: 30))
                    .bold()
                    .padding(.top,20)
                    .padding(.trailing, 240)
                Spacer()
            }
            .navigationBarBackButtonHidden()
            .navigationBarItems(
                leading:
                    HStack(spacing: 16) {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        })
                        Spacer()
  
                    }
            )
        }
    }


struct MonthPage_Previews: PreviewProvider {
    static var previews: some View {
        MonthPage(selectedMonth: "0월") // Pass a value here
    }
}
