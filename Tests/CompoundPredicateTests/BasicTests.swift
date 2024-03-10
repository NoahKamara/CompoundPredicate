import XCTesting
@testable import CompoundPredicate

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

    @Test
    func nonConforming() async throws {
        struct CustomPredicate: StandardPredicateExpression {
            let variable: PredicateExpressions.Variable<Bool>

            func evaluate(_ bindings: PredicateBindings) throws -> Bool {
                try variable.evaluate(bindings)
            }
        }

        let lhs = Predicate<Bool>({ CustomPredicate(variable: $0) })
        let rhs = Predicate<Bool>({ CustomPredicate(variable: $0) })

        await confirmation(expectedCount: 2) { confirm in
            NotificationCenter.default.addObserver(
                forName: .foundationExtensionsRuntimeWarning,
                object: nil,
                queue: .main
            ) { notification in
                let runtimeWarnMsg = try? #require(notification.userInfo?["message"] as? String)

                guard let runtimeWarnMsg else { return }

                #expect(runtimeWarnMsg.contains("\(CustomPredicate.self) is not a supported Predicate."))

                print("CALLED")
                confirm()
            }
            
            XCTExpectFailure("Cannot combine unsupported Predicate", strict: true)
            _ = [lhs, rhs].disjunction()
        }
    }
}
