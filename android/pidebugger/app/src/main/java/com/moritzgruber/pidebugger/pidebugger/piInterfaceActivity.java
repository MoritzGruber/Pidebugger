package com.moritzgruber.pidebugger.pidebugger;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.Space;

public class PiInterfaceActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pi);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        //template code
        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });
        //find both rows in the the view and define them
        LinearLayout leftRow = (LinearLayout)findViewById(R.id.leftRow);
        LinearLayout rightRow = (LinearLayout)findViewById(R.id.rightRow);
        //define layout params for the button
        Toolbar.LayoutParams lp = new Toolbar.LayoutParams(Toolbar.LayoutParams.WRAP_CONTENT, Toolbar.LayoutParams.WRAP_CONTENT);
        //create an array to store the created buttons
        Button[] pinArrry = new Button[40];

        for (int i = 0; i < 40; i++) {
            //create new button and store it in the array
            pinArrry[i] = new Button(this);
            //set inital text for that button
            pinArrry[i].setText("Pin" +(i+1));
            //check if the index is odd or even, since its an int we can use the bitwise and operator, its faster than modulo
            if ( (i & 1) == 0 ) {
                //even... so button is added to the right row
                leftRow.addView(pinArrry[i], lp);
            } else {
                //odd... so button is added to the left row
                rightRow.addView(pinArrry[i], lp);
            }
        }
    }
}
