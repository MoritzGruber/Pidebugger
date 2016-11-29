//
//  socketService.swift
//  pidebugger
//
//  Created by Moritz Gruber on 08/11/16.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import Foundation
import SocketIO



class socketService {
    var socket:SocketIOClient;
    
    init(){
        //setup socket connection
        socket = SocketIOClient(socketURL: URL(string: "http://"+piIp+":3000")!, config: [.log(true), .forcePolling(true)])
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        socket.on("disconnect") {data, ack in
            print("socket disconnected")
        }
        
        socket.connect();
        
    }
    
    func setPin(pin: Int, Value: Int) {
        //emit the set pin to the raspberrypi
        socket.emit("set", 40, 1);
    }
}
