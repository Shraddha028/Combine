//
//  ApiViewModel.swift
//  CombineBootcamp
//
//  Created by Shraddha Sutar on 04/01/24.
//

import Foundation
import Combine

class ApiViewModel: ObservableObject {
    @Published var photos = [Photo]()
    var cancellable = Set<AnyCancellable>()
    
    init() {
        getDataFromApi()
    }
    
    func getDataFromApi() {
        let url = "https://api.slingacademy.com/v1/sample-data/photos?offset=5&limit=20"
        guard let request = URL(string: url) else { return }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) in
                guard let res = response as? HTTPURLResponse, res.statusCode == 200, res.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: ResponseData.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("Completed")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] responseData in
                self?.photos = responseData.photos
            }.store(in: &cancellable)
    }
    
}
