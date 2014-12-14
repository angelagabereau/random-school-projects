#ifndef NAME_H
#define NAME_H


/*
 *  name.h
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

class Name : public Field 
{
	friend std::istream & operator>>(std::istream & is, Name & name);
public:
	Name();
	Name(std::string des);
	Name(std::string des, std::string d);
	~Name();
	void fillField(std::string s);
};

#endif