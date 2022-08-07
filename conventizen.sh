#!/bin/bash
# set -x

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


# Returns the usage information and commit types allowed.
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


# function mainProcess () {

# }



function main () {

    # I have to consider git commit passable arguments as well.

    local len=${#PARAMS[@]}
    
    if [ $len -eq 0 ] ; then
        echo "Not enough parameters."
        getTherapy 0
    elif [ $len -gt 2 ] ; then
        echo "UwU, too many parameters."
        getTherapy 0
    else
        # Try to match the type and decide the correct action .        
        local matchedType=$(matchType ${PARAMS[0]})
        if [ "$matchedType" = "" ] ; then
            echo "Parameter '${PARAMS[0]}' is not at valid commit type or commit type alias."
            exit 1
        elif [ "$matchedType" = "help" ] ; then
            getTherapy 1
        else
            local scope=""

            echo "Commit Type: $matchedType."
            
            if [ $len -eq 2 ] ; then
                scope="(${PARAMS[1]})"
                echo "Scope: ${PARAMS[1]}."
            fi

            echo "Enter your commit message:"
            read commitMsg

            git commit -a -m "$matchedType$scope: $commitMsg"
        fi
    fi
}

main