package com.moritzgruber.pidebugger.pidebugger;

import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.moritzgruber.pidebugger.pidebugger.PiInterfaceActivity;
import com.moritzgruber.pidebugger.pidebugger.R;

import dalvik.annotation.TestTargetClass;

import org.junit.Test;
import org.junit.runner.RunWith;

import java.util.regex.Pattern;

import static android.R.attr.button;
import static android.R.attr.fingerprintAuthDrawable;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;




public class buttonTest {

    //new test: check if buttons are clickable

    //new test: check if buttons are visible



    //check if values will be set correct on button click


    @Test
    public void buttonClickedTest() {



        final Button[] pinArray = new Button[40];



        for (int i = 0; i < 40; i++) {


            pinArray[i].setText("l");


            /*
            pinArray[i].setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {


                   v.performClick();

                    if(pinArray[v.getId()].getText() == "l"){
                        pinArray[v.getId()].setText("h");
                        assertTrue("h".equals(pinArray[v.getId()].getText()));

                    } else {
                        pinArray[v.getId()].setText("l");
                        assertTrue("l".equals(pinArray[v.getId()].getText()));

                    }

                }
            });
            */

            pinArray[i].setId(i);

            //pinArray[i].setText("l");

        }


        /*
        for (int i=0; i<40; i++){

            pinArrry[i].setText("l");
            assertTrue("l".equals(pinArrry[i].getText()));

            pinArrry[i].setOnClickListener(new View.OnClickListener() {
                   public void onClick(View v) {

                       if (pinArrry[v.getId()].getText() == "l") {
                           pinArrry[v.getId()].setText("h");
                           assertTrue("h".equals(pinArrry[i].getText()));


                       } else {
                           pinArrry[v.getId()].setText("l");


                       }
                   }

               }
               */








            //pinArrry[i] = new Button();

            //pinArrry[i].setText("l");

            //assertTrue("l".equals(pinArrry[i].getText()));


            //button.perform(click());

            //pinArrry[i].performClick();






    }





}
