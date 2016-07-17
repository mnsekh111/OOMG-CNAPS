package util;

public class TimeFormat {

    static public String mmddyyy2yyymmdd(String date) {
        return date.substring(6, 10) + date.substring(0, 2) + date.substring(3, 5);
    }

    static public String yyyymmdd2mmddyyy(String date) {
        return date.subSequence(4, 6) + "/" + date.substring(6, 8) + "/" + date.substring(0, 4);
    }
}
