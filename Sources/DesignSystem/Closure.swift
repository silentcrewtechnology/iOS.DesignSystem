//
//  File.swift
//  
//
//  Created by Firdavs on 29.03.2023.
//

import Foundation

//MARK: - CLOUSURES
public typealias ClosureReturn<T> = (() -> T)
public typealias Closure<T>       = ((T) -> Void)
public typealias ClosureEmpty     = (() -> Void)
public typealias ClosureTwo<T, G> = ((T, G) -> Void)
public typealias ClosureAny       = ((Any?) -> Void)
