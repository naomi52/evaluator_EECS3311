note
	description: "Summary description for {INTERSECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INTERSECT
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := " /\ "
	end

end
