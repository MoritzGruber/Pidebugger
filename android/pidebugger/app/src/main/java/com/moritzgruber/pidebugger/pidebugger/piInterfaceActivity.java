package com.moritzgruber.pidebugger.pidebugger;

import android.graphics.Point;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.Display;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

public class PiInterfaceActivity extends AppCompatActivity {

    int[] disabledPins = {1,2,4,6,9,14,17,20,25,27,28,30,34,39};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pi);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayShowTitleEnabled(false);

        //setting up socket
        final SocketService mySocket = new SocketService();
        mySocket.connect();

        //template code
        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Legend goes in here", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });

        //find both rows in the the view and define them
        LinearLayout leftRow = (LinearLayout)findViewById(R.id.leftRow);
        LinearLayout rightRow = (LinearLayout)findViewById(R.id.rightRow);
        LinearLayout descRow = (LinearLayout)findViewById(R.id.descRow);

        //define layout params for the button
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                RelativeLayout.LayoutParams.WRAP_CONTENT,
                RelativeLayout.LayoutParams.WRAP_CONTENT);
        layoutParams.bottomMargin= 10;

        //create an array to store the created buttons
        final Button[] pinArray = new Button[40];



        //mesure screen width and height as dp and convert them to pixel
        Display display = getWindowManager().getDefaultDisplay();
        Point size = new Point();
        display.getSize(size);
        int screenWidth = size.x;
        int ScreenHeight = size.y;
        //log the result values
        Log.w("screenWidth = ", ""+screenWidth);
        Log.w("ScreenHeight = ", ""+ScreenHeight);

        //this loop creates all 40 buttons and 20 textviews, so he fills up all the three linear layouts with 20 items
        for (int i = 0; i < 40; i++) {
            //create new button and store it in the array
            pinArray[i] = new Button(this);
            //for active buttons online
            pinArray[i].setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    // Perform action on click
                    if(pinArray[v.getId()].getText() == "l"){
                        pinArray[v.getId()].setText("h");
                        mySocket.send(v.getId(), 1);
                    } else {
                        pinArray[v.getId()].setText("l");
                        mySocket.send(v.getId(), 0);

                    }

                }
            });
            //give the right styling to the button
            pinArray[i].setBackground(getDrawable(R.drawable.active_pin));
            pinArray[i].setTextSize(50);
            pinArray[i].setWidth(screenWidth/4);
            pinArray[i].setHeight(screenWidth/4);
            pinArray[i].setTransformationMethod(null);
            //set id of the button
            pinArray[i].setId(i);



            //set inital text for that button
            pinArray[i].setText("l");

            //check if the index is odd or even, since its an int we can use the bitwise and operator, its faster than modulo
            if ( (i & 1) == 0 ) {
                //even... so button is added to the right row
                leftRow.addView(pinArray[i], layoutParams);
            } else {
                //odd... so button is added to the left row
                rightRow.addView(pinArray[i], layoutParams);

                //create a description of the pins for each to buttons

                //create text view and give the right properties
                TextView tv = new TextView(this);
                tv.setWidth(screenWidth/4);
                tv.setHeight(screenWidth/4);
                tv.setPadding(0, screenWidth/10, 0 , 5);
                //set the text as the pin numbers are in the current level and add the label to the view
                tv.setText(" "+i+" / "+(i+1));
                descRow.addView(tv, layoutParams);
            }

            if(isDisabled(i)){
                pinArray[i-1].setClickable(false);
                pinArray[i-1].setEnabled(false);
                pinArray[i-1].setBackground(getDrawable(R.drawable.ground_pin));
                if(i == 1)
            }

        }
    }

    public boolean isDisabled (int pinNumber){
        for (int j=0; j<disabledPins.length; j++) {
            if(disabledPins[j] == pinNumber){
                return true;
            }
        }
        return false;
    }
}
