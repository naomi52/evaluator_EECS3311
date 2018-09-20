note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_FOR_ALL
inherit
	ETF_FOR_ALL_INTERFACE
		redefine for_all end
create
	make
feature -- command
	for_all
    	do
			if model.my_stack.is_empty and not model.is_new then
				model.set_error_message (model.status_completed_exp)
			else
				model.add_generalized_and
				model.pretty_print
			end
			--model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
