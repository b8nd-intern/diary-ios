//
//  MonthPage.swift
//  GoogleLogin
//
//  Created by dgsw8th61 on 2023/10/06.
//
import SwiftUI
import Network




struct MonthPage: View {
    var selectedMonth: Int
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var myMonthPost = MonthPost()
    
    var body: some View {
        VStack {
            Text("\(selectedMonth)월")
                .foregroundColor(.black)
                .font(.system(size: 30))
                .bold()
                .padding(.top, 20)
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
        .onAppear {
            Task {
                do {
                    let response = try await MonthPost.postMonth(month: selectedMonth ) // selectedMonth 값을 전달
                    DispatchQueue.main.async {
                        myMonthPost.dataModels = response.data ?? []
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}
