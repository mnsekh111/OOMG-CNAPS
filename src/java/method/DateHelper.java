/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package method;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

/**
 *
 * @author mns
 */
public class DateHelper {

    public static String prevDateString(Date d) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);
        //subtracting a day
        cal.add(Calendar.DATE, -1);

        SimpleDateFormat s = new SimpleDateFormat("yyyyMMdd");
        String result = s.format(new Date(cal.getTimeInMillis()));
        return result;
    }

    //In the format yyyyMMdd
    public static String prevDateString(String date) throws ParseException {
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd", Locale.ENGLISH);
        Date dt = format.parse(date);
        return prevDateString(dt);
    }

    public static void main(String[] args) throws ParseException {
        System.out.println(DateHelper.prevDateString("20160815"));
        
    }
}
