/*
 *  name.cpp
 *  comp446a3
 *
 *  Created by Angela Gabereau on 07/11/06.
 *	ID#: 4867815
 *  COMP 446  
 *  Programming Assignment 3
 *
 
	are any assertions necessary?
 */

#include "name.h"

#include<string>
#include<iostream>
#include<cctype>

using namespace std;

Name::Name() : Field() 
{ 
	cout<<"Construct Name"<<endl; 
	setDescription("Name");
}
	
Name::Name(std::string des) : Field() 
{ 
	cout<<"Construct Name"<<endl; 
	setDescription(des); 
}
	
Name::Name(std::string des, std::string d) : Field() 
{ 
	setDescription(des); 
	setData(d); 
}
	
Name::~Name()
{ 
	cout<<"Deleted Name"<<endl;
}


void Name::fillField(string s){//may want to check if field is empty before filling it

	//check if string is empty
	if ( s.empty()){
	
		setData("\n \t No name was entered\n");
		return;
	}
	
	//check each char in string  to ensure all chars are legal
	//legal characters are: letters, period, comma, hyphen, apostrophe, blank
	
	for( string::const_iterator it = s.begin(); it != s.end() ; ++it){
	
		//if the current char is not a valid char then send error message, inout empty string into data and return
		if( !( isalpha(*it) || *it == '.' || *it == ',' || *it == '-' || *it == '\'' || isspace(*it) ) ) {
		
			
			setData("\n \t Illegal characters in name \n");
			return;
		}
	}
	
	//store string
	setData(s); 
	return;
}

