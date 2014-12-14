/*
 *  field.cpp
 *  comp446a3
 *
 *  Created by Angela Gabereau on 06/11/06.
 *	ID#: 4867815
 *  COMP 446  
 *  Programming Assignment 3
 *
 */

#include "field.h"
#include<string>
#include<iostream>

using namespace std;

Field::Field()
{ 
	cout<<"Construct Field"<<endl;
}

Field::~Field()
{ 
	cout<<"Delete Field"<<endl;
}

string Field::showField()
{

	return (description + " = " + data);

} 

void Field::setDescription(std::string des)
{
	description = des;
	return;
}


void Field::setData(std::string d)
{
	
	data = d;
	return;
}

string Field::getDescription() const
{
	return description;
}
	
string Field::getData() const
{
	return data;
}