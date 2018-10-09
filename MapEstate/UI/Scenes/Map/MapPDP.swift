//
//  MapPDP.swift
//  MapEstate
//
//  Created by Vlad on 17/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation

protocol MapPDP {
    var viewModel: MapVM { get }
    var getMapTilesUC: GetMaptilesUC { get }
}
