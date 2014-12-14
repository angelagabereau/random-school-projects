#ifndef AMOUNT_H
#define AMOUNT_H



/*
 *  amount.h
 *  comp446a3
 *
 *  Created by Angela Gabereau on 07/11/06.
 *	ID#: 4867815
 *  COMP 446  
 *  Programming Assignment 3
 *		
		Amount
		 amount digit string int or long d.c 0<=c<=99 
		 Illegal amount
 
 */
#include "field.h"

class Amount : public Field 
{

public:
	Amount();
	Amount(std::string des);
	Amount(std::string des, std::string d);
	~Amount();	
	void fillField(std::string s);
private:
	long d;
	long c;
};

#endif