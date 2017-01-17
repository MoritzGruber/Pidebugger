import com.moritzgruber.pidebugger.pidebugger.PiInterfaceActivity;

import dalvik.annotation.TestTargetClass;

import org.junit.Test;
import java.util.regex.Pattern;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;


public class buttonTest {

    @Test
    public void buttonClickedTest() {

    for (int i=0; i<40; i++){


        PiInterfaceActivity.pinArrry[i].setId(i);

    }


    }


}
