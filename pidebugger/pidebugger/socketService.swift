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
    
    init(pi: raspberrypi){
        socket = SocketIOClient(socketURL: URL(string: "http://"+pi.ip+":3000")!, config: [.log(true), .forcePolling(true)])
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        socket.on("disconnect") {data, ack in
            print("socket disconnected")
        }
        
        socket.emit("set", 40, 1);
        
        socket.connect();
        
    }
}
