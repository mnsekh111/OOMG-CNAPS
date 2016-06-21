package unitTest;


import util.RandomID;

public class Random {

	public void testGetID() {
		for(int i=0;i<20;i++){
			System.out.println(RandomID.getID());
		}
	}

}
