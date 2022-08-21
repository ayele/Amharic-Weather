//
//  ContentViewModel.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/21/22.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published private(set) var weather: Weather?
    @Published private(set) var isLoading = false
    @Published var isShowingAlert = false
    @Published private(set) var error: LocalizedError?
    
    private let service: WeatherService
    
    init(service: WeatherService) {
        self.service = service
    }
}
