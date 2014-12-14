/*
 *  date.cpp
 *  comp446a3
 *
 *  Created by Angela Gabereau on 07/11/06.
 *	ID#: 4867815
 *  COMP 446  
 *  Programming Assignment 3
 *
 */

#include "date.h"

#include<string>
#include<iostream>
#include<vector>
#include<cctype>
#include<algorithm>
#include <sstream>


using namespace std;

	/*
	Date::months.push_back("January");
	Date::months.push_back("February");
	Date::months.push_back("March");
	Date::months.push_back("April");
	Date::months.push_back("May");
	Date::months.push_back("June");
	Date::months.push_back("July");
	Date::months.push_back("August");
	Date::months.push_back("September");
	Date::months.push_back("October");
	Date::months.push_back("November");
	Date::months.push_back("December");
	*/


Date::Date() : Field() 
{ 
	cout<<"Construct Date"<<endl; 
	setDescription("Date");
	Date::months.push_back("January");
	Date::months.push_back("February");
	Date::months.push_back("March");
	Date::months.push_back("April");
	Date::months.push_back("May");
	Date::months.push_back("June");
	Date::months.push_back("July");
	Date::months.push_back("August");
	Date::months.push_back("September");
	Date::months.push_back("October");
	Date::months.push_back("November");
	Date::months.push_back("December");
}
	
Date::Date(string des) : Field() 
{ 
	cout<<"Construct Date"<<endl; 
	setDescription(des);
	Date::months.push_back("January");
	Date::months.push_back("February");
	Date::months.push_back("March");
	Date::months.push_back("April");
	Date::months.push_back("May");
	Date::months.push_back("June");
	Date::months.push_back("July");
	Date::months.push_back("August");
	Date::months.push_back("September");
	Date::months.push_back("October");
	Date::months.push_back("November");
	Date::months.push_back("December");
}
	
Date::Date(string des, string d) : Field() 
{ 
	cout<<"Construct Date"<<endl; 
	setDescription(des); 
	setData(d);
	Date::months.push_back("January");
	Date::months.push_back("February");
	Date::months.push_back("March");
	Date::months.push_back("April");
	Date::months.push_back("May");
	Date::months.push_back("June");
	Date::months.push_back("July");
	Date::months.push_back("August");
	Date::months.push_back("September");
	Date::months.push_back("October");
	Date::months.push_back("November");
	Date::months.push_back("December");
}
	
Date::~Date()
{ 
	cout<<"Deleted Date"<<endl;
}


void Date::fillField(string s){//may want to check if field is empty before filling it

	string data;
	stringstream ss(s);
	int day;
	int month;
	int year;
	
	string monthName;
	
	//check if string is empty
	if ( s.empty()){
	
		setData("\n \t No date was entered\t");
		return;
	}

	for( string::iterator it = s.begin(); it != s.end() ; ++it){
	
		//if the current char is not a valid char then send error message
		if( !( isdigit(*it) || isspace(*it))) {
		
			setData("\n \tIllegal characters in date\n");
			return;
		}

	}


	//parse input string into int variables
     ss >> day >> month >> year;

	//check day
	if(!(1<=day && day<=31)){
		setData("\n \t Illegal day in date \n");
		return;
	}
	
	//check month
	if(!(1<=month && month<13)){
		setData("\n \t Illegal month in date \n");
		return;
	}
	
	//get month name string from months
	monthName = Date::months[month-1];

	
	//check year
	if ( 0<=year && year<=99){
		year+=2000; 
	 
	} else if  (!(1800<=year)){
	
		//if year is not between 1800 and 1999 it is invalid
		setData("\n \t Illegal year in date \n");
		return;
	}
	
	//at this point all data has been varified, so build data string

	ostringstream buffer;
	buffer << day << " " << monthName << " " << year;

	//store string
	setData(buffer.str()); 
	return;
}
