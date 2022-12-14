//
//  PersonalProfileImageViewModel.swift
//  Gather
//
//  Created by Yi Xu on 9/12/22.
//

import Foundation
import SwiftUI
import Combine

class PersonalProfileImageViewModel: ObservableObject {
//    @Published var profileImageURL: URL? = nil
    @Published var profileImage: Image? = nil
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var profileImageService: PersonalProfileImageServiceProtocol
    
    init(profileImageService: PersonalProfileImageServiceProtocol = PersonalProfileImageService.shared) {
        self.profileImageService = profileImageService
        
        self.profileImageService.personalProfileImageDataPublisher.sink { data in
            guard let data = data else {
                return
            }
            guard let uiImage = UIImage(data: data) else {
                return
            }
            self.profileImage = Image(uiImage: uiImage)

        }.store(in: &cancellableSet)
    }
    
    func updateProfileImage(data: Data) {
        print("Start updating image to cloud server")
        guard let uiImage = UIImage(data: data) else {
            return
        }
        self.profileImage = Image(uiImage: uiImage)
        profileImageService.uploadImage(imageRawData: data)
    }
    
}

