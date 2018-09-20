note
	description: "Summary description for {OPERAND_SUM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUM
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := "+ "
	end
end
