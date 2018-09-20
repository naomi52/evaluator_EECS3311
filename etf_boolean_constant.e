note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_BOOLEAN_CONSTANT
inherit
	ETF_BOOLEAN_CONSTANT_INTERFACE
		redefine boolean_constant end
create
	make
feature -- command
	boolean_constant(c: BOOLEAN)
    	do
			if model.my_stack.is_empty and not model.is_new then
				model.set_error_message (model.status_completed_exp)
			else
				model.add_boolean_constant(c)
				model.set_error_message (model.status_ok)
				model.pretty_print
			end

			--model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
