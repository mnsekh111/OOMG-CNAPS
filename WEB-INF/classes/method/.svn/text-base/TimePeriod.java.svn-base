package method;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.logging.*;
import util.Global;
import util.Log;

public class TimePeriod  {
	public ArrayList<String> getTimePeriod()
	{
		File dir=new File(Global.figures_location);
		String[] chld=dir.list();
		ArrayList<String> dates=new ArrayList<String>();
		for(String s:chld){
			if (s.startsWith("201")){
				dates.addAll( Arrays.asList(new File(Global.figures_location+s).list()));
			}
		}
		Collections.sort(dates);
		
		return dates;
	}
}
