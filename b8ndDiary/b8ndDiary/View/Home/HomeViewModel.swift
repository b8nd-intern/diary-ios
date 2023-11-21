//
//  HomeViewModel.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 11/15/23.
//

import Foundation


final class HomeViewModel : ObservableObject {
    @Published var list: [DataModel] = []
    
    @Published var offset: CGFloat = 0
    //    @Published var direct: Direct = .none
    private var originOffset: CGFloat = 0
    private var isCheckedOriginOffset: Bool = false
    
    func setOriginOffset(_ offset: CGFloat) {
        guard !isCheckedOriginOffset else { return }
        self.originOffset = offset
        self.offset = offset
        isCheckedOriginOffset = true
    }
    
    func setOffset(_ offset: CGFloat) {
        guard isCheckedOriginOffset else { return }
        self.offset = offset
    }
    
    
    @MainActor
    func initDiaryList() {
        Task {
            do {
                let data = try await PostSerivce.getList()
                list = data.data!
                print(list)
            } catch {
                
            }
        }
    }
}
