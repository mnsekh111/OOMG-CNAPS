package util;

import java.io.IOException;
import java.util.logging.FileHandler;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Log {

    private static Logger logger;
    private static FileHandler fh;

    public Log() {
        if (logger == null) {
            logger = Logger.getLogger(util.Log.class.getName());
            try {
                fh = new FileHandler(Global.Log_file_path);
            } catch (SecurityException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            logger.addHandler(fh);
            logger.setLevel(Level.ALL);
        }
    }

    public void log(String msg) {
        logger.log(Level.ALL, msg);
    }

}
