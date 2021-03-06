package com.moritzgruber.pidebugger.pidebugger;

import android.app.Dialog;
import android.graphics.Point;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Display;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

public class PiInterfaceActivity extends AppCompatActivity {

    //define disabled Pins
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

        //fab that links to the legend
        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // legend dialog
                final Dialog dialog = new Dialog(PiInterfaceActivity.this);
                dialog.setContentView(R.layout.dialogcustom);
                dialog.show();
            }
        });

        //Define layout columns
        LinearLayout leftColumn = (LinearLayout)findViewById(R.id.leftColumn);
        LinearLayout rightColumn = (LinearLayout)findViewById(R.id.rightColumn);
        LinearLayout descColumn = (LinearLayout)findViewById(R.id.descColumn);

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

        //this loop creates all 40 buttons and 20 textviews, so he fills up all the three linear layouts(columns) with 20 items
        //so a row has 2 buttons and 1 textView
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
                //even... so button is added to the right column
                leftColumn.addView(pinArray[i], layoutParams);
            } else {
                //odd... so button is added to the left column
                rightColumn.addView(pinArray[i], layoutParams);

                //create a description of the pins for each row buttons

                //create text view and give the right properties
                TextView tv = new TextView(this);
                tv.setWidth(screenWidth/4);
                tv.setHeight(screenWidth/4);
                tv.setPadding(0, screenWidth/10, 0 , 5);
                //set the text as the pin numbers are in the current level and add the label to the view
                tv.setText(" "+i+" / "+(i+1));
                descColumn.addView(tv, layoutParams);
            }

            //deactivate some pins and style according to there functions
            if(isDisabled(i)){
                pinArray[i-1].setClickable(false);
                pinArray[i-1].setEnabled(false);
                pinArray[i-1].setText("");

                if(i == 27 || i == 28){
                    //style for ic pins
                    pinArray[i-1].setBackground(getDrawable(R.drawable.ic_pin));
                }
                else if(i == 2 || i == 4){
                    //style for 5V pins
                    pinArray[i-1].setBackground(getDrawable(R.drawable.v5_pin));

                }
                else if(i == 1 || i == 17){
                    //style for 3V pins
                    pinArray[i-1].setBackground(getDrawable(R.drawable.v3_pin));
                } else {
                    //style for ground pins
                    pinArray[i-1].setBackground(getDrawable(R.drawable.ground_pin));
                }
            }

        }
    }
    //this function checks if the given pin is in the list of disabled pins
    public boolean isDisabled (int pinNumber){
        for (int j=0; j<disabledPins.length; j++) {
            if(disabledPins[j] == pinNumber){
                return true;
            }
        }
        return false;
    }
}
