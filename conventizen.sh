#!/bin/bash


# Stores the params passed to the script.
PARAMS=($@)

# Stores the acceptable options for the commandline params.
TYPES=(
    "help h --help -h"
    "feat fe --feat -fe"
    "fix fi --fix -fi"
    "docs d --docs -d"
    "style s --style -s"
    "refactor r --refactor -r"
    "perf p --perf -p"
    "test t --test -t"
    "chore c --chore -c"
)

# Tries to match the passed type with the defined ones on full-name and alias and returns the matching one.
function matchType () {

    local possibleType="$1"
    local matchedType=""

    # Loop through the defined acceptable arguments and try to match one
    # of their variants with the given argument.
    for type in "${TYPES[@]}"
    do
        local typeAliases=($type)

        for alias in ${typeAliases[@]}
        do
            if [ "$alias" = "$possibleType" ] ; then
                matchedType=${typeAliases[0]}
                break
            fi
        done

        if [ "$matchedType" != "" ] ; then
            break
        fi

    done

    echo "$matchedType"
}


# Returns the usage information and commit types allowed or a cheeky answer.
function getTherapy () {

    local switch="$1"

    if [ $switch -eq 0 ] ; then
        echo "Need some help? I am not a doctor. Get the help you need from --help."
    elif [ $switch -eq 1 ] ; then
        echo "Commits the changed files to the GH repo using a simple conventional commit style."
        echo "Usage:"
        echo "  bash conventizen.sh [commit_type (required)] [scope (optional)]"
        echo "Accepted commit type arguments:"
        for type in "${TYPES[@]}"
        do
            echo "  $type"
        done
    fi

    exit 1
}


# The main function that processes the arguments and decides which action to take.
function main () {

    # NOTE I have to consider git commit passable arguments as well.

    local len=${#PARAMS[@]}
    
    # At least one argument is required to work properly.
    if [ $len -eq 0 ] ; then
        echo "Not enough parameters."
        getTherapy 0
    # A maximum of 2 arguments are currently accepted.
    elif [ $len -gt 2 ] ; then
        echo "Too many parameters."
        getTherapy 0
    else
        # Try to match the type and decide the correct action .        
        local matchedType=$(matchType ${PARAMS[0]})

        # No match.
        if [ "$matchedType" = "" ] ; then
            echo "Parameter '${PARAMS[0]}' is not at valid commit type or commit type alias."
            exit 1
        # Matched on the help argument or one of its variants.
        elif [ "$matchedType" = "help" ] ; then
            getTherapy 1
        # Matched on a specific commit type or one of its variants.
        else
            local scope=""

            # echo "Commit Type: $matchedType."
            
            # If a 2nd parameter has been submitted, treat is the scope.
            if [ $len -eq 2 ] ; then
                scope="(${PARAMS[1]})"
                # echo "Scope: ${PARAMS[1]}."
            fi

            echo -n "$matchedType$scope: "
            read commitMsg

            # Run the final git commit command.
            git commit -a -m "$matchedType$scope: $commitMsg"
        fi
    fi
}

main