//
//  UsersViewModel.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import Foundation
import Combine

final class UsersViewModel: ObservableObject {
    // MARK:- Subscribers
    private var cancellable: AnyCancellable?
    // MARK:- Publishers
    // MARK:- Publishers
    @Published var listUsers: [User] = []
    @Published var status = false
    
}

//MARK:- POST Payment card Network API call
extension UsersViewModel {
    
    func getListUsers() {
        self.status = true
        cancellable = UserService.getUsers(.listUsers)
            .print()
            .mapError({ (error) -> APIError in
                print(error)
                self.status = false

                return error
            })
            .sink(receiveCompletion: { (completion) in
                switch completion {
                    case .finished : self.status = false
                    case .failure(.unknown) ,
                         .failure(.parserError(reason: _)) ,
                         .failure(.payCardError(reason: _)),
                         .failure(.apiError(reason: _)) :
                        self.status = false

                    case .failure(.servicerError(reason: _)):
                        self.status = false
                        
                    case .failure(.networkError(reason: _)):
                        self.status = false

                    case .failure(.unauthorizedError(reason: _)):
                        self.status = false
                }
            },
            receiveValue: {
                self.listUsers = $0
            })
    }
}
