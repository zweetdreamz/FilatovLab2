//
//  Node.swift
//  FilatovLab2
//
//  Created by Павел Разуваев on 4/27/19.
//  Copyright © 2019 Павел Разуваев. All rights reserved.
//


class Node {
    
    var value, left, right: Int?
    
    init (_ Value: Int? = nil, _ Left: Int? = nil, _ Right: Int? = nil) {
        
        self.value = Value
        self.left = Left
        self.right = Right
        
    }
    
}
