//
//  ExampleCellViewModel.swift
//  MapEstate
//
//  Created by Vlad on 03/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

struct ExampleCellViewModel {
    // MARK: - Properties
    
    var title: String
    var icon: UIImage
    
    init(title: String, icon: UIImage) {
        self.title = title
        self.icon = icon
    }
}
