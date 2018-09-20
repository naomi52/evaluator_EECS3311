note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_IMPLY
inherit
	ETF_IMPLY_INTERFACE
		redefine imply end
create
	make
feature -- command
	imply
    	do
			if model.my_stack.is_empty and not model.is_new then
				model.set_error_message (model.status_completed_exp)
			else
				model.add_implication
				model.pretty_print
			end
			--model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
