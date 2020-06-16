//
//  ControllerInfo.swift
//  
//
//  Created by Carson Katri on 6/16/20.
//

import Vapor

@propertyWrapper
public struct ControllerInfo {
    let info: Info
    
    public init(wrappedValue info: Info) {
        self.info = info
    }
    
    public var wrappedValue: Info {
        get { info }
    }
    
    public struct Info {
        let group: PathComponent?
        
        public init(group: PathComponent? = nil) {
            self.group = group
        }
    }
}
