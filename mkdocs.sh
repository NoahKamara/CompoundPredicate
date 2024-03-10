#
#swift package --allow-writing-to-directory ./docs \
#    generate-documentation --target XCTesting --output-path ./docs


swift package --allow-writing-to-directory ./Documentation.doccarchive \
    generate-documentation \
        --target CompoundPredicate \
        --disable-indexing \
        --transform-for-static-hosting \
        --output-path ./Documentation.doccarchive \
        --hosting-base-path "/CompoundPredicate"
