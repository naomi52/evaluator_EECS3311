note
	description: "Summary description for {OPERATOR_LT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LESS_THAN
inherit
TERMINALS
feature -- Query
	output: STRING
	do
		Result := " < "
	end
end
