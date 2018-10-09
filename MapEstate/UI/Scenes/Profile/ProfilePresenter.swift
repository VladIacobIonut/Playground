//
//  ProfilePresenter.swift
//  MapEstate
//
//  Created by Vlad on 03/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation

protocol ProfilePresenter: class {
    var view: ProfileViewProtocol? { get set }
    func retrieveExamples()
    func presentExample(at index: Int)
}
