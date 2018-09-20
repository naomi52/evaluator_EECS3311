
note
	description: "Summary description for {BINARY_OP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_OPERATION

inherit
	COMPOSITE_EXPRESSION

create
	make
feature -- Constructors
	make
	do
		create {ARRAYED_LIST[EXPRESSION]}expression_list.make (0)
		expression_list.extend (create {NULL_EXPRESSION}.make_first)
		create times create divide create plus create minus create op_and
		create op_or create op_equals create op_implies create op_lt create op_gt
		create op_union create op_intersect create op_difference
		create {QUESTION}operator
	end
feature{NONE} -- Attributes
	times : MULTIPLICATION
	divide : DIVIDES
	plus : PLUS
	minus : SUBTRACTION
	op_and :REGULAR_AND
	op_or : REGULAR_OR
	op_equals : EQUAL_TO
	op_implies : IMPLICATION
	op_lt : LESS_THAN
	op_gt : GREATER_THAN
	op_union : UNION
	op_intersect : INTERSECT
	op_difference : DIFFERENCE
feature -- External Attributes Accessible
	operator : TERMINALS

feature -- Query Children
	left : EXPRESSION
	do
		Result := expression_list.at(1).deep_twin
	end

	right : EXPRESSION
	do
		Result := expression_list.at (2).deep_twin
	end


feature -- Command
	add_operation(op : TERMINALS)
		do
			-- LPAREN Expression Operator Expression RPAREN
			expression_list.put_i_th(create {NULL_EXPRESSION}.make_first,1)
			expression_list.extend(create {NULL_EXPRESSION}.make)
			operator := op.deep_twin
		end

feature -- Test visitor pattern
	accept (visitor : VISITOR)

	do
		if operator.output ~ times.output then
			visitor.visit_multiplication (Current.deep_twin)
		elseif operator.output ~ divide.output then
			visitor.visit_division (Current.deep_twin)
		elseif operator.output ~ plus.output then
			visitor.visit_addition (Current.deep_twin)
		elseif operator.output ~ minus.output then
			visitor.visit_subtraction (Current.deep_twin)
		elseif operator.output ~ op_and.output then
			visitor.visit_conjunction (Current.deep_twin)
		elseif operator.output ~ op_or.output then
			visitor.visit_disjunction (Current.deep_twin)
		elseif operator.output ~ op_equals.output then
			visitor.visit_equality (Current.deep_twin)
		elseif operator.output ~ op_implies.output then
			visitor.visit_implication (Current.deep_twin)
		elseif operator.output ~ op_lt.output then
			visitor.visit_less_than (Current.deep_twin)
		elseif operator.output ~ op_gt.output then
			visitor.visit_greater_than (Current.deep_twin)
		elseif operator.output ~ op_union.output then
			visitor.visit_union (Current.deep_twin)
		elseif operator.output ~ op_intersect.output then
			visitor.visit_intersection (Current.deep_twin)
		elseif operator.output ~ op_difference.output then
			visitor.visit_difference (Current.deep_twin)
		end

	end

end

