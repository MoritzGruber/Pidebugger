package com.moritzgruber.pidebugger.pidebugger;

import android.os.Bundle;

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
    public void send(){
        mSocket.emit("new message", "hello world from hdm");
    }
}
