import XCTesting

@XCTesting
@Suite
struct BasicTests {
    @Test
    func value() throws {
        let value = PredicateExpressions.build_Arg(true)
        let variable = PredicateExpressions.Variable<Bool>()
        let replacement = PredicateExpressions.Variable<Bool>()

        // Replace LHS
        let identicalValue = value.replacing(variable, with: replacement)
        #expect(identicalValue.value == value.value)
    }

    @Test
    func variable() throws {
        let variable = PredicateExpressions.Variable<Bool>()
        let replacement = PredicateExpressions.Variable<Bool>()

        // Replace LHS
        let variableReplaced = variable.replacing(variable, with: replacement)
        #expect(variableReplaced == replacement)
    }

    @Test
    func arrayConjunction() throws {
        let lhs = #Predicate<Bool> { $0 }
        let rhs = #Predicate<Bool> { $0 }

        let expression = [lhs, rhs].conjunction()

        let variablesAfterReplace = try expression.expression.recursiveVariables()

        let exprVariableKey = try #require(try expression.variableID())
        let lhsVariableKey = try #require(try lhs.variableID())
        let rhsVariableKey = try #require(try rhs.variableID())

        #expect(variablesAfterReplace.contains(exprVariableKey))
        #expect(!variablesAfterReplace.contains(lhsVariableKey))
        #expect(!variablesAfterReplace.contains(rhsVariableKey))
    }

    @Test
    func arrayDisjunction() throws {
        let lhs = #Predicate<Bool> { $0 }
        let rhs = #Predicate<Bool> { $0 }

        let expression = [lhs, rhs].disjunction()

        let variablesAfterReplace = try expression.expression.recursiveVariables()

        let exprVariableKey = try #require(try expression.variableID())
        let lhsVariableKey = try #require(try lhs.variableID())
        let rhsVariableKey = try #require(try rhs.variableID())

        #expect(variablesAfterReplace.contains(exprVariableKey))
        #expect(!variablesAfterReplace.contains(lhsVariableKey))
        #expect(!variablesAfterReplace.contains(rhsVariableKey))
    }

    @Test
    func emptyArray() throws {
        let predicate = [Predicate<Bool>]().conjunction()

        #expect(predicate.expression is PredicateExpressions.Value<Bool>)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        let predicateData = try encoder.encode(predicate.expression)
        let expectedData = try encoder.encode(Predicate<Bool>.true.expression)

        let predicateString = try #require(String(data: predicateData, encoding: .utf8))
        let expectedString = try #require(String(data: expectedData, encoding: .utf8))

        #expect(predicateString == expectedString)
    }
}
