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
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;




public class buttonTest {

    //new test: check if buttons are clickable

    //new test: check if buttons are visible



    //check if values will be set correct on button click

    @Test
    public void buttonClickedTest() {


        final Button[] pinArrry = new Button[40];

        for (int i = 0; i < 40; i++) {

            pinArrry[i].setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {


                   v.performClick();

                    if(pinArrry[v.getId()].getText() == "l"){
                        pinArrry[v.getId()].setText("h");
                        assertTrue("h".equals(pinArrry[v.getId()].getText()));

                    } else {
                        pinArrry[v.getId()].setText("l");
                        assertTrue("l".equals(pinArrry[v.getId()].getText()));

                    }

                }
            });

            pinArrry[i].setId(i);

            pinArrry[i].setText("l");

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
