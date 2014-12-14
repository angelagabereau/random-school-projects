#ifndef DATE_H
#define DATE_H


/*
 *  date.h
 *  comp446a3
 *
 *  Created by Angela Gabereau on 07/11/06.
 *	ID#: 4867815
 *  COMP 446  
 *  Programming Assignment 3
 *		
 */
#include "field.h"
#include<string>
#include<vector>

class Date : public Field 
{
public:
	Date();
	Date(std::string des);
	Date(std::string des, std::string d);
	~Date();
	void fillField(std::string s);
private:
 std::vector<std::string> months;
};

#endif