package com.moritzgruber.pidebugger.pidebugger;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;

public class SetupInterfaceActivity extends AppCompatActivity {

    //define elements
    static ProgressBar statusProgressBar;
    static TextView statusText;
    static Button setupButton;
    static Button skipButton;
    public static String ipAddress = "192.168.0.102"; //this could be any ip

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.setup_interface_screen);

        //init progress bar and status text
        statusProgressBar = (ProgressBar) findViewById(R.id.progressBar);
        statusProgressBar.setProgressDrawable(getDrawable(R.drawable.progressbar));
        statusText = (TextView) findViewById(R.id.textView2);


        //find the skip button and switch to the piInterface if you press it
        final Button button = (Button) findViewById(R.id.skip);
        button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on click
                startActivity(new Intent(SetupInterfaceActivity.this, PiInterfaceActivity.class));
            }
        });

        //disable buttons until you have found the ip of the raspberry pi
        skipButton = (Button) findViewById(R.id.skip);
        setupButton = (Button) findViewById(R.id.setup);
        //disableButton(skipButton);
        disableButton(setupButton);

        //setub button action
        setupButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                //change status message
                statusText.setText("Status: Setting up Server");
                //async execute all setup commands to setup the server
                AsyncTask setupServer = new SshExecTask().execute(
                        "sudo apt-get update",
                        "sudo apt-get dist upgrade",
                        "sudo apt-get install git -y",
                        "sudo apt-get install nodejs -y",
                        "sudo apt-get install npm -y && sudo ln -s /usr/bin/nodejs /usr/bin/node",
                        "git clone https://github.com/MoritzGruber/RPI.git",
                        "cd RPI && npm install",
                        "sh start.sh &"
                );
            }
        });

    }

    // Start Scanning the network immediately (async)
    AsyncTask asyncTask = new SearchForPiIpAddressTask().execute();


    //update progress bar
    public static void updateProgress (Integer i){
        statusProgressBar.setProgress(i);
    }

    //enable a button
    public static void enableButton(Button aButton) {
        aButton.setEnabled(true);
        aButton.setClickable(true);
        aButton.setAlpha(1);
    }

    //disable a button
    public static void disableButton(Button aButton) {
        aButton.setEnabled(false);
        aButton.setClickable(false);
        aButton.setAlpha(.5f);
    }
}
