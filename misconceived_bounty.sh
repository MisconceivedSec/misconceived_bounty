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

function execute_script () {
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
            $command | grep -v "[-] error" | tee -a github_subdomains.txt
            sleep 5
            $command | grep -v "[-] error" | tee -a github_subdomains.txt
            sleep 5
            $command | grep -v "[-] error" | tee -a github_subdomains.txt
            sleep 10
            $command | grep -v "[-] error" | tee -a github_subdomains.txt
        else
            $command
        fi
    fi
}

echo ""
echo "--------------------------> Github Dork Links (By Jason Haddix) <--------------------------"
echo ""
echo -e  "\n[+] password"
echo -e "\nhttps://github.com/search?q=\"$target\"+password&type=Code"
echo "https://github.com/search?q=\"$org\"+password&type=Code"
echo ""
echo -e  "\n[+] npmrc _auth"
echo -e "\nhttps://github.com/search?q=\"$target\"+npmrc%20_auth&type=Code"
echo "https://github.com/search?q=\"$org\"+npmrc%20_auth&type=Code"
echo ""
echo -e  "\n[+] dockercfg"
echo -e "\nhttps://github.com/search?q=\"$target\"+dockercfg&type=Code"
echo "https://github.com/search?q=\"$org\"+dockercfg&type=Code"
echo ""
echo -e  "\n[+] pem private"
echo -e "\nhttps://github.com/search?q=\"$target\"+pem%20private&type=Code"
echo "https://github.com/search?q=\"$org\"+extension:pem%20private&type=Code"
echo ""
echo -e  "\n[+]  id_rsa"
echo -e "\nhttps://github.com/search?q=\"$target\"+id_rsa&type=Code"
echo "https://github.com/search?q=\"$org\"+id_rsa&type=Code"
echo ""
echo -e  "\n[+] aws_access_key_id"
echo -e "\nhttps://github.com/search?q=\"$target\"+aws_access_key_id&type=Code"
echo "https://github.com/search?q=\"$org\"+aws_access_key_id&type=Code"
echo ""
echo -e  "\n[+] s3cfg"
echo -e "\nhttps://github.com/search?q=\"$target\"+s3cfg&type=Code"
echo "https://github.com/search?q=\"$org\"+s3cfg&type=Code"
echo ""
echo -e  "\n[+] htpasswd"
echo -e "\nhttps://github.com/search?q=\"$target\"+htpasswd&type=Code"
echo "https://github.com/search?q=\"$org\"+htpasswd&type=Code"
echo ""
echo -e  "\n[+] git-credentials"
echo -e "\nhttps://github.com/search?q=\"$target\"+git-credentials&type=Code"
echo "https://github.com/search?q=\"$org\"+git-credentials&type=Code"
echo ""
echo -e  "\n[+] bashrc password"
echo -e "\nhttps://github.com/search?q=\"$target\"+bashrc%20password&type=Code"
echo "https://github.com/search?q=\"$org\"+bashrc%20password&type=Code"
echo ""
echo -e  "\n[+] sshd_config"
echo -e "\nhttps://github.com/search?q=\"$target\"+sshd_config&type=Code"
echo "https://github.com/search?q=\"$org\"+sshd_config&type=Code"
echo ""
echo -e  "\n[+] xoxp OR xoxb OR xoxa"
echo -e "\nhttps://github.com/search?q=\"$target\"+xoxp%20OR%20xoxb%20OR%20xoxa&type=Code"
echo "https://github.com/search?q=\"$org\"+xoxp%20OR%20xoxb&type=Code"
echo ""
echo -e  "\n[+] SECRET_KEY"
echo -e "\nhttps://github.com/search?q=\"$target\"+SECRET_KEY&type=Code"
echo "https://github.com/search?q=\"$org\"+SECRET_KEY&type=Code"
echo ""
echo -e  "\n[+] client_secret"
echo -e "\nhttps://github.com/search?q=\"$target\"+client_secret&type=Code"
echo "https://github.com/search?q=\"$org\"+client_secret&type=Code"
echo ""
echo -e  "\n[+] sshd_config"
echo -e "\nhttps://github.com/search?q=\"$target\"+sshd_config&type=Code"
echo "https://github.com/search?q=\"$org\"+sshd_config&type=Code"
echo ""
echo -e  "\n[+] github_token"
echo -e "\nhttps://github.com/search?q=\"$target\"+github_token&type=Code"
echo "https://github.com/search?q=\"$org\"+github_token&type=Code"
echo ""
echo -e  "\n[+] api_key"
echo -e "\nhttps://github.com/search?q=\"$target\"+api_key&type=Code"
echo "https://github.com/search?q=\"$org\"+api_key&type=Code"
echo ""
echo -e  "\n[+] FTP"
echo -e "\nhttps://github.com/search?q=\"$target\"+FTP&type=Code"
echo "https://github.com/search?q=\"$org\"+FTP&type=Code"
echo ""
echo -e  "\n[+] app_secret"
echo -e "\nhttps://github.com/search?q=\"$target\"+app_secret&type=Code"
echo "https://github.com/search?q=\"$org\"+app_secret&type=Code"
echo ""
echo -e  "\n[+]  passwd"
echo -e "\nhttps://github.com/search?q=\"$target\"+passwd&type=Code"
echo "https://github.com/search?q=\"$org\"+passwd&type=Code"
echo ""
echo -e  "\n[+] s3.yml"
echo -e "\nhttps://github.com/search?q=\"$target\"+.env&type=Code"
echo "https://github.com/search?q=\"$org\"+.env&type=Code"
echo ""
echo -e  "\n[+] .exs"
echo -e "\nhttps://github.com/search?q=\"$target\"+.exs&type=Code"
echo "https://github.com/search?q=\"$org\"+.exs&type=Code"
echo ""
echo -e  "\n[+] beanstalkd.yml"
echo -e "\nhttps://github.com/search?q=\"$target\"+beanstalkd.yml&type=Code"
echo "https://github.com/search?q=\"$org\"+beanstalkd.yml&type=Code"
echo ""
echo -e  "\n[+] deploy.rake"
echo -e "\nhttps://github.com/search?q=\"$target\"+deploy.rake&type=Code"
echo "https://github.com/search?q=\"$org\"+deploy.rake&type=Code"
echo ""
echo -e  "\n[+] mysql"
echo -e "\nhttps://github.com/search?q=\"$target\"+mysql&type=Code"
echo "https://github.com/search?q=\"$org\"+mysql&type=Code"
echo ""
echo -e  "\n[+] credentials"
echo -e "\nhttps://github.com/search?q=\"$target\"+credentials&type=Code"
echo "https://github.com/search?q=\"$org\"+credentials&type=Code"
echo ""
echo -e  "\n[+] PWD"
echo -e "\nhttps://github.com/search?q=\"$target\"+PWD&type=Code"
echo "https://github.com/search?q=\"$org\"+PWD&type=Code"
echo ""
echo -e  "\n[+] deploy.rake"
echo -e "\nhttps://github.com/search?q=\"$target\"+deploy.rake&type=Code"
echo "https://github.com/search?q=\"$org\"+deploy.rake&type=Code"
echo ""
echo -e  "\n[+] .bash_history"
echo -e "\nhttps://github.com/search?q=\"$target\"+.bash_history&type=Code"
echo "https://github.com/search?q=\"$org\"+.bash_history&type=Code"
echo ""
echo -e  "\n[+] .sls"
echo -e "\nhttps://github.com/search?q=\"$target\"+.sls&type=Code"
echo "https://github.com/search?q=\"$org\"+PWD&type=Code"
echo ""
echo -e  "\n[+] secrets"
echo -e "\nhttps://github.com/search?q=\"$target\"+secrets&type=Code"
echo "https://github.com/search?q=\"$org\"+secrets&type=Code"
echo ""
echo -e  "\n[+] composer.json"
echo -e "\nhttps://github.com/search?q=\"$target\"+composer.json&type=Code"
echo "https://github.com/search?q=\"$org\"+composer.json&type=Code"
echo ""
echo -e  "\n[+] Snyk"
echo -e "\nhttps://github.com/search?q=\"$target\"+snyk&type=Code"
echo "https://github.com/search?q=\"$org\"+snyk&type=Code"
echo ""
echo ""
echo ""
echo ""
echo "--------------------------> Subdomain Enumeration on \"$target\" <--------------------------"

execute_script subfinder.txt "Subfinder" subfinder -d $target -o subfinder.txt -silent
execute_script shuffledns.txt "ShuffleDNS" shuffledns -d $target -w $script_home/names.txt -r $script_home/resolvers-community.txt -o shuffledns.txt -silent
execute_script amass_passive.txt "Amass Passive" amass enum --passive -df subfinder_recursive.txt -o amass_passive.txt
execute_script github_subdomains.txt "github-subdomains" github-subdomains -t $gh_token -d $target

echo -e "\n[+] Combining Files\n"
cat github_subdomains.txt subfinder.txt amass_passive.txt shuffledns.txt | sort -u > quarter_final.txt 

execute_script recursive.txt "Subfinder Recursive" subfinder -recursive -list quarter_final.txt -o recursive.txt -silent

echo -e "\n[+] Combining Files\n"
cat github_subdomains.txt subfinder.txt recursive.txt amass_passive.txt shuffledns.txt | sort -u > semi_final.txt 

execute_script goaltdns.txt "GoAltDNS" goaltdns -l semi_final.txt -w $script_home/names.txt -o goaltdns.txt

echo -e "\n[+] Combining & cleaning lists + httprobing them\n"
cat github_subdomains.txt subfinder.txt recursive.txt amass_passive.txt shuffledns.txt goaltdns.txt | sort -u | grep -Ev "$exclude" | httprobe > final_subdomains.txt

echo -e "\n[+] Running gowitness\n"
gowitness file -f final_subdomains.txt --delay 1

