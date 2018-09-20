note
	description: "Summary description for {OPERAND_OR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REGULAR_OR
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := " || "
	end

end
