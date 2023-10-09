#!/bin/bash

if ! [[ "$1" || "$2" ]]; then
    echo "Usage: $0 target.com GITHUB_TOKEN [exclude grep regex]"
    exit
fi

script_home=$(dirname $(realpath $0))
target="$1"
org=$(echo $target | cut -d '.' -f 1)
gh_token="$2"
[[ "$3" ]] && exclude="$3"

function execute_command () {
    output_file=$1
    command_name=$2
    shift 2
    command="$*"

    echo -e "\n[+] Running $command_name\n"

    if [[ -f $output_file ]]; then
        execute=""
        read -p "  ==> $command_name report exists, overwrite? [N/y]: " execute
        if [[ "$execute" = 'y' ]]; then
            rm "$output_file"
        fi
    else
        execute='y'
    fi

    if [[ "$execute" = 'y' ]]; then
        if [[ $command_name = "github-subdomains" ]]; then
            $command 
            sleep 6
            $command
            sleep 6
            $command
            sleep 10
            $command
        else
            $command
        fi
    fi
}

echo ""
echo "--------------------------> Github Dork Links (By Jason Haddix) <--------------------------"

echo "--------------------------> Subdomain Enumeration on \"$target\" <--------------------------"

execute_command crtsh.txt "crt.sh" crt.sh -t $target -o crtsh.txt

execute_command subfinder.txt "Subfinder" subfinder -d $target -o subfinder.txt -silent

# execute_command shuffledns.txt "ShuffleDNS" shuffledns -d indeed.com -w $script_home/names.txt -l crtsh.txt -r $script_home/resolvers-community.txt

execute_command amass_passive.txt "Amass Passive" amass enum --passive -df crtsh.txt -o amass_passive.txt

execute_command github_subdomains.txt "github-subdomains" bash -c "github-subdomains -t $gh_token -d $target | grep -v "error occurred:" | tee -a github_subdomains.txt"

execute_command quarter_final.txt "Quarter Final Combination" bash -c "cat crtsh.txt github_subdomains.txt subfinder.txt amass_passive.txt | sort -u | httprobe | tee quarter_final.txt"

execute_command recursive.txt "Subfinder Recursive" subfinder -recursive -list quarter_final.txt -o recursive.txt -silent

execute_command semi_final.txt "Semi Final Combination" bash -c "echo \$(cat recursive.txt) \$(quarter_final.txt | httprobe) | sort -u | tee semi_final.txt"

execute_command goaltdns.txt "GoAltDNS" goaltdns -l semi_final.txt -w $script_home/names.txt -o goaltdns.txt

execute_command final_subdomains.txt "Final Combination" bash -c "echo \$(cat semi_final.txt) \$(cat goaltdns.txt | httprobe) | sort -u | grep -Ev \"$exclude\" > final_subdomains.txt"

echo -e "\n[+] Running gowitness\n"
gowitness file -f final_subdomains.txt --delay 1