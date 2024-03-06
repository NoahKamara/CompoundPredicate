import XCTest
import InlineSnapshotTesting

final class ReplaceVariableTests: XCTestCase {
    func testComparison() throws {
        let predicate = #Predicate<Person> { $0.age < $0.age }

        let compoundPred = [.true, predicate].conjunction()

        assertInlineSnapshot(of: compoundPred, as: .json(with: .shared)) {
            """
            [
              {
                "expression" : [
                  true,
                  [
                    {
                      "identifier" : "Person.age",
                      "root" : {
                        "key" : 2
                      }
                    },
                    {
                      "identifier" : "Person.age",
                      "root" : {
                        "key" : 2
                      }
                    },
                    {
                      "lessThan" : {

                      }
                    }
                  ]
                ],
                "structure" : {
                  "args" : [
                    {
                      "args" : [
                        "Swift.Bool"
                      ],
                      "identifier" : "PredicateExpressions.Value"
                    },
                    {
                      "args" : [
                        {
                          "args" : [
                            {
                              "args" : [
                                "Foundation.Predicate.Input.0"
                              ],
                              "identifier" : "PredicateExpressions.Variable"
                            },
                            "Swift.Int"
                          ],
                          "identifier" : "PredicateExpressions.KeyPath"
                        },
                        {
                          "args" : [
                            {
                              "args" : [
                                "Foundation.Predicate.Input.0"
                              ],
                              "identifier" : "PredicateExpressions.Variable"
                            },
                            "Swift.Int"
                          ],
                          "identifier" : "PredicateExpressions.KeyPath"
                        }
                      ],
                      "identifier" : "PredicateExpressions.Comparison"
                    }
                  ],
                  "identifier" : "PredicateExpressions.Conjunction"
                },
                "variable" : [
                  {
                    "key" : 2
                  }
                ]
              }
            ]
            """
        }

        XCTAssertNoThrow(try compoundPred.testFetch())
    }

    func testEqual() throws {
        let predicate = #Predicate<Person> { $0.age == $0.age }

        let compoundPred = [.true, predicate].conjunction()

        assertInlineSnapshot(of: compoundPred, as: .json(with: .shared)) {
            """
            [
              {
                "expression" : [
                  true,
                  [
                    {
                      "identifier" : "Person.age",
                      "root" : {
                        "key" : 5
                      }
                    },
                    {
                      "identifier" : "Person.age",
                      "root" : {
                        "key" : 5
                      }
                    }
                  ]
                ],
                "structure" : {
                  "args" : [
                    {
                      "args" : [
                        "Swift.Bool"
                      ],
                      "identifier" : "PredicateExpressions.Value"
                    },
                    {
                      "args" : [
                        {
                          "args" : [
                            {
                              "args" : [
                                "Foundation.Predicate.Input.0"
                              ],
                              "identifier" : "PredicateExpressions.Variable"
                            },
                            "Swift.Int"
                          ],
                          "identifier" : "PredicateExpressions.KeyPath"
                        },
                        {
                          "args" : [
                            {
                              "args" : [
                                "Foundation.Predicate.Input.0"
                              ],
                              "identifier" : "PredicateExpressions.Variable"
                            },
                            "Swift.Int"
                          ],
                          "identifier" : "PredicateExpressions.KeyPath"
                        }
                      ],
                      "identifier" : "PredicateExpressions.Equal"
                    }
                  ],
                  "identifier" : "PredicateExpressions.Conjunction"
                },
                "variable" : [
                  {
                    "key" : 5
                  }
                ]
              }
            ]
            """
        }

        XCTAssertNoThrow(try compoundPred.testFetch())
    }

    func testNotEqual() throws {
        let predicate = #Predicate<Person> { $0.age != $0.age }

        let compoundPred = [.true, predicate].conjunction()

        assertInlineSnapshot(of: compoundPred, as: .json(with: .shared)) {
            """
            [
              {
                "expression" : [
                  true,
                  [
                    {
                      "identifier" : "Person.age",
                      "root" : {
                        "key" : 11
                      }
                    },
                    {
                      "identifier" : "Person.age",
                      "root" : {
                        "key" : 11
                      }
                    }
                  ]
                ],
                "structure" : {
                  "args" : [
                    {
                      "args" : [
                        "Swift.Bool"
                      ],
                      "identifier" : "PredicateExpressions.Value"
                    },
                    {
                      "args" : [
                        {
                          "args" : [
                            {
                              "args" : [
                                "Foundation.Predicate.Input.0"
                              ],
                              "identifier" : "PredicateExpressions.Variable"
                            },
                            "Swift.Int"
                          ],
                          "identifier" : "PredicateExpressions.KeyPath"
                        },
                        {
                          "args" : [
                            {
                              "args" : [
                                "Foundation.Predicate.Input.0"
                              ],
                              "identifier" : "PredicateExpressions.Variable"
                            },
                            "Swift.Int"
                          ],
                          "identifier" : "PredicateExpressions.KeyPath"
                        }
                      ],
                      "identifier" : "PredicateExpressions.NotEqual"
                    }
                  ],
                  "identifier" : "PredicateExpressions.Conjunction"
                },
                "variable" : [
                  {
                    "key" : 11
                  }
                ]
              }
            ]
            """
        }

        XCTAssertNoThrow(try compoundPred.testFetch())
    }
    
    func testVariable() throws {
        let predicate = #Predicate<Person> { $0.isStarred }

        let compoundPred = [.true, predicate].conjunction()

        assertInlineSnapshot(of: compoundPred, as: .json(with: .shared)) {
            """
            [
              {
                "expression" : [
                  true,
                  {
                    "identifier" : "Person.isStarred",
                    "root" : {
                      "key" : 20
                    }
                  }
                ],
                "structure" : {
                  "args" : [
                    {
                      "args" : [
                        "Swift.Bool"
                      ],
                      "identifier" : "PredicateExpressions.Value"
                    },
                    {
                      "args" : [
                        {
                          "args" : [
                            "Foundation.Predicate.Input.0"
                          ],
                          "identifier" : "PredicateExpressions.Variable"
                        },
                        "Swift.Bool"
                      ],
                      "identifier" : "PredicateExpressions.KeyPath"
                    }
                  ],
                  "identifier" : "PredicateExpressions.Conjunction"
                },
                "variable" : [
                  {
                    "key" : 20
                  }
                ]
              }
            ]
            """
        }

        XCTAssertNoThrow(try compoundPred.testFetch())
    }

    func testNegation() throws {
        let predicate = #Predicate<Person> { !$0.isStarred }

        let compoundPred = [.true, predicate].conjunction()

        assertInlineSnapshot(of: compoundPred, as: .json(with: .shared)) {
            """
            [
              {
                "expression" : [
                  true,
                  {
                    "identifier" : "Person.isStarred",
                    "root" : {
                      "key" : 8
                    }
                  }
                ],
                "structure" : {
                  "args" : [
                    {
                      "args" : [
                        "Swift.Bool"
                      ],
                      "identifier" : "PredicateExpressions.Value"
                    },
                    {
                      "args" : [
                        {
                          "args" : [
                            {
                              "args" : [
                                "Foundation.Predicate.Input.0"
                              ],
                              "identifier" : "PredicateExpressions.Variable"
                            },
                            "Swift.Bool"
                          ],
                          "identifier" : "PredicateExpressions.KeyPath"
                        }
                      ],
                      "identifier" : "PredicateExpressions.Negation"
                    }
                  ],
                  "identifier" : "PredicateExpressions.Conjunction"
                },
                "variable" : [
                  {
                    "key" : 8
                  }
                ]
              }
            ]
            """
        }

        XCTAssertNoThrow(try compoundPred.testFetch())
    }
    
    func testSequenceContains() throws {
        let predicate = #Predicate<Person> { ["John", "James"].contains($0.firstName) }

        let compoundPred = [.true, predicate].conjunction()

        assertInlineSnapshot(of: compoundPred, as: .json(with: .shared)) {
            """
            [
              {
                "expression" : [
                  true,
                  [
                    [
                      "John",
                      "James"
                    ],
                    {
                      "identifier" : "Person.firstName",
                      "root" : {
                        "key" : 14
                      }
                    }
                  ]
                ],
                "structure" : {
                  "args" : [
                    {
                      "args" : [
                        "Swift.Bool"
                      ],
                      "identifier" : "PredicateExpressions.Value"
                    },
                    {
                      "args" : [
                        {
                          "args" : [
                            {
                              "args" : [
                                "Swift.String"
                              ],
                              "identifier" : "Swift.Array"
                            }
                          ],
                          "identifier" : "PredicateExpressions.Value"
                        },
                        {
                          "args" : [
                            {
                              "args" : [
                                "Foundation.Predicate.Input.0"
                              ],
                              "identifier" : "PredicateExpressions.Variable"
                            },
                            "Swift.String"
                          ],
                          "identifier" : "PredicateExpressions.KeyPath"
                        }
                      ],
                      "identifier" : "PredicateExpressions.SequenceContains"
                    }
                  ],
                  "identifier" : "PredicateExpressions.Conjunction"
                },
                "variable" : [
                  {
                    "key" : 14
                  }
                ]
              }
            ]
            """
        }

        XCTAssertNoThrow(try compoundPred.testFetch())
    }

    func testSequenceStartsWith() throws {
        let predicate = #Predicate<Person> { $0.firstName.starts(with: "J") }

        let compoundPred = [.true, predicate].conjunction()

        assertInlineSnapshot(of: compoundPred, as: .json(with: .shared)) {
            """
            [
              {
                "expression" : [
                  true,
                  [
                    {
                      "identifier" : "Person.firstName",
                      "root" : {
                        "key" : 17
                      }
                    },
                    "J"
                  ]
                ],
                "structure" : {
                  "args" : [
                    {
                      "args" : [
                        "Swift.Bool"
                      ],
                      "identifier" : "PredicateExpressions.Value"
                    },
                    {
                      "args" : [
                        {
                          "args" : [
                            {
                              "args" : [
                                "Foundation.Predicate.Input.0"
                              ],
                              "identifier" : "PredicateExpressions.Variable"
                            },
                            "Swift.String"
                          ],
                          "identifier" : "PredicateExpressions.KeyPath"
                        },
                        {
                          "args" : [
                            "Swift.String"
                          ],
                          "identifier" : "PredicateExpressions.Value"
                        }
                      ],
                      "identifier" : "PredicateExpressions.SequenceStartsWith"
                    }
                  ],
                  "identifier" : "PredicateExpressions.Conjunction"
                },
                "variable" : [
                  {
                    "key" : 17
                  }
                ]
              }
            ]
            """
        }

        XCTAssertNoThrow(try compoundPred.testFetch())
    }

    
//    func test2() throws {
//        let predicate = #Predicate<Person> { $0.firstName.reversed().starts(with: "J") }
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        assertInlineSnapshot(of: compoundPred, as: .json(with: .shared))
//
//        XCTAssertNoThrow(try compoundPred.testFetch())
//    }

    func template() throws {
        let predicate = #Predicate<Person> { $0.firstName == "" }

        let compoundPred = [.true, predicate].conjunction()

        assertInlineSnapshot(of: compoundPred, as: .json(with: .shared))

        XCTAssertNoThrow(try compoundPred.testFetch())
    }
}
