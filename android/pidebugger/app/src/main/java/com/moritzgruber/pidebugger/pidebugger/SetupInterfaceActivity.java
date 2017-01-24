package com.moritzgruber.pidebugger.pidebugger;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;

public class SetupInterfaceActivity extends AppCompatActivity {

    static ProgressBar aProgressBar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.setup_interface_screen);

        //init progress bar
        aProgressBar = (ProgressBar) findViewById(R.id.progressBar);

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

                //
                //Log.w("try", "Status: " + a.getStatus());
                //AsyncTask setupServer = new SshConnectAsync().execute("ls", "pwd");
                AsyncTask setupServer = new SshConnectAsync().execute(
                        "sudo apt-get update",
                        "sudo apt-get dist upgrade",
                        "sudo apt-get install git -y",
                        "sudo apt-get install nodejs -y",
                        "sudo apt-get install npm -y && sudo ln -s /usr/bin/nodejs /usr/bin/node",
                        "git clone https://github.com/MoritzGruber/RPI.git",
                        "cd RPI && npm install",
                        "sh RPI/start.sh &"
                );
            }
        });
         //ssh.main("pi@192.168.0.100");

    }

    public static void updateProgress (Integer i){
        aProgressBar.setProgress(i);

    }

    AsyncTask a = new SearchForPiIpAdressTask().execute();
}
