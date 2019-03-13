//
//  Node.swift
//  Squeeze1
//
//  Created by Nic Casson on 2018-12-23.
//  Copyright © 2018 CassonApps. All rights reserved.
//

import Foundation


class LinkedList{
    
    
    private class Node{
        
        public var enemies = Array<String>()
        fileprivate(set) var next: Node?
        
        init(newEnemyList: Array<String>) {
            self.enemies = newEnemyList
            next = nil
        }
    }
    
    private var head: Node?
    private var tail: Node?
    
    init() {
        head = nil
        tail = nil
    }
    
    public func moveIn(newList: Array<String>){
        var newTail = Node(newEnemyList: newList)
        if((head == nil)&&(tail == nil)){
            head = newTail
            tail = newTail
        }
        else{
            tail?.next = newTail
            tail = newTail
        }
    }
    
    public func moveOut() -> Array<String>{
        var returnList:Array<String>?
        if(head != nil){
            returnList = head?.enemies
            if(head?.next == nil){
                head = nil
                tail = nil
            }
            else{
                head = head?.next
            }
        }
        return returnList!
    }
    
    public func printList() -> Array<Array<String>>{
        var curr = head
        var outA = Array<Array<String>>()
        while curr != nil {
            outA.append((curr?.enemies)!)
            curr = head?.next
        }
        return outA
    }
    
}
