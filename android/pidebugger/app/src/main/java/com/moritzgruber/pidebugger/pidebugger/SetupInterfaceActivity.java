package com.moritzgruber.pidebugger.pidebugger;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import com.moritzgruber.pidebugger.pidebugger.networkScanner.com.unwind.networkmonitor.Scan;

public class SetupInterfaceActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.setup_interface_screen);

        //find the skip button and switch to the piInterface if you press it
        final Button button = (Button) findViewById(R.id.skip);
        button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on click
                startActivity(new Intent(SetupInterfaceActivity.this, PiInterfaceActivity.class));
            }
        });

        //testing socket ...
        final SocketService mySocket = new SocketService("http://10.60.60.254:3000");
        mySocket.connect();
        final Button button2 = (Button) findViewById(R.id.setup);
        button2.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on click

                mySocket.send();
                Log.w("socket", "connected");
                startActivity(new Intent(SetupInterfaceActivity.this, Scan.class));


            }
        });
    }
}
