//
//  main.swift
//  FilatovLab2
//
//  Created by Павел Разуваев on 4/27/19.
//  Copyright © 2019 Павел Разуваев. All rights reserved.
//

import Foundation


var a = binaryTree()
a.readFromFile("/Users/zirael/Projects/Swift/FilatovLab2/FilatovLab2/tree.txt")
var b = binaryTree()
b.readFromFile("/Users/zirael/Projects/Swift/FilatovLab2/FilatovLab2/treeOneLine.txt")

print("Дерево А: ")
a.postOrder()
print("Дерево B: ")
b.inOrder()

a.insertTree(b)

print("Дерево A<-B: ")
a.postOrder()
