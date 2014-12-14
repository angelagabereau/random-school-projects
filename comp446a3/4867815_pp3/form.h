#ifndef FORM_H
#define FORM_H


/*
 *  form.h
 *  comp446a3
 *
 *  Created by Angela Gabereau on 06/11/06.
 *  Copyright 2006 __MyCompanyName__. All rights reserved.
 *
 */
#include "field.h"
#include "name.h"
#include "amount.h"
#include "date.h"
#include <string>
#include <vector>
#include <iostream>

class Form
{
	friend std::ostream & operator<<(std::ostream & os, const Form  & form);
	friend std::istream & operator>>(std::istream & is, Form & form);

public:
	Form();
	Form(const Form & other);
	~Form();
	//Form & operator=(const Form &other);
	void addField(Field * field);
private:
	//some data structure to keep the fields, perhaps a vector of pointers
	std::vector<Field*>::iterator it;  
	std::vector<Field*> vField;

};



#endif