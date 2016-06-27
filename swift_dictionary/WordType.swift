//
//  File.swift
//  swift_dictionary
//
//  Created by xionghuanxin on 6/27/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

import Foundation
protocol WordType :CustomStringConvertible {
    var name : String {get}
    var prounciation : String {get}
    var difination : String{get}
    
}

struct kingSoftWord : WordType {
    var name : String
    var prounciation :String
    var difination :String
    var description : String{
        
        return "\(name),\(prounciation),\(difination)"
        
    }
}


struct youDaoWord : WordType {
    var name : String
    var prounciation :String
    var difination :String
    var description : String{
        
        return "\(name),\(prounciation),\(difination)"
        
    }
}


struct baiDuWord : WordType {
    var name : String
    var prounciation :String
    var difination :String
    var description : String{
        
        return "\(name),\(prounciation),\(difination)"
        
    }
}
