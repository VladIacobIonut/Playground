//
//  ProfileViewModel.swift
//  MapEstate
//
//  Created by Vlad on 03/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class ProfileViewModel {
    // MARK: - Properties
    private(set) var examples = [ExampleCellViewModel]()
    
    // MARK: - Functions
    
    func format(example: [Example]) {
        examples = example.examplesModels
    }
}

private extension Array where Element == Example {
    var examplesModels: [ExampleCellViewModel] {
        return compactMap { example in
            return ExampleCellViewModel(title: example.rawValue, icon: example.image)
        }
    }
}
