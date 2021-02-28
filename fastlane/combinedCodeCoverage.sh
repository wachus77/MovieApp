#!/bin/bash

# The script is meant to be run after all code coverage reports have been copied
# Reports are copied individually after each line execution to ~/code_coverage/movie_app/

# Expected minimum total coverage
MIN_COVERAGE=$1

echo "Removing previous merged xcresult files if exists"
rm -r ~/code_coverage/movie_app/Merged.xcresult
FILENAMES=()

# Add new element at the end of the array
echo "Mapping xcresult files from coverage directory to contain correct path"
echo ""
for filename in $(ls ~/code_coverage/movie_app/)
do 
    FILENAMES+=$(echo ~/code_coverage/movie_app/)$filename' '
done 

echo "Merging result files into Merged.xcresult"
xcrun xcresulttool merge ${FILENAMES} --output-path ~/code_coverage/movie_app/Merged.xcresult
xcrun xccov view --report --only-targets ~/code_coverage/movie_app/Merged.xcresult
COVERAGE=$(xcrun xccov view --report --only-targets --json ~/code_coverage/movie_app/Merged.xcresult | jq '[.[] | .lineCoverage]' | jq 'reduce .[] as $num (0; .+$num)')
RESULT=$(printf %.0f $(echo "$COVERAGE*100/4" | bc))

echo "Total code coveraged: "$RESULT"%, expected at least: "$MIN_COVERAGE"%"

if [ $RESULT -ge $MIN_COVERAGE ]
then
    exit 0
else
    exit 1
fi
