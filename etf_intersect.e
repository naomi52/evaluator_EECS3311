note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_INTERSECT
inherit
	ETF_INTERSECT_INTERFACE
		redefine intersect end
create
	make
feature -- command
	intersect
    	do
			if model.my_stack.is_empty and not model.is_new then
				model.set_error_message (model.status_completed_exp)
			else
				model.add_intersection
				model.pretty_print
			end
			--model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
