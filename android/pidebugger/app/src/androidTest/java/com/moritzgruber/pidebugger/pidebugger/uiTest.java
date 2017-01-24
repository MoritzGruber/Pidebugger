package com.moritzgruber.pidebugger.pidebugger;

import android.support.test.uiautomator.By;
import android.support.test.uiautomator.UiDevice;
import android.support.test.uiautomator.UiObject2;
import android.support.test.uiautomator.Until;
import android.test.InstrumentationTestCase;
import android.view.View;
import android.widget.Button;


public class uiTest extends InstrumentationTestCase {


    private UiDevice device;

    @Override
    public void setUp() throws Exception {
        super.setUp();

        device = UiDevice.getInstance(getInstrumentation());

        /*
        device.pressHome();
        device.wait(Until.hasObject(By.desc("Apps")), 3000);
        Object piDebugger = device.findObject(By.text("piDebugger2"));
        */

    }


    public void uiTesting() throws Exception {

        UiObject2 skipbtn = device.findObject(By.text("Skip"));
        skipbtn.click();

    }


}
