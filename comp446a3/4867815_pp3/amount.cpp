/*
 *  amount.cpp
 *  comp446a3
 *
 *  Created by Angela Gabereau on 07/11/06.
 *	ID#: 4867815
 *  COMP 446  
 *  Programming Assignment 3
 *
 */

#include "amount.h"
#include<string>
#include<iostream>
#include<cctype>
#include<algorithm>
#include <sstream>

using namespace std;

Amount::Amount() : Field(), d(0), c(0)
{ 
	cout<<"Construct Amount"<<endl; 
	setDescription("Amount");
}
	
Amount::Amount(std::string des) : Field(), d(0), c(0) 
{ 
	setDescription(des); 
}
	
Amount::Amount(string des, string data) : Field(), d(0), c(0) 
{ 
	setDescription(des); 
	setData(data); 
}
	
Amount::~Amount()
{ 
	cout<<"Deleted Amount"<<endl;
}


void Amount::fillField(string s){//may want to check if field is empty before filling it

	//check if string is empty
	if ( s.empty()){
	
		setData("\n \t No amount was entered\n");
		return;
	}
	

	for( string::iterator it = s.begin(); it != s.end() ; ++it){
	
		//if the current char is not a valid char then send error message
		if( !( isdigit(*it) || *it=='.')) {
		
			setData("\n \t Illegal characters in amount \n");
			return;
		}

		//change period to space
		if (*it=='.')
			*it=' ';
	}


	//parse input string with string stream
	stringstream ss(s);
	ss >> Amount::d >> Amount::c;
	
	//check that c is within range
	
	if(!(0<=c && c<=99)){
		setData("\n \t Illegal cents in amount \n"); 
		return;
	}
	
	//construct string
	//string a = Amount::d + "." + Amount::c;
	ostringstream buffer;
	buffer <<Amount::d<<"."<< Amount::c ;

	//store string
	setData(buffer.str()); 
	return;
}

