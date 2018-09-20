note
	description: "Summary description for {OPERATOR_EQUAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQUAL_TO
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := " = "
	end
end
