import SwiftUI
func createSquareGrid(YearviewModeldate: [Bool]) -> some View {
    return HStack(spacing: 10) {
        ForEach(0..<52, id: \.self) { row in
            VStack(spacing: 10) {
                ForEach(0..<7, id: \.self) { column in
                    
                    let b = row * 7 + column
                    if b < YearviewModeldate.count && b <= 365 {
                        Rectangle()
                            .foregroundColor(YearviewModeldate[b] ? Colors.Blue1.color : Colors.Gray1.color)
                            .frame(width: 15, height: 15)
                            .cornerRadius(3)
                    }
                    else if b <= 365 {
                        Rectangle()
                            .foregroundColor(Colors.Gray1.color)
                            .frame(width: 15, height: 15)
                            .cornerRadius(3)
                    }
                    else{
                        Color.clear
                            .foregroundColor(Colors.Gray1.color)
                            .frame(width: 15, height: 15)
                            .cornerRadius(3)
                    }
                    
                }
            }
        }
    }
}





struct YearCalendar: View {
    
    @Binding var userId : String
    @StateObject var YearviewModel = YearCalendarViewModel()
    let months = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 10) {
                ForEach(months, id: \.self) { month in
                    VStack {
                        Text(month)
                            .padding(.trailing,83)
                            .font(.system(size: 10))
                            .foregroundColor(.black)
                        
                    }
                }
                
            }
            createSquareGrid(YearviewModeldate: YearviewModel.Yeardate)
            
        }
        .onAppear{
            YearviewModel.userId = userId
            YearviewModel.RecordYear (callback: {
                
            })
//            print("실행 : ",YearviewModel.Yeardate)
        }
        
    }
}


