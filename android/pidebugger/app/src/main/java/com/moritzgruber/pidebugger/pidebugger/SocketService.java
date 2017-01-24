package com.moritzgruber.pidebugger.pidebugger;

import java.net.URISyntaxException;

import io.socket.client.IO;
import io.socket.client.Socket;

public class SocketService {


    private Socket mSocket;


    public SocketService(String ipAdress) {
        // Body of constructor
        {
            try {
                mSocket = IO.socket(ipAdress);
            } catch (URISyntaxException e) {}
        }
    }

    public void connect() {
        mSocket.connect();
    }
    public void send(Integer pin, Integer Value){
        mSocket.emit("set", pin, Value);
    }
}
