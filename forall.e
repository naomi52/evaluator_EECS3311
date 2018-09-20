note
	description: "Summary description for {FORALL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FORALL
inherit
	TERMINALS
feature -- Query
	output: STRING
	do
		Result := "&& "
	end

end
