note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_EVALUATE
inherit
	ETF_EVALUATE_INTERFACE
		redefine evaluate end
create
	make
feature -- command
	evaluate
    	do
			model.report.make_empty
    		model.error_message.make_empty
			if not model.no_expression_in_stack or (model.no_expression_in_stack and model.is_new) then
    			model.set_error_message (model.status_incomplete_exp)
				model.report.append (model.print_visitor.value)
    		elseif not model.is_type_correct then
				model.set_error_message(model.status_not_type_correct_evaluate)
			    model.report.append (model.print_visitor.value)
			elseif model.is_divisor_zero then
				model.set_error_message (model.status_divisor_zero)
				model.report.append (model.print_visitor.value)
			else
    			model.evaluate
    		end

			--model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
