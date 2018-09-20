note
	description: "Summary description for {OPERATOR_GT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GREATER_THAN
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := " > "
	end

end
