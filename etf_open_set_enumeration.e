note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_OPEN_SET_ENUMERATION
inherit
	ETF_OPEN_SET_ENUMERATION_INTERFACE
		redefine open_set_enumeration end
create
	make
feature -- command
	open_set_enumeration
    	do
			if model.my_stack.is_empty and not model.is_new then
				model.set_error_message (model.status_completed_exp)
			else
				model.start_set_enumeration
				model.pretty_print
			end
			--model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
