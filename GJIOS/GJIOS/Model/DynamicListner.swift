//
//  DynamicListner.swift
//  GJIOS
//
//  Created by Shurbhi Natani on 09/09/19.
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import Foundation

class Dynamic<T> {
    var value: T? {
        willSet {
            listner?(newValue)
        }
    }
    private var listner: ((T?) -> ())?
    func bind(listner: @escaping ((T?) -> ())) {
        self.listner = listner
    }
}
