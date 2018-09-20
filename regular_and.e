note
	description: "Summary description for {OPERAND_AND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REGULAR_AND
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := " && "
	end

end
