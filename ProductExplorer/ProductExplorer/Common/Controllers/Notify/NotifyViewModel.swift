//
//  NotifyViewModel.swift
//  RepoUserExplorer
//
//  Created by Haroon Ur Rasheed on 02/05/2020.
//  Copyright © 2020 hr147. All rights reserved.
//

import UIKit.UIImage

struct NotifyViewModel {
    let title: String
    let notification: String
    let image: UIImage
}

extension NotifyViewModel {
    static func errorNotificationViewModel(with error: Error) -> Self {
        .init(title: "Searching Failed!", notification: error.localizedDescription, image: #imageLiteral(resourceName: "error"))
    }
    
    static func emptyNotificationViewModel() -> Self {
        .init(title: "Result not found", notification: "Please try again with different keyword.", image: #imageLiteral(resourceName: "search"))
    }
    
    static func startNotificationViewModel() -> Self {
        .init(title: "Search Users...", notification: "", image: #imageLiteral(resourceName: "search"))
    }
}
