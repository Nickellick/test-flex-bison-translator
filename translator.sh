#!/bin/bash

#General info
NAME="Translator"
VERSION=0.2

function print_help()
{
    echo "  This is simple translator script (FESTU, 2020)"
    echo "  --help or -h"
    echo "      Prints this help"
    echo ""
    echo ""
    echo "  --version or -v"
    echo "    Prints version of script"
    echo ""
    echo ""
    echo "  --lexems or -l"
    echo "    Prints lexems of passed file"
    echo ""
    echo "    Example: ./translator.sh -l <file>"
    echo "    will print out all founded lexems in <file>"
    echo ""
    echo "    Example: ./translator.sh -l <source_file> <destination_file>"
    echo "    will write out all founded lexems in <file> to <destination_file>"
    echo ""
    echo ""
    echo "  --syntax or -s"
    echo "    Checks syntax of the file. Prints nothing if everything correct. In other case prints error message"
    echo ""
    echo "    Example: ./translator.sh -s <file>"
    echo "    will check syntax in <file>"
    echo ""
    echo ""
    echo "  --translate or -t"
    echo "    Translate passed file to target PL"
    echo ""
    echo "    Example: ./translator.sh -t <file>"
    echo "    will print out translation of <file>"
    echo ""
    echo "    Example: ./translator.sh -t <source_file> <destination_file>"
    echo "    will write out translation of <file> to <destination_file>"
    echo ""
    echo "  --compile or -c"
    echo "    Compiles all programs. Necessary if any of .y or .flex files are changed"
    echo ""
}

function print_version()
{
    echo -e "${NAME} version ${VERSION}"
}

function compile()
{
    cd ./lexems/src
    make all
    cd ../..

    cd ./syntax/src
    make all
    cd ../..

    cd ./translator/src
    make all
    cd ../..
}

if [ "${#}" -eq 0 ]
then
    echo -e "No parameters passed. Add \"--help\" or \"-h\" to show help"
else
    case ${1} in
        -h | --help)
            print_help
            exit
            ;;
        -v | --version)
            print_version
            exit
            ;;
        -t | --translate)
            if [ -z ${3} ] 
            then
                ./translator/translate ${2} || echo "Try to recompile"
            else
                ./translator/translate ${2} > ${3} || "Try to recomplie"
            fi
            exit
            ;;
        -s | --syntax)
            ./syntax/check-syntax ${2} || echo "Try to recompile"
            ;;
        -l | --lexems)
            if [ -z ${3} ] 
            then
                ./lexems/print-lexems ${2} || echo "Try to recompile"
            else
                ./lexems/print-lexems ${2} > ${3} || "Try to recomplie"
            fi
            exit
            ;;
        -c | --compile)
            compile
            ;;
        *)
            echo -e "Unknown parameter \"${PARAM}\""
            print_help
            exit 1
            ;;
    esac
fi