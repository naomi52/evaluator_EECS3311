note
	description: "Summary description for {OPERATOR_IMPLIES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IMPLICATION
inherit
	TERMINALS
feature -- Query
	output: STRING
	do
		Result := " => "
	end
end
