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
    static func connect (){
        let socket = SocketIOClient(socketURL: URL(string: "http://10.60.45.94:3000")!, config: [.log(true), .forcePolling(true)])
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        socket.emit("set", 40, 1);
        
        socket.connect();
        
    }
}
