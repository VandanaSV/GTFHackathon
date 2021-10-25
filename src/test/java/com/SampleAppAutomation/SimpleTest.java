package com.SampleAppAutomation;

import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;



import static org.junit.Assert.assertEquals;

public class SimpleTest  {


    /**
     * Simple Test case annotating JUnit Test
     * @throws Exception
     */
    @Test

    public void test() throws Exception {
            ChromeOptions options = new ChromeOptions();
            options.addArguments("--no-sandbox", "--disable-dev-shm-usage","--headless");
            WebDriver driver= new ChromeDriver(options);
            driver.get("http://localhost:8080/");
            Thread.sleep(5000);
            assertEquals("Hotel Pink Flamingos", driver.getTitle());
            //Commented
            /*
            //clicks on guests button
            driver.findElement(By.xpath("/html/body/div/a[1]")).click();
            Thread.sleep(2000);
            driver.navigate().back();

            */
            //Commented
            Thread.sleep(2000);
            //Clicks on the reservation button
            driver.findElement(By.xpath("/html/body/div/a[2]")).click();
            driver.quit();
    }



}
