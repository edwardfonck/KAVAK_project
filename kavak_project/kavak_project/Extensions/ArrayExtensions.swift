//
//  ArrayExtensions.swift
//  kavak_project
//
//  Created by Eduardo Fonseca on 8/5/19.
//  Copyright © 2019 Eduardo Fonseca. All rights reserved.
//

import UIKit

extension Array where Element: Hashable {
    var ValueAsSet: Set<Element> {
        return Set<Element>(self)
    }
}
