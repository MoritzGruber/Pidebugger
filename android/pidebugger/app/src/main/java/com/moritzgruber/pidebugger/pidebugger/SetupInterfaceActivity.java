package com.moritzgruber.pidebugger.pidebugger;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;

public class SetupInterfaceActivity extends AppCompatActivity {

    static ProgressBar statusProgressBar;
    static TextView statusText;
    static Button setupButton;
    static Button skipButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.setup_interface_screen);

        //init progress bar
        statusProgressBar = (ProgressBar) findViewById(R.id.progressBar);
        statusText = (TextView) findViewById(R.id.textView2);


        //find the skip button and switch to the piInterface if you press it
        final Button button = (Button) findViewById(R.id.skip);
        button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on click
                startActivity(new Intent(SetupInterfaceActivity.this, PiInterfaceActivity.class));
            }
        });

        skipButton = (Button) findViewById(R.id.skip);
        skipButton.setEnabled(false);
        skipButton.setAlpha(.5f);
        skipButton.setClickable(false);
        setupButton = (Button) findViewById(R.id.setup);
        setupButton.setEnabled(false);
        setupButton.setAlpha(.5f);
        setupButton.setClickable(false);


        setupButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                Log.w("asdfasf ", " asdfasfd");
                statusText.setText("Status: Setting up Server");
                //AsyncTask setupServer = new SshConnectTask().execute("ls", "pwd");
                AsyncTask setupServer = new SshConnectTask().execute(
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
        statusProgressBar.setProgress(i);
    }

    AsyncTask a = new SearchForPiIpAdressTask().execute();
}
