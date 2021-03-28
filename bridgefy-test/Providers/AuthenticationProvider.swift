//
//  UserProfileProvider.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 26/03/21.
//

import UIKit
import Bond

class AuthenticationProvider {
    
    private let apiService: ApiService
    let user = Observable<User?>(nil)
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    //    func getImage(url: String, completion: @escaping(Result<UIImage, Error>) -> Void) {
    //        guard let imageURL = URL(string: url) else {
    //            return
    //        }
    //        apiService.getImage(fromURL: imageURL) { (image, _) in
    //            guard let imageResult = image else {
    //                completion(.failure(NetworkError.nilData))
    //                return
    //            }
    //            completion(.success(imageResult))
    //        }
    //    }
    
    //    func fetchUserDataProfile(completion: @escaping(Result<UserProfile?, Error>) -> Void) {
    //        apiService.getUserData { result in
    //            switch result {
    //            case .success(let userData):
    //                self.persistenceController.storeUserProfile(with: userData)
    //                completion(.success(self.persistenceController.userProfile.value))
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    //
    //    func fetchUserVideos(completion: @escaping(Result<[UserVideo]?, Error>) -> Void) {
    //        apiService.getUserVideos { result in
    //            switch result {
    //            case .success(let userVideos):
    //                self.persistenceController.storeUserVideos(with: userVideos)
    //                completion(.success(self.persistenceController.userVideos.value))
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    
    //    func updateUserProfileWith(name: String, username: String, bio: String, selectedImage: Data?) {
    //        persistenceController.updateUserProfileWith(name: name,
    //                                                    username: username,
    //                                                    bio: bio,
    //                                                    selectedImage: selectedImage)
    //    }
    //
    //    func toggleUserVideoLikes(with userVideo: UserVideo) {
    //        persistenceController.toggleUserVideoLikes(with: userVideo)
    //    }
}
