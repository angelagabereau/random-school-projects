package angela;

///////////////////////////////////////////////////////////
//Angela Gabereau
//ID# 4867815
//CART 363 - Advanced Languages of Programming
//Assignment 5 - subtle shifts
//April 12, 2007
///////////////////////////////////////////////////////////

import java.util.*;

public class Mutator {

	int x;
	int y;
	int MAX_X;
	int MAX_Y;
	int NUM_LAYERS;
	Random generator = new Random();
	
	public Mutator(int MAX_X, int MAX_Y, int NUM_LAYERS) {
		super();
		this.MAX_X = MAX_X;
		this.MAX_Y = MAX_Y;
		this.NUM_LAYERS = NUM_LAYERS;
		//randomly chose origin of mutator from 0-MAX_X and 0-MAX_Y
		this.x = generator.nextInt(MAX_X);
		this.y = generator.nextInt(MAX_Y);
	}

	
	// this method calcutes the direction of the next step and then takes that step
	public void step(){
		
		//calculate direction of step
		int stepX=1;
		int stepY=1;
		if(generator.nextInt(2)==1)
			stepX=-1;
		if(generator.nextInt(2)==1)
			stepY=-1;
		
		//take step. check that new location is in bounds, if not, throw back into bounds
		x=x+stepX;
		if(x<=0 )
			x=10;
		if(MAX_X<=x)
			x=MAX_X-10;
		y=y+stepY;
		if(y<=0 )
			y=10;
		if(MAX_Y<=y)
			y=MAX_Y-10;
		
		//System.out.println("X: "+x+"  Y: "+y);
		
		return;
	}
	
	
	//this method takes the current pixel info from location of mutator and calculates a new pixel layer for end of mutation.
	public int mutate(int pixel){
		
		//int newPixel = generator.nextInt(NUM_LAYERS);
		int newPixel = Math.abs(pixel % NUM_LAYERS);
		
		return newPixel;
	}


	public int getX() {
		return x;
	}


	public void setX(int x) {
		this.x = x;
	}


	public int getY() {
		return y;
	}


	public void setY(int y) {
		this.y = y;
	}
	
	
	
}
