//
//  SequenceExtensions.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 25..
//  Copyright © 2022. levivig. All rights reserved.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(_ predicate: (Element) -> T, by areInIncreasingOrder: ((T,T)-> Bool) = (<)) -> [Element] {
        sorted(by: { areInIncreasingOrder(predicate($0), predicate($1)) })
    }
}
