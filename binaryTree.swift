//
//  binaryTree.swift
//  FilatovLab2
//
//  Created by Павел Разуваев on 4/27/19.
//  Copyright © 2019 Павел Разуваев. All rights reserved.
//

import Foundation

class binaryTree {
    
    private var listOfSon: Array<Node>
    var rootNodeValue: Int
    private var rootValueBool: Bool = false
    private var N = 10000
    private let rootDefaultValue = -2
    private let emptyNodeValue: Int? = nil
    private var tmpNode: Node
    private var orderArray: Array<Int>

    

    init() {
        
        self.listOfSon = []
        self.orderArray = []
        self.tmpNode = Node()
        self.rootNodeValue = -2
        for _ in 0...N {
            listOfSon.append(Node())
        }
        
    }
    
    func show() {
        
        for i in 1...N {
            
            print(i, ")", showValue(listOfSon[i].value), showValue(listOfSon[i].left), showValue(listOfSon[i].right), "\n", separator: " ")
            
        }
        
    }
    
    func readFromFile(_ path: String) {
        
        let file: FileHandle? = FileHandle(forReadingAtPath: path)
        if file != nil {
            
            let data = file?.readDataToEndOfFile()
            file?.closeFile()
            var strData = String(data: data!, encoding: String.Encoding.utf8)
            strData?.removeLast()
            let dataArray: Array<String> = (strData?.components(separatedBy: "\n"))!
            (dataArray.count == 1) ? (workWithDataOnOneLine(dataArray)) : (workWithDataOnLines(dataArray))
            
        } else {
            
            print("Ooops! Something went wrong!")
            
        }
        
    }
    
    func randomFill(_ n: Int, _ rnd: Int) {
        
        guard n > rnd else { return }
        N = n
        var i = 0
        var addFlag = false
        while (i < rnd) {
            
            let element = Int.random(in: 1...N)
            addFlag = false
            
            if (!isValueInTheBinaryTree(element)) {
                
                add(element)
                addFlag = true
                
            }
            
            if (addFlag) {
                
                i += 1
                
            }
            
        }
        
    }
    
    func randomFill(_ n: Int) {
        
        N = n
        var i = 0
        var addFlag = false
        while (i < N - Int.random(in: 0...N/2)) {
            
            let element = Int.random(in: 1...N)
            addFlag = false
            
            if (!isValueInTheBinaryTree(element)) {
                
                add(element)
                addFlag = true
                
            }
            
            if (addFlag) {
                
                i += 1
                
            }
            
        }
        
    }
    
    func add(_ valueToAdd: Int) {
        
        addNode(rootNodeValue, valueToAdd)
        
    }
    
    func delete(_ valueToDelete: Int) {
        
        deleteNode(rootNodeValue, valueToDelete)
        
    }
    
    func postOrder() {
        
        postOrderT(rootNodeValue)
        print()
        
    }
    
    func inOrder() {
        
        inOrderT(rootNodeValue)
        print()
        
    }
    
    func returnOrderArray() -> Array<Int> {
        
        preOrderA(rootNodeValue)
        return orderArray
        
    }
    
    func insertTree(_ subTree: binaryTree) {
        
        let subTreeOrderArray = subTree.returnOrderArray()
        preOrderA(rootNodeValue)
        for element in subTreeOrderArray {

            if orderArray.contains(element) {
                delete(element)
            }

        }
        
        for element in subTreeOrderArray {
            
            add(element)
            
        }
        
    }
    
    private func postOrderT(_ currentNodeValue: Int?) {
        
        guard currentNodeValue != nil else { return }
        postOrderT(listOfSon[currentNodeValue!].left)
        postOrderT(listOfSon[currentNodeValue!].right)
        print(listOfSon[currentNodeValue!].value!, terminator: " ")
        
    }
    
    private func inOrderT(_ currentNodeValue: Int?) {
        
        guard currentNodeValue != nil else { return }
        inOrderT(listOfSon[currentNodeValue!].left)
        print(listOfSon[currentNodeValue!].value!, terminator: " ")
        inOrderT(listOfSon[currentNodeValue!].right)
        
    }
    
    private func preOrderA(_ currentNodeValue: Int?) {
        
        guard currentNodeValue != nil else { return }
        orderArray.append(listOfSon[currentNodeValue!].value!)
        preOrderA(listOfSon[currentNodeValue!].left)
        preOrderA(listOfSon[currentNodeValue!].right)
        
    }
    
    private func workWithDataOnLines (_ data: Array<String>) {
        
        for str in data {
            
            let valueStrArray: Array<String> = str.components(separatedBy: " ")
            var valueArray: Array<Int> = []
            for item in valueStrArray {
                
                guard let element = Int(item) else { print("ошибка конвертации string to int"); return }
                guard element > 0 else { print("на входе содержится значение меньше нуля"); return }
                valueArray.append(element)
                
            }
            
            if !rootValueBool {
                
                rootNodeValue = valueArray[0]
                rootValueBool = true
                
            }
            
            switch valueArray.count {
            case 3:
                
                guard valueArray[1] != valueArray[2] else { print("на входе содержатся одинаковые сыновья"); return }
                guard valueArray[0] != valueArray[1] && valueArray[0] != valueArray[2]  else { print("на входе содержатся родители равные сыновьям"); return }
                listOfSon[valueArray[0]].value = valueArray[0]
                listOfSon[valueArray[0]].left = min(valueArray[1], valueArray[2])
                listOfSon[valueArray[0]].right = max(valueArray[1], valueArray[2])
                
            case 2:
                
                listOfSon[valueArray[0]].value = valueArray[0]
                guard valueArray[0] != valueArray[1] else { print("на входе содержатся родители равные сыновьям"); return }
                listOfSon[valueArray[0]].value = valueArray[0]
                (valueArray[1] > valueArray[0]) ? (listOfSon[valueArray[0]].right = valueArray[1]) : (listOfSon[valueArray[0]].left = valueArray[1])
                
            case 1:
                
                self.listOfSon[valueArray[0]].value = valueArray[0]
                
            default:
                
                return
                
            }
            
        }
        
    }
    
    private func workWithDataOnOneLine (_ data: Array<String>) {
        
        let valueStrArray: Array<String> = data[0].components(separatedBy: " ")
        
        for element in valueStrArray {
            
            guard let item = Int(element) else { print("ошибка конвертации string to int"); return }
            guard item > 0 else { print("на входе содержится значение меньше нуля"); return }
            guard isValueInTheBinaryTree(item) != true else {print("на входе 2 одинаковых числа"); return }
            addNode(rootNodeValue, item, nil)
            
        }
        
    }
    
    private func addNode(_ currentNodeValue: Int?, _ valueToAdd: Int, _ parentNodeValue: Int? = nil) {

        if (currentNodeValue == emptyNodeValue) {
            
            listOfSon[valueToAdd].value = valueToAdd
            (listOfSon[parentNodeValue!].value! > valueToAdd) ? (listOfSon[parentNodeValue!].left = valueToAdd) : (listOfSon[parentNodeValue!].right = valueToAdd)
            
        }
        
        guard isInt(currentNodeValue) else { return } //  костыль страшный
        if (currentNodeValue! == rootDefaultValue) {
            
            guard (valueToAdd <= listOfSon.count) else { print("увеличьте размер массива, чичло больше максимума"); return }
            listOfSon[valueToAdd].value = valueToAdd
            rootNodeValue = valueToAdd
            
        } else {
            
            (listOfSon[currentNodeValue!].value! > valueToAdd) ? (addNode(listOfSon[currentNodeValue!].left, valueToAdd, listOfSon[currentNodeValue!].value!)) : (addNode(listOfSon[currentNodeValue!].right, valueToAdd, listOfSon[currentNodeValue!].value!))
            
            }
        
        }
    
    private func deleteNode(_ currentNodeValuue: Int?, _ valueToDelete: Int?, _ parentNodeValue: Int? = nil) {
        
        guard isValueInTheBinaryTree(valueToDelete!) else { print("вы пытаетесь удалить значение, которого нет в дереве"); return }
        
        if (currentNodeValuue == valueToDelete) {
            
            if (valueToDelete == rootNodeValue) {
                
                if (isInt((listOfSon[valueToDelete!].right)) && isInt((listOfSon[valueToDelete!].left))) {
                    
                    tmpNode.value = maxTree(listOfSon[valueToDelete!].left)
                    tmpNode.left = listOfSon[maxTree(listOfSon[valueToDelete!].left)!].left
                    tmpNode.right = listOfSon[maxTree(listOfSon[valueToDelete!].left)!].right
                    delete(maxTree(listOfSon[valueToDelete!].left)!)
                    listOfSon[tmpNode.value!] = Node(tmpNode.value, listOfSon[valueToDelete!].left, listOfSon[valueToDelete!].right)
                    listOfSon[valueToDelete!] = Node(emptyNodeValue, emptyNodeValue, emptyNodeValue)
                    rootNodeValue = tmpNode.value!
                    return
                    
                }
                
                if (!isInt((listOfSon[valueToDelete!].right)) && isInt((listOfSon[valueToDelete!].left))) {
                 
                    rootNodeValue = listOfSon[valueToDelete!].left!
                    listOfSon[valueToDelete!] = Node(emptyNodeValue, emptyNodeValue, emptyNodeValue)
                    
                }
                
                if (isInt((listOfSon[valueToDelete!].right)) && !isInt((listOfSon[valueToDelete!].left))) {
                    
                    rootNodeValue = listOfSon[valueToDelete!].right!
                    listOfSon[valueToDelete!] = Node(emptyNodeValue, emptyNodeValue, emptyNodeValue)
                    
                }
                
                if (!isInt((listOfSon[valueToDelete!].right)) && !isInt((listOfSon[valueToDelete!].left))) {
                    
                    listOfSon[valueToDelete!] = Node(emptyNodeValue, emptyNodeValue, emptyNodeValue)
                    rootNodeValue = rootDefaultValue
                    
                }
                
                return
                
            }
            
            if (!isInt(listOfSon[valueToDelete!].right) && !isInt(listOfSon[valueToDelete!].left)) {
                
                (listOfSon[parentNodeValue!].value! > valueToDelete!) ? (listOfSon[parentNodeValue!].left = emptyNodeValue) : (listOfSon[parentNodeValue!].right = emptyNodeValue)
                listOfSon[valueToDelete!].value = emptyNodeValue
                
            }
            
            if (isInt(listOfSon[valueToDelete!].left) && !isInt(listOfSon[valueToDelete!].right)) {
                
                (listOfSon[parentNodeValue!].left == valueToDelete) ? (listOfSon[parentNodeValue!].left = listOfSon[valueToDelete!].left!) : (listOfSon[parentNodeValue!].right = listOfSon[valueToDelete!].left!)
                listOfSon[valueToDelete!] = Node(emptyNodeValue, emptyNodeValue, emptyNodeValue)
                
            }
            
            if (isInt(listOfSon[valueToDelete!].right) && !isInt(listOfSon[valueToDelete!].left)) {
                
                (listOfSon[parentNodeValue!].left == valueToDelete) ? (listOfSon[parentNodeValue!].left = listOfSon[valueToDelete!].right!) : (listOfSon[parentNodeValue!].right = listOfSon[valueToDelete!].right!)
                listOfSon[valueToDelete!] = Node(emptyNodeValue, emptyNodeValue, emptyNodeValue)
                
            }
            
            if (isInt(listOfSon[valueToDelete!].right) && isInt(listOfSon[valueToDelete!].left)) {
                
                if (listOfSon[parentNodeValue!].left == valueToDelete) {
                    
                    tmpNode.value = maxTree(listOfSon[valueToDelete!].left)
                    tmpNode.left = listOfSon[maxTree(listOfSon[valueToDelete!].left)!].left
                    tmpNode.right = listOfSon[maxTree(listOfSon[valueToDelete!].left)!].right
                    delete(maxTree(listOfSon[valueToDelete!].left)!)
                    listOfSon[tmpNode.value!] = Node(tmpNode.value, listOfSon[valueToDelete!].left, listOfSon[valueToDelete!].right)
                    listOfSon[valueToDelete!] = Node(emptyNodeValue, emptyNodeValue, emptyNodeValue)
                    listOfSon[parentNodeValue!].left = tmpNode.value
                    
                } else {
                    
                    tmpNode.value = minTree(listOfSon[valueToDelete!].right)
                    tmpNode.left = listOfSon[minTree(listOfSon[valueToDelete!].right)!].left
                    tmpNode.right = listOfSon[minTree(listOfSon[valueToDelete!].right)!].right
                    delete(minTree(listOfSon[valueToDelete!].right)!)
                    listOfSon[tmpNode.value!] = Node(tmpNode.value, listOfSon[valueToDelete!].left, listOfSon[valueToDelete!].right)
                    listOfSon[valueToDelete!] = Node(emptyNodeValue, emptyNodeValue, emptyNodeValue)
                    listOfSon[parentNodeValue!].right = tmpNode.value
                  
                }
                
            }
            
        } else {
            
            (currentNodeValuue! > valueToDelete!) ? (deleteNode(listOfSon[currentNodeValuue!].left!, valueToDelete!, currentNodeValuue!)) : (deleteNode(listOfSon[currentNodeValuue!].right!, valueToDelete!, currentNodeValuue!))
            
        }
        
    }
    
    func whoIsMyParent(_ sonValue: Int) -> Int? {
        
        guard isValueInTheBinaryTree(sonValue) else { print("вы пытаетесь узнать значение родителя сына, которого нет в дереве"); return emptyNodeValue}
        var parentNodeValue: Int? = emptyNodeValue
        
        for item in listOfSon {
            
            if (item.left == sonValue) {
                
                parentNodeValue = item.value!
                
            }
            
            if (item.right == sonValue) {
                
                parentNodeValue = item.value!
                
            }
            
        }
        
        if (rootNodeValue == sonValue) {
            
            return -2
            
        } else {
            
            return parentNodeValue
            
        }
    }
    
    private func isValueInTheBinaryTree (_ value: Int) -> Bool {
        
        var flag = false
        for item in listOfSon {

            if (item.value == value) {

                flag = true

            }

        }
        
        return flag
        
    }
    
    func isValueInTheBinaryTreeT (_ value: Int) -> Bool {
        
        
        
        
        return true
        
    }
    

    
    private func showValue(_ value: Int?) -> String {
        
        if (value == emptyNodeValue) {
            
            return "   "
            
        } else {
            
            return String(value!)
            
        }
        
    }
    
    private func isInt(_ value: Int?) -> Bool {
        
        if (value == emptyNodeValue) {
            
            return false
            
        } else {
            
            return true
            
        }
        
    }
    
    func maxTree (_ currentNode: Int?) -> Int? {
        
        guard isValueInTheBinaryTree(currentNode!) else { print("вы пытаетесь узнать максимум поддерева виршины, которой нет в дереве"); return nil }
        var max: Int? = nil
        
        if (!isInt(listOfSon[currentNode!].left) && !isInt(listOfSon[currentNode!].right)) {
            
            max = currentNode!
            
        } else if (!isInt(listOfSon[currentNode!].left) && isInt(listOfSon[currentNode!].right)) {
            
            max = maxTree(listOfSon[currentNode!].right!)
            
        } else if (isInt(listOfSon[currentNode!].left) && !isInt(listOfSon[currentNode!].right)) {
            
            max = currentNode!
            
        } else {
            
            (listOfSon[currentNode!].left! > listOfSon[currentNode!].right!) ? (max = maxTree(listOfSon[currentNode!].left!)) : (max = maxTree(listOfSon[currentNode!].right!))
            
        }
        
        return max
    }
    
    func minTree (_ currentNode: Int?) -> Int? {
        
        guard isValueInTheBinaryTree(currentNode!) else { print("вы пытаетесь узнать минимум поддерева виршины, которой нет в дереве"); return nil }
        var min: Int? = nil
        
        if (!isInt(listOfSon[currentNode!].left) && !isInt(listOfSon[currentNode!].right)) {
            
            min = currentNode!
            
        } else if (!isInt(listOfSon[currentNode!].left) && isInt(listOfSon[currentNode!].right)) {
            
            min = currentNode!
            
        } else if (isInt(listOfSon[currentNode!].left) && !isInt(listOfSon[currentNode!].right)) {
            
            min = minTree(listOfSon[currentNode!].left!)
            
        } else {
            
            (listOfSon[currentNode!].left! < listOfSon[currentNode!].right!) ? (min = minTree(listOfSon[currentNode!].left!)) : (min = minTree(listOfSon[currentNode!].right!))
            
        }
        
        return min
        
    }

}
