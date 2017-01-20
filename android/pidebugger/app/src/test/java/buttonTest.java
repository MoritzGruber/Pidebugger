import android.util.Log;
import android.view.View;
import android.widget.Button;

import com.moritzgruber.pidebugger.pidebugger.PiInterfaceActivity;
import com.moritzgruber.pidebugger.pidebugger.R;

import dalvik.annotation.TestTargetClass;

import org.junit.Test;
import java.util.regex.Pattern;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;


public class buttonTest {

    @Test
    public void buttonClickedTest() {


        final Button[] pinArrry = new Button[40];

        for (int i=0; i<40; i++){

            pinArrry[i].setText("l");

            assertTrue("l".equals(pinArrry[i].getText()));

            pinArrry[i].setOnClickListener(new View.OnClickListener() {
               public void performClick() {

                   if (pinArrry[i].getText() == "l") {
                       pinArrry[v.getId()].setText("h");
                   } else {
                       pinArrry[v.getId()].setText("l");
                   }
               }
           });


            pinArrry[i].performClick();

            //pinArrry[i] = new Button();



        }


    }





}
