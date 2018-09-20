
note
	description: "Summary description for {UNARY_OP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNARY_OPERATION

inherit
	COMPOSITE_EXPRESSION

create
	make
feature -- Constructor
	make
	do
		create {ARRAYED_LIST[EXPRESSION]}expression_list.make (0)
		expression_list.extend (create {NULL_EXPRESSION}.make_first)
		create negative create negation create sum create for_all create exists
		create {QUESTION}operator
	end
feature{NONE} -- Internal attributes
	negative : NEGATIVE
	negation : NEGATION
	sum      : SUM
	for_all  : FORALL
	exists   : EXISTS
feature -- Attributes

	child : EXPRESSION
	do
		Result := expression_list.at (1).deep_twin
	end

	operator : TERMINALS

feature -- Commands
	add_operation(symb : TERMINALS)
		do
			-- LPAREN Operator Expression RPAREN
			--expression_list.extend(op)
			expression_list.put_i_th(create {NULL_EXPRESSION}.make_first,1)
			operator := symb.deep_twin
		end

feature -- check visitor pattern
	accept (visitor : VISITOR)
	do
		if operator.output ~ negative.output then
			visitor.visit_negative (Current.deep_twin)
		elseif operator.output ~ negation.output then
			visitor.visit_negation (Current.deep_twin)
		elseif operator.output ~ sum.output then
			visitor.visit_sum (Current.deep_twin)
		elseif operator.output ~ for_all.output then
			visitor.visit_generalized_and (Current.deep_twin)
		elseif operator.output ~ exists.output then
			visitor.visit_generalized_or (Current.deep_twin)
		end

	end

end
