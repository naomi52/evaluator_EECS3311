note
	description: "Summary description for {NEGATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEGATION
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := "! "
	end
end
