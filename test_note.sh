#!/bin/bash

NOTES_FILE="notes.txt"
TEST_FILE="test_output.txt"
TEST_FAILED=0

run_test() {
    local description="$1"
    local command="$2"
    local expected_output="$3"

    echo "Running test: $description"
    echo "Command: $command"
    echo "Expected output: $expected_output"
    eval "$command" > $TEST_FILE 2>&1

    if grep -q "$expected_output" $TEST_FILE; then
        echo "Test passed"
    else
        echo "Test failed"
        echo "Actual output:"
        cat $TEST_FILE
        TEST_FAILED=1
    fi

    echo
}

test_add_note_with_special_characters() {
    run_test "Add note with special characters" \
        "./note.sh add 'Note with special characters !@#$%^&*()'" \
        "Note added successfully"
}

test_list_notes_after_adding() {
    run_test "List notes after adding" \
        "./note.sh add 'First note'; ./note.sh list" \
        "First note"
}

test_check_date_time_format() {
    run_test "Check date/time format" \
        "./note.sh add 'Check date format'; ./note.sh list" \
        "$(date +%Y-%m-%d)"
}

test_search_notes() {
    run_test "Search notes" \
        "./note.sh add 'Searchable note'; ./note.sh search 'Searchable'" \
        "Searchable note"
}

# Clean up before tests
rm -f $NOTES_FILE $TEST_FILE

if [ "$1" ]; then
    case "$1" in
        test_add_note_with_special_characters) test_add_note_with_special_characters ;;
        test_list_notes_after_adding) test_list_notes_after_adding ;;
        test_check_date_time_format) test_check_date_time_format ;;
        test_search_notes) test_search_notes ;;
        *) echo "Invalid test name"; exit 1 ;;
    esac
else
    # Run all tests
    test_add_note_with_special_characters
    test_list_notes_after_adding
    test_check_date_time_format
    test_search_notes
fi

# Clean up after tests
rm -f $NOTES_FILE $TEST_FILE

# Return proper exit code
exit $TEST_FAILED
