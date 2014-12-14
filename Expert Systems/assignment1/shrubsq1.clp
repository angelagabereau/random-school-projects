(defrule french-hydrangea
	(or (characteristics shade)
		(characteristics city)
		(characteristics pot)
		(characteristics grows-fast)
	)
	=>
	(printout t "French hydrangea" crlf)
)
(defrule oleander
	(or (characteristics city)
		(characteristics pot)
		(characteristics easy-care)
		(characteristics grows-fast)
	)
	=>
	(printout t "Oleander" crlf)
)
(defrule northern-bayberry
	(or (characteristics cold)
		(characteristics shade)
		(characteristics drought)
		(characteristics wet-soil)
		(characteristics city)
		(characteristics easy-care)
		(characteristics grows-fast)
	)
	=>
	(printout t "Northern bayberry" crlf)
)
(defrule box-honeysuckle
	(or (characteristics city)
		(characteristics pot)
		(characteristics easy-care)
		(characteristics grows-fast)
	)
	=>
	(printout t "Box Honeysuckle" crlf)
)
(defrule gardenia
	(or (characteristics shade)
		(characteristics acid-soil)
		(characteristics pot)
	)
	=>
	(printout t "Gardenia" crlf)
)
(defrule common-juniper
	(or (characteristics cold)
		(characteristics drought)
		(characteristics acid-soil)
		(characteristics city)
		(characteristics easy-care)
	)
	=>
	(printout t "Common Juniper" crlf)
)
(defrule sweet-pepperbush
	(or 
	(characteristics cold)
	(characteristics shade)
	(characteristics wet-soil)
	(characteristics acid-soil)
	(characteristics easy-care)
	)
	=>
	(printout t "Sweet pepperbush" crlf)
)
(defrule tartian-dogwood
	(or 
	(characteristics cold)
	(characteristics shade)
	(characteristics wet-soil)
	(characteristics city)
	(characteristics easy-care)
	)
	=>
	(printout t "Tartian dogwood" crlf)
)
(defrule japanese-aucuba
	(or (characteristics shade)
		(characteristics drought)
		(characteristics pot)
		(characteristics easy-care)
	)
	=>
	(printout t "Japanese aucuba" crlf)
)
(defrule swamp-azalea
	(or (characteristics shade)
		(characteristics wet-soil)
		(characteristics acid-soil)
		(characteristics pot)
	)
	=>
	(printout t "Swamp azalea" crlf)
)

(assert (characteristics shade))