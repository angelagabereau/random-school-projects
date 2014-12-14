/*
 *  form.cpp
 *  comp446a3
 *
 *  Created by Angela Gabereau on 06/11/06.
 *  Copyright 2006 __MyCompanyName__. All rights reserved.
 * 
 */

#include "form.h"

#include <vector>
#include <string>
#include <iostream>

using namespace std;


Form::Form()
{
	cout<<"Construct Form"<<endl;
}

Form::Form(const Form & other) : it(other.it), vField(other.vField)//not sure about the pointers
{	
	//
}

Form::~Form()
{/*
	cout<<"Construct Form"<<endl; 
	delete [] Form::vField;//see if this works otherwise delet each *Field seperately 
	delete Form::it;*/
}

/*
Form::Form & operator=(const Form &other)
{
	if (this == &other)
		return *this;
	Form::vField = other.vField;//this may not work because of pointers
	Form::it = other.it;
	return *this;
}
*/

void Form::addField(Field * field)
{	 

	Form::vField.push_back(field);
	return;
}

ostream & operator<<(ostream & os, const Form & form)
{

	for( vector<Field*>::const_iterator it = form.vField.begin(); it != form.vField.end(); ++it){
		os<<(*it)->getDescription()<<" = "<<(*it)->getData()<<endl;
	}
	return os;

}

istream & operator>>(istream & is, Form & form)
{
	//fill all fields in form
	string s;
	int  count = 0;

	for( vector<Field*>::iterator it = form.vField.begin(); it != form.vField.end(); ++it){
	
	cout << (*it)->getDescription() << " : ";
	
	getline(is,s);
	
	//if(count==0)
		is.ignore();
	(*it)->fillField(s);
	count++;
	is.clear();

	}
	
	return is;

}

