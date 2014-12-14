///////////////////////////////////////////////////////////
//	Angela Gabereau
//	ID# 4867815
//	CART 363 - Advanced Languages of Programming
//	Assignment 3 - L-Systems
///////////////////////////////////////////////////////////




import java.io.*;
import java.util.*;

public class main {
	
//this method creates the LSys object specified  by command line arguments.

public static void main(String[] args) {
	 
	 if(args.length==1 || args.length==2){

	//PART D
	//GENERATE L-SYSTEMS

	//example of command line format:
	 // java JohnnyA3 -random [FILENAME]
	 // java JohnnyA3 -symmetric [FILENAME]
	 // java JohnnyA3 -exponential [FILENAME]
		 
		 //get the name of file in which generated L-System will be saved.

		 String fileName;

		 if(args.length==1){
 
			// no filename given so create a filename using system time to create filename

			
			fileName = System.currentTimeMillis() + ".txt";

		 } else{
		
			// use file name given at command line

			 fileName = args[1];
		 }

		 LSys lsys = new LSys(fileName, "a");
		 
		 //generated L-System according to mode specified in command line
		
		 if(args[0].equals("-random")){

			 lsys.GenerateRandomLSys();

		 }else if(args[0].equals("-symmetric")){

			 lsys.GenerateSymmetricLSys();

		 }else if(args[0].equals("-exponential")){

			 lsys.GenerateExponentialLSys();
		 }else{
			 System.out.println(args[0] + " Incorrect arguments given at command line");
		 }

	 }else if(args.length==3){

	//APPLY L-SYSTEM GIVEN AT COMMAND LINE TO STRING GIVEN AT COMMAND LINE, TO SPECIFIED DEPTH.

		 //example of command line format:
		 // java JohnnyA3 ex2.lsys a 6

		 LSys lsys = new LSys(args[0], args[1], Integer.valueOf( args[2] ).intValue());

		//PART A
		//open and parse external file containing L-System.
		 lsys.GetLSys(); 

		//PART B
		//display L-System.
	    	 lsys.DisplayLSys();

		//PART C
		//apply L-System to axiom.
	     lsys.Produce();
		 
	 }else{
		 System.out.println("Incorrect arguments given at command line");
	 }
	 }}


