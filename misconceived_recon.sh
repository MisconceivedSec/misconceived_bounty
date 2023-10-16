#!/bin/bash

## Colours + Formatting

blue=$'\e[34m'
orange=$'\e[33m'
yellow=$'\e[93m'
red=$'\e[31m'
green=$'\e[32m'
cyan=$'\e[36m'
magenta=$'\e[35m'
bold=$'\e[1m'
italic=$'\e[3m'
underline=$'\e[4m'
reset=$'\e[0m'

default_tasks=("subdomain" "screenshot" "services" "deep_domains" "leaks")

print_banner() {
    echo '   __  ___ _                                _                __ ___                      '
    echo '  /  |/  /(_)___ ____ ___   ___  ____ ___  (_)_  __ ___  ___/ // _ \ ___  ____ ___   ___ '
    echo ' / /|_/ // /(_-</ __// _ \ / _ \/ __// -_)/ /| |/ // -_)/ _  // , _// -_)/ __// _ \ / _ \'
    echo '/_/  /_//_//___/\__/ \___//_//_/\__/ \__//_/ |___/ \__/ \_,_//_/|_| \__/ \__/ \___//_//_/'
    echo "                                                                        ${red}Mr. Misconception${reset}"
}

my_date() {
    date +%a\ %e\ %b\ %H:%M:%S\ %Y
}

## Flag Execution

flags() {

    [[ "$#" -eq 0 ]] && help

    case $1 in
        init)
            mode="init"
            shift
            while [[ "$1" != "" ]]; do
                case $1 in
                    -t|-target)
                        shift
                        if [[ "$1" ]]; then
                            target="$1"
                        else
                            print_error "-t|-target requires an argument!"
                        fi
                        shift
                        ;;
                    -ght|-github-token)
                        shift
                        if [[ "$1" ]]; then
                            ghtoken="$1"
                        else
                            print_error "-ght|-github-token requires an argument!"
                        fi
                        shift
                        ;;
                    -ghr|-github-recon)
                        shift
                        if [[ "$1" ]]; then
                            github_recon="$1"
                        else
                            print_error "-ghr|-github-recon requires an argument!"
                        fi
                        shift
                        ;;
                    -glt|-gitlab-token)
                        shift
                        if [[ "$1" ]]; then
                            gltoken="$1"
                        else
                            print_error "-glt|-gitlab-token requires an argument!"
                        fi
                        shift
                        ;;
                    -glr|-gitlab-recon)
                        shift
                        if [[ "$1" ]]; then
                            gitlab_recon="$1"
                        else
                            print_error "-glr|-gitlab-recon requires an argument!"
                        fi
                        shift
                        ;;
                    -ws|-subdomain-webhook)
                        shift
                        if [[ "$1" ]]; then
                            subdomain_webhook="$1"
                        else
                            print_error "-ws|-subdomain-webhook requires an argument!"
                        fi
                        shift
                        ;;
                    -wv|-service-webhook)
                        shift
                        if [[ "$1" ]]; then
                            service_webhook="$1"
                        else
                            print_error "-wv|-service-webhook requires an argument!"
                        fi
                        shift
                        ;;
                    -wd|-deep-domain-webhook)
                        shift
                        if [[ "$1" ]]; then
                            deep_domain_webhook="$1"
                        else
                            print_error "-wd|-deep-domain-webhook requires an argument!"
                        fi
                        shift
                        ;;
                    -wl|-leaks-webhook)
                        shift
                        if [[ "$1" ]]; then
                            leaks_webhook="$1"
                        else
                            print_error "-wl|-leaks-webhook requires an argument!"
                        fi
                        shift
                        ;;
                    -wg|-logs-webhook)
                        shift
                        if [[ "$1" ]]; then
                            logs_webhook="$1"
                        else
                            print_error "-wg|-logs_webhook requires an argument!"
                        fi
                        shift
                        ;;
                    -wc|-screenshots-webhook)
                        shift
                        if [[ "$1" ]]; then
                            screenshot_webhook="$1"
                        else
                            print_error "-wc|-screenshots-webhook requires an argument!"
                        fi
                        shift
                        ;;
                    -b|-brute-wordlists)
                        shift
                        if [[ "$1" ]]; then
                            input_brute_wordlist="$1"
                        else
                            print_error "-b|-brute-wordlist requires a wordlist file!"
                        fi
                        shift
                        ;;
                    -p|-path)
                        shift
                        if [[ "$1" && -d "$1" ]]; then
                            path="$(realpath $1)"
                        else
                            print_error "-p|-path requires a valid path!"
                        fi
                        shift
                        ;;
                    -ct|-custom-tasks)
                        shift
                        if [[ "$1" ]]; then
                            custom_task="$1"
                        else
                            print_error "-ct|-custom-tasks requires an argument!"
                        fi
                        shift
                        ;;
                    -d|-deep-domains)
                        shift
                        if [[ "$1" && -r "$2" ]]; then
                            deep_domains+=("$1")
                            fuzz_wordlist+=("$2")
                        else
                            print_error "-d|-deep-domains requires a domain and a valid path!!"
                        fi
                        shift 2
                        ;;
                    -h|-help)
                        help init
                        ;;
                    -?*)
                        print_error "Unknown option '$1'"
                        ;;
                    *)
                        print_error "Missing options"
                        ;;
                esac        
            done
            ;;
        config)
            mode="config"
            shift
            while [[ "$1" != "" ]]; do
                case $1 in
                    -t|-target)
                        shift
                        if [[ "$1" ]]; then
                            target="$1"
                        else
                            print_error "-t|-target requires an argument!"
                        fi
                        shift
                        ;;
                    -d|-deep-domains)
                        shift
                        if [[ "$1" && -r "$2" ]]; then
                            deep_domains+=("$1")
                            fuzz_wordlist+=("$2")
                        else
                            print_error "-d|-deep-domains requires a domain and a valid path!"
                        fi
                        shift 2
                        ;;
                    -ght|-github-token)
                        shift
                        if [[ "$1" ]]; then
                            ghtoken="$1"
                        else
                            print_error "-ght|-github-token requires an argument!"
                        fi
                        shift
                        ;;
                    -ghr|-github-recon)
                        shift
                        if [[ "$1" ]]; then
                            github_recon="$1"
                        else
                            print_error "-ghr|-github-recon requires an argument!"
                        fi
                        shift
                        ;;
                    -glt|-gitlab-token)
                        shift
                        if [[ "$1" ]]; then
                            gltoken="$1"
                        else
                            print_error "-glt|-gitlab-token requires an argument!"
                        fi
                        shift
                        ;;
                    -glr|-gitlab-recon)
                        shift
                        if [[ "$1" ]]; then
                            gitlab_recon="$1"
                        else
                            print_error "-glr|-gitlab-recon requires an argument!"
                        fi
                        shift
                        ;;
                    -b|-brute-wordlist)
                        shift
                        if [[ "$1" ]]; then
                            input_brute_wordlist="$1"
                        else
                            print_error "-b|-brute-wordlist requires a wordlist file!"
                        fi
                        shift
                        ;;
                    -a|-attack-method)
                        shift
                        if [[ "$1" ]]; then
                            attack_method="$1"
                        else
                            print_error "-a|-attack-method requires a valid path!"
                        fi
                        shift
                        ;;
                    -c|-config-file)
                        shift
                        if [[ -r "$1" ]]; then
                            config_file="$(realpath $1)"
                        else
                            print_error "-c|-config-file requires a valid config file!"
                        fi
                        shift
                        ;;
                    -ws|-subdomain-webhook)
                        shift
                        if [[ "$1" ]]; then
                            subdomain_webhook="$1"
                        else
                            print_error "-ws|-subdomain-webhook requires an argument!"
                        fi
                        shift
                        ;;
                    -wv|-service-webhook)
                        shift
                        if [[ "$1" ]]; then
                            service_webhook="$1"
                        else
                            print_error "-wv|-service-webhook requires an argument!"
                        fi
                        shift
                        ;;
                    -wd|-deep-domain-webhook)
                        shift
                        if [[ "$1" ]]; then
                            deep_domain_webhook="$1"
                        else
                            print_error "-wd|-deep-domain-webhook requires an argument!"
                        fi
                        shift
                        ;;
                    -wl|-leaks-webhook)
                        shift
                        if [[ "$1" ]]; then
                            leaks_webhook="$1"
                        else
                            print_error "-wl|-leaks_webhook requires an argument!"
                        fi
                        shift
                        ;;
                    -wg|-logs-webhook)
                        shift
                        if [[ "$1" ]]; then
                            logs_webhook="$1"
                        else
                            print_error "-wg|-logs_webhook requires an argument!"
                        fi
                        shift
                        ;;
                    -wc|-screenshots-webhook)
                        shift
                        if [[ "$1" ]]; then
                            screenshot_webhook="$1"
                        else
                            print_error "-wc|-screenshots-webhook requires an argument!"
                        fi
                        shift
                        ;;
                    -n|-nano)
                        nano_it='true'
                        shift
                        ;;
                    -h|-help)
                        help config
                        ;;
                    -?*)
                        print_error "Unknown option '$1'"
                        ;;
                    *)
                        print_error "Missing options"
                        ;;
                esac        
            done
            ;;    
        recon)
            mode="recon"
            shift
            while [[ "$1" != "" ]]; do
                case $1 in
                    -c|-config-file)
                        shift
                        if [[ -r "$1" ]]; then
                            config_file="$1"
                        else
                            print_error "-c|-config-file requires a valid config file!"
                        fi
                        shift
                        ;;
                    -h|-help)
                        help recon
                        ;;
                    -?*)
                        print_error "Unknown option '$1'"
                        ;;
                    *)
                        print_error "Missing options"
                        ;;
                esac
                shift
            done
            ;;
        subdomain)
            mode="subdomain"
            shift
            while [[ "$1" != "" ]]; do
                case $1 in
                    -c|-config-file)
                        shift
                        if [[ -r "$1" ]]; then
                            config_file="$1"
                        else
                            print_error "-c|-config-file requires a valid config file!"
                        fi
                        shift
                        ;;
                    -h|-help)
                        help subdomain
                        ;;
                    -?*)
                        print_error "Unknown option '$1'"
                        ;;
                    *)
                        print_error "Missing options"
                        ;;
                esac
                shift
            done
            ;;
        screenshot)
            mode="screenshot"
            shift
            while [[ "$1" != "" ]]; do
                case $1 in
                    -c|-config-file)
                        shift
                        if [[ -r "$1" ]]; then
                            config_file="$1"
                        else
                            print_error "-c|-config-file requires a valid config file!"
                        fi
                        shift
                        ;;
                    -h|-help)
                        help screenshot
                        ;;
                    -?*)
                        print_error "Unknown option '$1'"
                        ;;
                    *)
                        print_error "Missing options"
                        ;;
                esac
                shift
            done
            ;;
        deep)
            mode="deep"
            shift
            while [[ "$1" != "" ]]; do
                case $1 in
                    -c|-config-file)
                        shift
                        if [[ -r "$1" ]]; then
                            config_file="$1"
                        else
                            print_error "-c|-config-file requires a valid config file!"
                        fi
                        shift
                        ;;
                    -h|-help)
                        help deep
                        ;;
                    -?*)
                        print_error "Unknown option '$1'"
                        ;;
                    *)
                        print_error "Missing options"
                        ;;
                esac
                shift
            done
            ;;
        leaks)
            mode="leaks"
            shift
            while [[ "$1" != "" ]]; do
                case $1 in
                    -c|-config-file)
                        shift
                        if [[ -r "$1" ]]; then
                            config_file="$1"
                        else
                            print_error "-c|-config-file requires a valid config file!"
                        fi
                        shift
                        ;;
                    -h|-help)
                        help leaks
                        ;;
                    -?*)
                        print_error "Unknown option '$1'"
                        ;;
                    *)
                        print_error "Missing options"
                        ;;
                esac
                shift
            done
            ;;
        gdork)
            mode="gdork"
            shift
            while [[ "$1" != "" ]]; do
                case $1 in
                    -c|-config-file)
                        shift
                        if [[ -r "$1" ]]; then
                            config_file="$1"
                        else
                            print_error "-c|-config-file requires a valid config file!"
                        fi
                        shift
                        ;;
                    -h|-help)
                        help gdork
                        ;;
                    -?*)
                        print_error "Unknown option '$1'"
                        ;;
                    *)
                        print_error "Missing options"
                        ;;
                esac
                shift
            done
            ;;
        test)
            mode="test"
            shift
            while [[ "$1" != "" ]]; do
                case $1 in
                    -c|-config-file)
                        shift
                        if [[ -r "$1" ]]; then
                            config_file="$1"
                        else
                            print_error "-c|-config-file requires a valid config file!"
                        fi
                        shift
                        ;;
                    -h|-help)
                        help
                        ;;
                    -?*)
                        print_error "Unknown option '$1'"
                        ;;
                    *)
                        print_error "Missing options"
                        ;;
                esac
                shift
            done
            ;;
        help)
            help
            ;;
        *)
            print_error "Unknown option '$1'" no_exit
            echo ""
            help
            ;;
    esac
}
## Functions

print_info() {    
    [[ $mode ]] && print_sub "Mode: ${yellow}$mode${reset}"
    [[ $target ]] && print_sub "Target:" "${yellow}$target${reset}"
    [[ $config_file ]] && print_sub "Config File:" "${yellow}${underline}$config_file${reset}"
    echo ""
}

print_error() {
    echo -e "${bold}${red}Error:${reset} $1"
    [[ "$2" = "no_exit" ]] || exit 1
}

print_message() {                   
    echo -e "${blue}=>>${reset}${bold} $1${reset} $2"
}

print_task() {                   
    echo -e "${red}=>>${reset}${bold} $1${reset} $2"
    [[ $logs_webhook ]] && send_to_discord "    - *${1}*"
}

print_sub() {                   
    echo -e "${orange}=>>${reset}${bold} $1${reset} $2"
}

print_green() {
    echo ""
    echo -e "${bold}${green}=>>${reset}${bold} ${underline}$1${reset} $2"
    echo ""
}

print_warning() {
    echo -e "${magenta}=>>${reset}${bold} $1${reset} $2"
}

print_announce() {
    start_date="$(my_date)"
    
    print_green "$1" "${italic}${yellow}($start_date)${reset}"
    send_to_discord "__**$1** ($start_date)__" $logs_webhook
}

my_diff() {
    old=$1
    new=$2
    report=$3
    webhook=$4

    difference="$([[ -r $old ]] && colordiff $old $new | sed -e "s/</-/g" -e "s/>/+/g" | grep -Ev '\---')"

    if [[ $difference ]]; then
        print_warning "Found changes in report: ${report}"
        echo -e "$difference"

        if [[ $webhook ]]; then
            print_message "Uploading difference in:" "${report} report"
            send_to_discord "Changes in **\`${report}\`**:\n\`\`\`diff\n${difference}\n\`\`\`" $webhook
        fi
    fi
}

send_to_discord() {
    message="$1"
    webhook="$2"
    upload_file="$3"

    if [[ $webhook ]]; then
        if [[ $upload_file ]]; then
            discord.sh --webhook-url="$webhook" --username 'MisconceivedRecon' --avatar 'https://i.imgur.com/eFlbVl2.jpg' --text "$message" --file "$upload_file"
        else
            discord.sh --webhook-url="$webhook" --username 'MisconceivedRecon' --avatar 'https://i.imgur.com/eFlbVl2.jpg' --text "$message"
        fi
    fi
}

prompt() {
    read -p "   ${red}->${reset} $1 " userinput
    echo ""
}

help() {
    print_banner
    print_info

    if [[ "$1" = "init" ]]; then
        echo "${green}${bold}Usage:${reset} $0 ${cyan}init${reset} [OPTIONS]"
        echo ""
        echo "${green}${bold}Flags:${reset}"
        echo "  ${magenta}${bold}-t -target${reset} domain                       ${bold}Mandatory:${reset} Target domain"
        echo "  ${magenta}${bold}-b -brute-wordlists${reset} file[,file,...]     ${bold}Mandatory:${reset} Wordlist(s) for subdomain brute-forcing"
        echo "  ${magenta}${bold}-ght -github-token${reset} token                ${bold}Mandatory:${reset} GitHub Token"
        echo "  ${magenta}${bold}-ghr -github-recon${reset} url[,url,...]        GitHub Repos to enumerate"
        echo "  ${magenta}${bold}-glt -gitlab-token${reset} token                GitLab Token"
        echo "  ${magenta}${bold}-glr -gitlab-recon${reset} url[,url,...]        GitLab Repos to enumerate"
        echo "  ${magenta}${bold}-p -path${reset} path                           Path to recon report directory"
        echo "  ${magenta}${bold}-ct -custom-tasks${reset} task[,task,...]       Custom task sequence"
        echo "  ${magenta}${bold}-d -deep-domains${reset} domain wordlist        Domains preform deep recon on"        
        echo "  ${magenta}${bold}-ws -subdomain-webhook${reset} url              Subdomain Webhook" 
        echo "  ${magenta}${bold}-wc -screenshots-webhook${reset} url            Screenshots Webhook"        
        echo "  ${magenta}${bold}-wv -service-webhook${reset} url                Service Webhook"        
        echo "  ${magenta}${bold}-wd -deep-domain-webhook${reset} url            Deep Domain Webhook"        
        echo "  ${magenta}${bold}-wl -leaks-webhook${reset} url                  Leaks Webhook"        
        echo "  ${magenta}${bold}-wg -logs-webhook${reset} url                   Logs Webhook"            
        echo "  ${magenta}${bold}-h -help${reset}                                ${bold}Standalone:${reset} Print this help message"
        echo ""
        echo "(Must provide ${bold}all${reset} webhooks together, or ${bold}none${reset} at all)"
        echo ""
        echo "${green}${bold}Available Recon Tasks:${reset}"
        for attack in ${default_tasks[*]}; do
            echo "  ${bold}${attack}${reset}"
        done
    elif [[ "$1" = "config" ]]; then
        echo "${green}${bold}Usage:${reset} $0 ${cyan}config${reset} [OPTIONS]"
        echo ""
        echo "${green}${bold}Flags:${reset}"
        echo "  ${magenta}${bold}-c -config-file${reset} file                    ${bold}Mandatory:${reset} Configuration file for target"
        echo "  ${magenta}${bold}-t -target${reset} domain                       Change target domain"
        echo "  ${magenta}${bold}-b -brute-wordlists${reset} file[,file,...]     Add wordlist(s) for subdomain brute-forcing"
        echo "  ${magenta}${bold}-ght -github-token${reset} token                Change GitHub Token"
        echo "  ${magenta}${bold}-ghr -github-recon${reset} url[,url,...]        Add GitHub Repos to enumerate"
        echo "  ${magenta}${bold}-glt -gitlab-token${reset} token                Change GitLab Token"
        echo "  ${magenta}${bold}-glr -gitlab-recon${reset} url[,url,...]        Add GitLab Repos to enumerate"
        echo "  ${magenta}${bold}-a -attack-method${reset} task[,task,...]       Change task sequence"
        echo "  ${magenta}${bold}-d -deep-domains${reset} domain wordlist        Add domains for deep recon"        
        echo "  ${magenta}${bold}-ws -subdomain-webhook${reset} url              Change Subdomain Webhook"      
        echo "  ${magenta}${bold}-wc -screenshots-webhook${reset} url            Change Screenshots Webhook"          
        echo "  ${magenta}${bold}-wv -service-webhook${reset} url                Change Service Webhook"        
        echo "  ${magenta}${bold}-wd -deep-domain-webhook${reset} url            Change Deep Domain Webhook"        
        echo "  ${magenta}${bold}-wl -leaks-webhook${reset} url                  Change Leaks Webhook"        
        echo "  ${magenta}${bold}-wg -logs-webhook${reset} url                   Change Logs Webhook"                   
        echo "  ${magenta}${bold}-n -nano${reset}                                ${bold}Standalone:${reset} Edit the config file using nano"
        echo "  ${magenta}${bold}-h -help${reset}                                ${bold}Standalone:${reset} Print this help message"
        echo ""
        echo "${green}${bold}Available Recon Tasks:${reset}"
        for attack in ${default_tasks[*]}; do
            echo "  ${bold}${attack}${reset}"
        done
    elif [[ $1 =~ subdomain|screenshot|fingerprint|deep|leaks|gdork|recon ]]; then
        echo "${green}${bold}Usage:${reset} $0 ${cyan}recon${reset}|${cyan}subdomain${reset}|${cyan}screenshot${reset}|${cyan}fingerprint${reset}|${cyan}deep${reset}|${cyan}leaks${reset}|${cyan}gdork${reset} [OPTIONS]"
        echo ""
        echo "${green}${bold}Flags:${reset}"
        echo "  ${magenta}${bold}-c -config-file${reset} file                    ${bold}Mandatory:${reset} Configuration file for target"
        echo ""
    else
        echo "${green}${bold}Usage:${reset} $0 MODE [OPTIONS]"
        echo ""
        echo "${green}${bold}Main Modes:${reset}"
        echo "    ${cyan}help   ${yellow}=>${reset} Print this help message"
        echo "    ${cyan}init   ${yellow}=>${reset} Initiate configuration for recon on target"
        echo "    ${cyan}config ${yellow}=>${reset} Modify configuration of specific target"        
        echo "    ${cyan}recon  ${yellow}=>${reset} Run recon based on configuration file"
        echo ""
        echo "${green}${bold}Single Functions:${reset}"    
        echo "    ${cyan}subdomain   ${yellow}=>${reset} Subdomain Recon"
        echo "    ${cyan}screenshot  ${yellow}=>${reset} Screenshots of Subdomains"
        echo "    ${cyan}fingerprint ${yellow}=>${reset} Fingerprint/Service Scan"
        echo "    ${cyan}deep        ${yellow}=>${reset} Deep Domain Recon"
        echo "    ${cyan}leaks       ${yellow}=>${reset} Scan GiHub/GitLab (and other sites) repos for leaks"
        echo "    ${cyan}gdork       ${yellow}=>${reset} Generate GitHub Dorking Links"
        echo ""
        echo "Parse ${magenta}${bold}-h${reset} or ${magenta}${bold}-help${reset} with each mode/function for more information"
    fi
    exit
}

probe() {
    httprobe -p http:8080 -p http:8000 -p http:8008 -p http:8081 -p http:8888 -p http:8088 -p http:8880 -p http:8001 -p http:8082 -p http:8787 -p https:8443 -p https:8444 -p https:9443 -p https:4433 -p https:4343
}

extract_url() {
    cut -d ':' -f 1-2 | sed -e "s/http:\/\///" -e "s/https:\/\///" | sort -u
}

github_dorking_links() {

    {
        echo "https://github.com/search?q=\"${target}\"+password&type=Code"
        echo "https://github.com/search?q=\"${org}\"+password&type=Code"
        echo "https://github.com/search?q=\"${target}\"+npmrc%20_auth&type=Code"
        echo "https://github.com/search?q=\"${org}\"+npmrc%20_auth&type=Code"
        echo "https://github.com/search?q=\"${target}\"+dockercfg&type=Code"
        echo "https://github.com/search?q=\"${org}\"+dockercfg&type=Code"
        echo "https://github.com/search?q=\"${target}\"+pem%20private&type=Code"
        echo "https://github.com/search?q=\"${org}\"+extension:pem%20private&type=Code"
        echo "https://github.com/search?q=\"${target}\"+id_rsa&type=Code"
        echo "https://github.com/search?q=\"${org}\"+id_rsa&type=Code"
        echo "https://github.com/search?q=\"${target}\"+aws_access_key_id&type=Code"
        echo "https://github.com/search?q=\"${org}\"+aws_access_key_id&type=Code"
        echo "https://github.com/search?q=\"${target}\"+s3cfg&type=Code"
        echo "https://github.com/search?q=\"${org}\"+s3cfg&type=Code"
        echo "https://github.com/search?q=\"${target}\"+htpasswd&type=Code"
        echo "https://github.com/search?q=\"${org}\"+htpasswd&type=Code"
        echo "https://github.com/search?q=\"${target}\"+git-credentials&type=Code"
        echo "https://github.com/search?q=\"${org}\"+git-credentials&type=Code"
        echo "https://github.com/search?q=\"${target}\"+bashrc%20password&type=Code"
        echo "https://github.com/search?q=\"${org}\"+bashrc%20password&type=Code"
        echo "https://github.com/search?q=\"${target}\"+sshd_config&type=Code"
        echo "https://github.com/search?q=\"${org}\"+sshd_config&type=Code"
        echo "https://github.com/search?q=\"${target}\"+xoxp%20OR%20xoxb%20OR%20xoxa&type=Code"
        echo "https://github.com/search?q=\"${org}\"+xoxp%20OR%20xoxb&type=Code"
        echo "https://github.com/search?q=\"${target}\"+SECRET_KEY&type=Code"
        echo "https://github.com/search?q=\"${org}\"+SECRET_KEY&type=Code"
        echo "https://github.com/search?q=\"${target}\"+client_secret&type=Code"
        echo "https://github.com/search?q=\"${org}\"+client_secret&type=Code"
        echo "https://github.com/search?q=\"${target}\"+sshd_config&type=Code"
        echo "https://github.com/search?q=\"${org}\"+sshd_config&type=Code"
        echo "https://github.com/search?q=\"${target}\"+github_token&type=Code"
        echo "https://github.com/search?q=\"${org}\"+github_token&type=Code"
        echo "https://github.com/search?q=\"${target}\"+api_key&type=Code"
        echo "https://github.com/search?q=\"${org}\"+api_key&type=Code"
        echo "https://github.com/search?q=\"${target}\"+FTP&type=Code"
        echo "https://github.com/search?q=\"${org}\"+FTP&type=Code"
        echo "https://github.com/search?q=\"${target}\"+app_secret&type=Code"
        echo "https://github.com/search?q=\"${org}\"+app_secret&type=Code"
        echo "https://github.com/search?q=\"${target}\"+passwd&type=Code"
        echo "https://github.com/search?q=\"${org}\"+passwd&type=Code"
        echo "https://github.com/search?q=\"${target}\"+.env&type=Code"
        echo "https://github.com/search?q=\"${org}\"+.env&type=Code"
        echo "https://github.com/search?q=\"${target}\"+.exs&type=Code"
        echo "https://github.com/search?q=\"${org}\"+.exs&type=Code"
        echo "https://github.com/search?q=\"${target}\"+beanstalkd.yml&type=Code"
        echo "https://github.com/search?q=\"${org}\"+beanstalkd.yml&type=Code"
        echo "https://github.com/search?q=\"${target}\"+deploy.rake&type=Code"
        echo "https://github.com/search?q=\"${org}\"+deploy.rake&type=Code"
        echo "https://github.com/search?q=\"${target}\"+mysql&type=Code"
        echo "https://github.com/search?q=\"${org}\"+mysql&type=Code"
        echo "https://github.com/search?q=\"${target}\"+credentials&type=Code"
        echo "https://github.com/search?q=\"${org}\"+credentials&type=Code"
        echo "https://github.com/search?q=\"${target}\"+PWD&type=Code"
        echo "https://github.com/search?q=\"${org}\"+PWD&type=Code"
        echo "https://github.com/search?q=\"${target}\"+deploy.rake&type=Code"
        echo "https://github.com/search?q=\"${org}\"+deploy.rake&type=Code"
        echo "https://github.com/search?q=\"${target}\"+.bash_history&type=Code"
        echo "https://github.com/search?q=\"${org}\"+.bash_history&type=Code"
        echo "https://github.com/search?q=\"${target}\"+.sls&type=Code"
        echo "https://github.com/search?q=\"${org}\"+PWD&type=Code"
        echo "https://github.com/search?q=\"${target}\"+secrets&type=Code"
        echo "https://github.com/search?q=\"${org}\"+secrets&type=Code"
        echo "https://github.com/search?q=\"${target}\"+composer.json&type=Code"
        echo "https://github.com/search?q=\"${org}\"+composer.json&type=Code"
        echo "https://github.com/search?q=\"${target}\"+snyk&type=Code"
        echo "https://github.com/search?q=\"${org}\"+snyk&type=Code"
    } > ${recon_dir}/github_dorking_links.txt

    cat ${recon_dir}/github_dorking_links.txt | xclip -selection clipboard
    print_task "GitHub Dorking Links Copied" "${red}-->${reset} ./$(realpath --relative-to="." "${recon_dir}/github_dorking.txt")"
}

subdomain_recon() {

    print_announce "SUBDOMAIN ENUMERATION"
    start_seconds=$SECONDS

    ## crt.sh

    print_task "Pulling down 'crt.sh' domains" "${red}-->${reset} ./$(realpath --relative-to="." "$subdomain_dir/crt_sh.txt")"
    [[ -f $subdomain_dir/crt_sh.txt ]] && mv $subdomain_dir/crt_sh.txt $subdomain_dir/crt_sh.old
    [[ -f $subdomain_dir/crt_sh_wildcard.txt ]] && mv $subdomain_dir/crt_sh_wildcard.txt $subdomain_dir/crt_sh_wildcard.old

    crt.sh -t "$target" > $subdomain_dir/crt_temp.txt
    cat $subdomain_dir/crt_temp.txt | grep -v '*' | probe | tee $subdomain_dir/crt_sh.txt

    print_message "crt.sh wildcard domains"
    grep '*' $subdomain_dir/crt_temp.txt | tee $subdomain_dir/crt_sh_wildcard.txt

    rm $subdomain_dir/crt_temp.txt

    my_diff $subdomain_dir/crt_sh.old $subdomain_dir/crt_sh.txt "crt.sh"
    my_diff $subdomain_dir/crt_sh_wildcard.old $subdomain_dir/crt_sh_wildcard.txt "crt.sh wildcard domains"

    ## Subfinder

    print_task "Running 'subfinder'" "${red}-->${reset} ./$(realpath --relative-to="." "$subdomain_dir/subfinder.txt")"
    [[ -f $subdomain_dir/subfinder.old ]] && mv $subdomain_dir/subfinder.old $subdomain_dir/subfinder.txt

    subfinder -d "$target" -silent | sort -u | probe | tee $subdomain_dir/subfinder.txt

    my_diff $subdomain_dir/subfinder.old $subdomain_dir/subfinder.txt "subfinder"

    ## GitHub Subdomains

    print_task "Running 'github-subdomains.py'" "${red}-->${reset} ./$(realpath --relative-to="." "$subdomain_dir/github_subdomains.txt")"
    [[ -f $subdomain_dir/github_subdomains.txt ]] && mv $subdomain_dir/github_subdomains.txt $subdomain_dir/github_subdomains.old

    github-subdomains -t $ghtoken -d $target | grep -v "error occurred:" | tee $subdomain_dir/github_subdomain_unsorted.txt
    sleep 6
    github-subdomains -t $ghtoken -d $target | grep -v "error occurred:" | tee -a $subdomain_dir/github_subdomain_unsorted.txt
    sleep 6
    github-subdomains -t $ghtoken -d $target | grep -v "error occurred:" | tee -a $subdomain_dir/github_subdomain_unsorted.txt
    sleep 10
    github-subdomains -t $ghtoken -d $target | grep -v "error occurred:" | tee -a $subdomain_dir/github_subdomain_unsorted.txt

    sort -u $subdomain_dir/github_subdomain_unsorted.txt | probe > $subdomain_dir/github_subdomains.txt
    rm $subdomain_dir/github_subdomain_unsorted.txt

    my_diff $subdomain_dir/github-subdomains.old $subdomain_dir/github-subdomains.txt "github-subdomains"

    ## Amass (doesn't work with my internet :/)

    # print_message "Running 'amass passive'"
    # [[ -f $subdomain_dir/amass_passive.txt ]] && mv $subdomain_dir/crt_sh.txt $subdomain_dir/amass_passive.old
    # amass enum --passive -d $target | sort -u | probe | tee -a $subdomain_dir/amass_passive.txt
    # my_diff $subdomain_dir/amass_passive.old $subdomain_dir/amass_passive.txt "amass passive"
    
    ## Combine & Sort Brute Lists

    print_message "Sorting & Combining Subdomain Brute-Force Wordlists"

    sort -u ${brute_wordlists[*]} > /tmp/${org}_subdomain_brute_wordlist.txt
    brute_wordlist=/tmp/${org}_subdomain_brute_wordlist.txt

    ## Gobuster

    print_task "Running 'gobuster' (brute-force)" "${red}-->${reset} ./$(realpath --relative-to="." "$subdomain_dir/gobuster.txt")"
    [[ -f $subdomain_dir/gobuster.txt ]] && mv $subdomain_dir/gobuster.txt $subdomain_dir/gobuster.old

    gobuster dns -d $target -w $brute_wordlist -zq --no-error --no-color | cut -d ' ' -f 2 | probe | tee $subdomain_dir/gobuster.txt

    
    my_diff $subdomain_dir/gobuster.old $subdomain_dir/gobuster.txt "gobuster"

    ## Combining Files

    sort -u $subdomain_dir/crt_sh.txt $subdomain_dir/subfinder.txt $subdomain_dir/github_subdomains.txt $subdomain_dir/gobuster.txt | extract_url > $subdomain_dir/combined_temp.txt

    ## Subdomainizer

    print_task "Running 'subdomainizer'" "${red}-->${reset} ./$(realpath --relative-to="." "$subdomain_dir/subdomainizer.txt")"
    [[ -f $subdomain_dir/subdomainizer.txt ]] && mv $subdomain_dir/subdomainizer.txt $subdomain_dir/subdomainizer.old
    [[ -f $subdomain_dir/subdomainizer_info.txt ]] && mv $subdomain_dir/subdomainizer_info.txt $subdomain_dir/subdomainizer_info.old

    subdomainizer -l combined_temp.txt -gt $ghtoken -g -o subdomainizer.txt
    grep "Found some secrets(might be false positive)..." -A 1000 subdomainizer.txt | sed '/___End\ of\ Results__/d' > $leaks_dir/subdomainizer_info.txt

    my_diff $subdomain_dir/subdomainizer.old $subdomain_dir/subdomainizer.txt "subdomainizer"
    my_diff $subdomain_dir/subdomainizer_info.old $subdomain_dir/subdomainizer_info.txt "subdomainizer leaks"
    
    ## Combining Files

    sort -u $subdomain_dir/combined_temp.txt $subdomain_dir/subdomainizer.txt > $subdomain_dir/combined_subdomains.txt
    cat $subdomain_dir/combined_subdomains.txt | extract_url > $subdomain_dir/combined_subdomains_stripped.txt

    rm $subdomain_dir/combined_temp.txt

    ## Subfinder recusive

    print_task "Running 'subfinder recursive'" "${red}-->${reset} ./$(realpath --relative-to="." "$subdomain_dir/subfinder_recursive.txt")"
    [[ -f $subdomain_dir/subfinder_recursive.txt ]] && mv $subdomain_dir/subfinder_recursive.txt $subdomain_dir/subfinder_recursive.old

    subfinder -recursive -list combined_subdomains_stripped.txt -silent | sort -u | probe | tee $subdomain_dir/subfinder_recursive.txt

    my_diff $subdomain_dir/subfinder_recursive.old $subdomain_dir/subfinder_recursive.txt "subfinder recursive"

    ## Combining Files

    sort -u *_recursive.txt > combined_recursive.txt
    cat combined_recursive.txt | extract_url > combined_recursive_stripped.txt

    ## GoAltDNS

    print_task "Running 'goaltdns'" "${red}-->${reset} ./$(realpath --relative-to="." "$subdomain_dir/goaltdns.txt")"
    [[ -f $subdomain_dir/goaltdns.txt ]] && mv $subdomain_dir/goaltdns.txt $subdomain_dir/goaltdns.old
    
    goaltdns -l combined_recursive_stripped.txt -w $brute_wordlist | sort -u | probe | tee $subdomain_dir/goaltdns.txt

    my_diff $subdomain_dir/goaltdns.old $subdomain_dir/goaltdns.txt "goaltdns"

    ## Final Combanation

    sort -u goaltdns.txt combined_recursive.txt > final_subdomains.txt
    cat final_subdomains | extract_url > final_subdomains_stripped.txt

    ## New Subdomains

    if [[ -f $subdomain_dir/final_subdomains_stripped.old ]]; then
        cat $subdomain_dir/final_subdomains_stripped.txt | anew $subdomain_dir/final_subdomains_stripped.old -d > $subdomain_dir/new_subdomains.txt
    else
        cat $subdomain_dir/final_subdomains_stripped.txt > $subdomain_dir/new_subdomains.txt
    fi

    new_subdomain_count=$(wc -l "$subdomain_dir/new_subdomains.txt" | cut -d ' ' -f 1)

    send_to_discord "Discovered \`$new_subdomain_count\` **NEW** subdomains:" $subdomain_webhook "$subdomain_dir/new_subdomains.txt" 
    print_message "Discoverd $new_subdomain_count NEW subdomains" "${red}-->${reset} ./$(realpath --relative-to="." "$subdomain_dir/new_subdomains.txt")"
    
    cat $subdomain_dir/new_subdomains.txt

    ## Subdomain Takeovers

    print_task "Running 'dnsreaper' (subdomain takeover detection)" "${red}-->${reset} ./$(realpath --relative-to="." "$subdomain_dir/dnsreaper-takeovers.json")"
    [[ -r "$subdomain_dir/dnsreaper-takeovers.json" ]] && mv "$subdomain_dir/dnsreaper-takeovers.json" "$subdomain_dir/dnsreaper-takeovers.old"

    dnsreaper file --filename "$subdomain_dir/new_subdomains.txt" --out-format json --out "$subdomain_dir/dnsreaper-takeovers.old"

    my_diff "$subdomain_dir/dnsreaper-takeovers.old" "$subdomain_dir/dnsreaper-takeovers.json" $subdomain_webhook

    ## Time Taken

    end_seconds=$SECONDS
    execution_seconds=$((end_seconds - start_seconds))
    execution_time=$(date -u -d @${execution_seconds} +"%T")
    print_green "Completed Subdomain Recon: (Took ${yellow}$execution_time${reset})" "${red}-->${reset} ./$(realpath --relative-to="." "$subdomain_dir/final_subdomains.txt")"
    send_to_discord "**Completed** __Subdomain Recon__ in \`$execution_time\`\n- *Found \`$new_subdomain_count\` new subdomains*" $logs_webhook
}

subdomain_screenshot() {

    print_announce "TAKING SCREENSHOTS OF SUBDOMAINS"
    start_seconds=$SECONDS

    ## Take The Screenshots

    if [[ $(ls $screenshot_dir/*.png) ]]; then
        mv $screenshot_dir/*.png $screenshot_dir/old/
    fi

    if [[ -f $subdomain_dir/new_subdomains.txt && $(cat $subdomain_dir/new_subdomains.txt) ]]; then
        gowitness file -f $subdomain_dir/final_subdomains.txt --delay 3 --timeout 30 -P $screenshot_dir -D $screenshot_dir/
        

        for screenshot in $screenshot_dir/*.png; do
         print_message "Uploading Screenshot:" "$(basename $screenshot)"
            url="$(basename $screenshot | sed -e "s/.png//g" -e "s/http-/http:\/\//g" -e "s/https-/https:\/\//g")"
            send_to_discord "Screenshot of \`$url\`:" "$screenshot_webhook" "$screenshot"
        done
    else
        print_warning "No New Subdomains Found"
    fi

    ## Time Taken

    end_seconds=$SECONDS
    execution_seconds=$((end_seconds - start_seconds))
    execution_time=$(date -u -d @${execution_seconds} +"%T")
    print_green "Completed Screenshots of Subdomains (Took ${yellow}$execution_time${reset}${bold})" "${red}-->${reset} ./$(realpath --relative-to="." "$recon_dir/screenshots")"
    send_to_discord "**Completed** __taking Screenshots of Subdomains__ in \`$execution_time\`" $logs_webhook
}

services_recon() {

    print_announce "FINGERPRINT/SERVICE SCANNING"
    start_seconds=$SECONDS

    if [[ -f $subdomain_dir/new_subdomains.txt && $(cat $subdomain_dir/new_subdomains.txt) ]]; then
 
        ## WOHIS REPORT

        domains=($(awk -F "." '{print $(NF-1)"."$NF}' $subdomain_dir/new_subdomains.txt | sort -u))

        for url in "${domains[@]}"; do
            echo "==============>> $url WHOIS report <<=============="
            whois $url
            echo "\n\n\n"    
        done | tee $fingerprint_dir/new_whois_report.txt

        if [[ $service_webhook ]]; then
            print_message "Uploading:" "Whois Reports..."
            send_to_discord "**\`whois\`** report ($start_date)" $service_webhook "$fingerprint_dir/new_whois_report.txt"
        fi

        cat $fingerprint_dir/new_whois_report.txt >> $fingerprint_dir/whois_report.txt

        ## Extract IPs of URLs

        print_task "Extracting IP Addresses of Discovered Subdomains" "${red}-->${reset} ./$(realpath --relative-to="." "$fingerprint_dir/IPs.txt")"

        new_subdomains=($(cat $subdomain_dir/new_subdomains.txt))

        for url in "${new_subdomains[@]}"; do
            nslookup $url | grep "Address: " | head -1 | sed -e "s/Address:\ //"
        done | tee $fingerprint_dir/IPs.txt

        ## SHODAN

        print_task "Generating Shodan Report" "${red}-->${reset} ./$(realpath --relative-to="." "$fingerprint_dir/shodan_report.txt")"

        ips=($(cat $fingerprint_dir/IPs.txt))

        for i in "${!ips[@]}"; do
            echo -e "==============>> ${ips[$i]} (${new_subdomains[$i]}) report <<=============="
            shodan host "${ips[$i]}"
            echo -e "\n\n"
        done | tee $fingerprint_dir/new_shodan_report.txt

        if [[ $service_webhook ]]; then
            print_message "Uploading:" "Shodan Reports..."
            send_to_discord "**Shodan** report ($start_date)" $service_webhook "$fingerprint_dir/new_shodan_report.txt"
        fi

        cat $fingerprint_dir/new_shodan/report.txt >> $fingerprint_dir/shodan_report.txt

        ## NMAP

        print_task "Running Nmap Scans" "${red}-->${reset} ./$(realpath --relative-to="." "$fingerprint_dir/nmap_scans.txt")"

        nmap -p 0-10000 -sV -iL $fingerprint_dir/IPs.txt -oG nmap_scans_temp.txt

        sed '/#\ Nmap/d' nmap_scans_temp.txt | grep -v "Status: " > new_nmap_scans.txt
        rm nmap_scans_temp.txt

        if [[ $service_webhook ]]; then
            print_message "Uploading:" "Nmap Scans..."
            send_to_discord "**\`nmap\`** report ($start_date)" $service_webhook "$fingerprint_dir/new_nmap_scan.txt"
        fi

        cat new_nmap_scans.txt >> nmap_scans.txt

        ## Time Taken

        end_seconds=$SECONDS
        execution_seconds=$((end_seconds - start_seconds))
        execution_time=$(date -u -d @${execution_seconds} +"%T")
        print_green "Completed Fingerprint/Service Scan of Subdomains (Took ${yellow}$execution_time${reset}${bold})" "${red}-->${reset} ./$(realpath --relative-to="." "$recon_dir/screenshots")" 
        send_to_discord "**Completed** __Fingerprint/Service scanning__ in \`$execution_time\`" $logs_webhook       
    else
        print_warning "No New Subdomains Found"
    fi
}

deep_domain_recon() {

    print_announce "DEEP DOMAIN RECON"
    start_seconds=$SECONDS
    
    if [[ "${deep_domains[*]}" ]]; then
        start_seconds=$SECONDS
        
        for i in "${!deep_domains[@]}"; do

            domain="${deep_domains[$i]}"
            wordlist="${fuzz_wordlist[$i]}"
            [[ -d $deep_dir/$domain ]] || mkdir $deep_dir/$domain
            
            ## Wayback urls

            print_task "Running 'waybackurls' on '$domain'" "${red}-->${reset} ./$(realpath --relative-to="." "$deep_dir/$domain/waybackurls.txt")"
            [[ -f $deep_dir/$domain/waybackurls.txt ]] && mv $deep_dir/$domain/waybackurls.txt $deep_dir/$domain/waybackurls.old
        
            waybackurls $domain | tee $deep_dir/$domain/waybackurls.txt

            my_diff $deep_dir/$domain/waybackurls.old $deep_dir/$domain/waybackurls.txt "waybackurls" $deep_domain_webhook

            ## Feroxbuster dir brute-forcing

            print_task "Running 'feroxbuster' on '$domain'" "${red}-->${reset} ./$(realpath --relative-to="." "$deep_dir/$domain/feroxbuster.txt")"
            [[ -f $deep_dir/$domain/feroxbuster.txt ]] && mv $deep_dir/$domain/feroxbuster.txt $deep_dir/$domain/feroxbuster.old
        
            feroxbuster -u $domain -t 20 -L 20 -w ${fuzz_wordlist[$i]} -o $deep_dir/$domain/feroxbuster.txt
            echo ""

            my_diff $deep_dir/$domain/feroxbuster.old $deep_dir/$domain/feroxbuster.txt "feroxbuster" $deep_domain_webhook

            ## Combine files

            sort -u $deep_dir/$domain/feroxbuster.txt $deep_dir/$domain/waybackurls.txt | extract_url > $deep_dir/$domain/combined_deep_1.txt

            ## Scan js files for leaks

            print_task "Runing 'secretfinder' on '$domain'" "${red}-->${reset} ./$(realpath --relative-to="." "$deep_dir/$domain/secretfinder.html")"
            [[ -f $deep_dir/$domain/secretfinder.html ]] && mv $deep_dir/$domain/secretfinder.html $deep_dir/$domain/secretfinder.old 

            secretfinder -i $deep_dir/$domain/combined_deep_1.txt -e -o $deep_dir/$domain/secretfinder.html

            my_diff $deep_dir/$domain/secretfinder.old $deep_dir/$domain/secretfinder.html "SecretFinder.py" $deep_domain_webhook

        done

        ## Time Taken

        end_seconds=$SECONDS
        execution_seconds=$((end_seconds - start_seconds))
        execution_time=$(date -u -d @${execution_seconds} +"%T")
        print_green "Completed Deep Recon of Domains (Took ${yellow}$execution_time${reset}${bold})" "${red}-->${reset} ./$(realpath --relative-to="." "$deep_dir")"
        send_to_discord "**Completed** __Deep Recon of URLs__ in \`$execution_time\`" $logs_webhook
    else
        print_warning "No Deep Domains Defined"
    fi
    
}

leaks() {

    print_announce "SCANNING FOR LEAKS IN GITHUB/GITLAB REPOSITORIES"
    start_seconds=$SECONDS

    platforms=("GitHub" "GitLab")

    for platform in "${platforms[@]}"; do
        if [[ $platform = "GitHub" ]]; then
            g_leak_path=$github_leaks_dir
            recon_array=($github_recon)
            token=$ghtoken
        else
            g_leak_path=$gitlab_leaks_dir
            recon_array=($gitlab_recon)
            token=$gltoken
        fi

        if [[ $recon_array ]]; then
        
            users=()
            for url in "${recon_array[@]}"; do
                users+=($(echo $url | sed -e "s/https:\/\///g" -e "s/http:\/\///g" | cut -d '/' -f 2 | sort -u))
            done

            ## Gitrob

            if [[ $token ]]; then
                for user in "${users[@]}"; do
                    print_task "Running 'gitrob' on $platform user '$user'" "${red}-->${reset} ./$(realpath --relative-to=. $g_leak_path/)/gitrob_${user}.json"
                    [[ -r ${g_leak_path}/gitrob_${user}.json ]] && mv ${g_leak_path}/gitrob_${user}.json ${g_leak_path}/gitrob_${user}.json.old

                    cd $(dirname $(realpath $(which gitrob)))

                    if [[ $platform = "GitHub" ]]; then
                        gitrob -save ${g_leak_path}/gitrob_${user}.json -mode 2 -exit-on-finish -github-access-token $token $user
                    else
                        gitrob -save ${g_leak_path}/gitrob_${user}.json -mode 2 -exit-on-finish -gitlab-access-token $token $user
                    fi
                    
                    my_diff ${g_leak_path}/gitrob_${user}.json.old ${g_leak_path}/gitrob_${user}.json "gitrob ($user)" $leaks_webhook
                    
                    cd - &> /dev/null

                    ## Gitrob Findings

                    findings=$([[ -r ${g_leak_path}/gitrob_${user}.json ]] && jq .Findings ${g_leak_path}/gitrob_${user}.json)

                    if [[ ! $findings || $findings = "null" ]]; then
                        print_warning "No findings from 'gitrob'"
                    else
                        print_task "'gitrob' findings on $platform user '$user'" "${red}-->${reset} ./$(realpath --relative-to=. "${g_leak_path}"/)/gitrob_${user}_findings.json"

                        [[ -r ${g_leak_path}/gitrob_${user}_findings.json ]] && mv "${g_leak_path}/gitrob_${user}_findings.json" "${g_leak_path}/gitrob_${user}_findings.json.old"
                        echo $findings | jq . | tee ${g_leak_path}/gitrob_${user}_findings.json

                        my_diff ${g_leak_path}/gitrob_${user}_findings.json.old ${g_leak_path}/gitrob_${user}_findings.json "gitrob ($user)" $leaks_webhook
                    fi
                done

                ## Trufflehog

                for repo in "${recon_array[@]}"; do
                    filename="$(echo trufflehog_$(echo $repo | awk -F "/" '{print $(NF-1)"_"$NF}')).json"

                    print_task "Running 'trufflehog' on $platform repo '$repo'" "${red}-->${reset} ./$(realpath --relative-to=. $g_leak_path/)/$filename"
                    [[ -r $g_leak_path/$filename ]] && mv "$g_leak_path/$filename" "$g_leak_path/${filename}.old"

                    if [[ $platform = "GitHub" ]]; then
                        trufflehog_report=$(trufflehog github --token=$token --repo=$repo -j | jq .)
                    else
                        trufflehog_report=$(trufflehog gitlab --token=$token --repo=$repo -j | jq .)
                    fi

                    if [[ ! $trufflehog_report || $trufflehog_report = "null" ]]; then
                        print_warning "No report from trufflehog"
                    else
                        echo "$trufflehog_report" | jq . | tee "$g_leak_path/$filename"
                        my_diff "${g_leak_path}/${filename}.old" "${g_leak_path}/$filename" "trufflehog ($repo)" $leaks_webhook
                    fi
                done
            else
                print_error "No $platform token defined"
            fi
        else
            print_warning "No $platform repositories provided"
        fi
    done

    ## Time Taken

    end_seconds=$SECONDS
    execution_seconds=$((end_seconds - start_seconds))
    execution_time=$(date -u -d @${execution_seconds} +"%T")
    print_green "Completed Scan for Leaks (Took ${yellow}$execution_time${reset}${bold})" "${red}-->${reset} ./$(realpath --relative-to="." "$leaks_dir")"
    send_to_discord "**Completed** __Search for Leaks__ in \`$execution_time\`" $logs_webhook
}

init() {

    ## Check For Requirements
    
    if [[ ! "$target" ]]; then
        print_error "Missing target (-t|-target)"
    elif [[ ! "$ghtoken" ]]; then
        print_error "Missing GitHub Token (-ght|-github-token)"
    elif [[ ! "$input_brute_wordlist" ]]; then
        print_error "Missing wordlist for subdomain brute forcing (-b|-brute-wordlist)"
    fi

    if [[ ! "$path" ]]; then
        path=$(realpath .)
    fi

    org=$(echo $target | cut -d '.' -f 1)

    ## Brute Wordlist

    while read -r wordlist; do
        [[ -r $wordlist ]] || print_error "Can't read file '$wordlist'"
    done < <(echo $input_brute_wordlist | sed -e "s/\"//g" -e "s/,/\n/g")

    brute_wordlist=$(echo $input_brute_wordlist | sed 's/,/",\ "/g')

    ## Custom Attacks

    if [[ $custom_task ]]; then
        while read -r attack; do
            match=0
            for dtasks in ${default_tasks[*]}; do
                [[ $dtasks = "$attack" ]] && match=1
            done
            [[ $match = 1 ]] || print_error "Unknowon attack '$attack'"
        done < <(echo $custom_task | sed "s/,/\n/g")
        attack_method_json=$(echo \"$custom_task\" | sed "s/,/\",\ \"/g")
    else
        attack_method_json=$(echo \"${default_tasks[*]}\" | sed "s/\ /\",\ \"/g")
    fi

    ## Webhooks

    if ! [[ $subdomain_webhook && $screenshot_webhook && $service_webhook && $deep_domain_webhook && $leaks_webhook && $logs_webhook ]] && [[ $subdomain_webhook || $screenshot_webhook || $service_webhook || $deep_domain_webhook || $leaks_webhook || $logs_webhook ]]; then
        print_error "Must provide ALL webhook URLs (subdomain, service, deep_domain_recon, leaks, logs)"
    fi

    ## GitHub Recon

    if [[ $github_recon ]]; then
        github_recon_json=$(echo \"$github_recon\" | sed "s/,/\",\ \"/g")
    fi
    
    ## GitLab Recon

    if [[ $gitlab_recon ]]; then
        gitlab_recon_json=$(echo \"$gitlab_recon\" | sed "s/,/\",\ \"/g")
    fi

    ## Deep Domains

    if [[ ${deep_domains[*]} && ${fuzz_wordlist[*]} ]]; then
        deep_domains_json="$(echo "$(for i in "${!deep_domains[@]}"; do
                                 echo -n "{\"domain\": \"${deep_domains[$i]}\",\"wordlist\": \"${fuzz_wordlist[$i]}\"}"
                             done)" | sed "s/}{/},{/g")"
    fi

    ## Create Directories

    [[ -d "$path/${org}_recon" ]] || mkdir "$path/${org}_recon"
    [[ -d "$path/${org}_recon/subdomains" ]] || mkdir "$path/${org}_recon/subdomains"
    [[ -d "$path/${org}_recon/screenshots" ]] || mkdir "$path/${org}_recon/screenshots"
    [[ -d "$path/${org}_recon/screenshots/old" ]] || mkdir "$path/${org}_recon/screenshots/old"
    [[ -d "$path/${org}_recon/logs" ]] || mkdir "$path/${org}_recon/logs"
    [[ -d "$path/${org}_recon/leaks" ]] || mkdir "$path/${org}_recon/leaks"
    [[ -d "$path/${org}_recon/leaks/github/" ]] || mkdir "$path/${org}_recon/leaks/github"
    [[ -d "$path/${org}_recon/leaks/gitlab/" ]] || mkdir "$path/${org}_recon/leaks/gitlab"
    [[ -d "$path/${org}_recon/deep_domains" ]] || mkdir "$path/${org}_recon/deep_domains"
    [[ -d "$path/${org}_recon/fingerprint" ]] || mkdir "$path/${org}_recon/fingerprint"

    recon_dir="$path/${org}_recon"
    subdomain_dir="${recon_dir}/subdomains"
    screenshot_dir="${recon_dir}/screenshot"
    logs_dir="${recon_dir}/logs"
    leaks_dir="${recon_dir}/leaks"
    github_leaks_dir="${recon_dir}/leaks/gitlab"
    gitlab_leaks_dir="${recon_dir}/leaks/github"
    deep_dir="${recon_dir}/deep_domains"
    fingerprint_dir="${recon_dir}/fingerprint"
    config_file="${recon_dir}/${org}_config.json"

    ## Create JSON File
    
    jq -n "{
            config: {
                    target: \"$target\", 
                    recon_path: \"$recon_dir\", 
                    subdomain_brute_wordlist: [ 
                        \"$brute_wordlist\" 
                    ], 
                    deep_domains: [ 
                        $deep_domains_json
                    ], 
                    git: { 
                        token: { 
                            github: \"$ghtoken\",
                            gitlab: \"$gltoken\" 
                        }, 
                        github_recon: [ 
                            $github_recon_json
                        ], 
                        gitlab_recon: [ 
                            $gitlab_recon_json 
                        ]
                    },
                    attack_method: [ 
                        $attack_method_json
                    ],
                    webhooks: {
                        subdomain: \"$subdomain_webhook\",
                        screenshot: \"$screenshot_webhook\",
                        service: \"$service_webhook\",
                        deep_domain: \"$deep_domain_webhook\",
                        leaks: \"$leaks_webhook\",
                        logs: \"$logs_webhook\"
                    }
                }
            }" > ${config_file}.new


    if [[ -f $config_file ]]; then
        if [[ $(diff "$config_file" "${config_file}.new") = "" ]]; then 
            print_warning "An ${bold}identical${reset}${italic} configuration file exists (${underline}./$(realpath --relative-to=. $config_file)${reset}${italic}), overwrite?"
        else 
            print_warning "A configuration file exists (${underline}${config_file}${reset}${italic}), overwrite?"
        fi

        prompt "[Y/N]:"

        case $userinput in
            y|Y)
                print_warning "Overwriting..."
                mv "${config_file}.new" "${config_file}"
                ;;
            *)
                print_warning "Not overwriting..."
                ;;
        esac
    else
        mv "${config_file}.new" "${config_file}"
    fi

    print_message "JSON Configuration"

    jq . $config_file
}

config() {

    ## Check For Config File

    if [[ ! $config_file ]]; then
        print_error "Please provide a config file (-c|-config-file)"
    fi

    ## Make sure nano is standalone

    if [[ $target || $ghtoken || $deep_domains || $fuzz_wordlist || $input_brute_wordlist || $github_recon || $attack_method ]] && [[ $nano_it ]]; then
        print_error "-n|-nano is a standalone flag"
    fi

    ## Create a Temp Config File

    cp $config_file /tmp/temp_$(basename ${config_file})
    tmp_config_file=/tmp/temp_$(basename ${config_file})

    ## Nano It

    if [[ $nano_it ]]; then
        nano $tmp_config_file
    fi

    ## Change/Define Webhooks

    if [[ $subdomain_webhook ]]; then
        jq ".config.webhooks.subdomain = \"$subdomain_webhook\"" "${tmp_config_file}" > "${tmp_config_file}.tmp"
        mv "${tmp_config_file}.tmp" "${tmp_config_file}"
    fi
    
    if [[ $screenshot_webhook ]]; then
        jq ".config.webhooks.screenshot = \"$screenshot_webhook\"" "${tmp_config_file}" > "${tmp_config_file}.tmp"
        mv "${tmp_config_file}.tmp" "${tmp_config_file}"
    fi
    
    if [[ $service_webhook ]]; then
        jq ".config.webhooks.service = \"$service_webhook\"" "${tmp_config_file}" > "${tmp_config_file}.tmp"
        mv "${tmp_config_file}.tmp" "${tmp_config_file}"
    fi
    
    if [[ $deep_domain_webhook ]]; then
        jq ".config.webhooks.deep_domain = \"$deep_domain_webhook\"" "${tmp_config_file}" > "${tmp_config_file}.tmp"
        mv "${tmp_config_file}.tmp" "${tmp_config_file}"
    fi
    
    if [[ $leaks_webhook ]]; then
        jq ".config.webhooks.leaks = \"$leaks_webhook\"" "${tmp_config_file}" > "${tmp_config_file}.tmp"
        mv "${tmp_config_file}.tmp" "${tmp_config_file}"
    fi
    
    if [[ $logs_webhook ]]; then
        jq ".config.webhooks.logs = \"$logs_webhook\"" "${tmp_config_file}" > "${tmp_config_file}.tmp"
        mv "${tmp_config_file}.tmp" "${tmp_config_file}"
    fi

    ## Change Target

    if [[ $target ]]; then
        jq ".config.target = \"$target\"" "${tmp_config_file}" > "${tmp_config_file}.tmp"
        mv "${tmp_config_file}.tmp" "${tmp_config_file}"
    fi

    ## Change GitHub Token

    if [[ $ghtoken ]]; then
        jq ".config.git.token.github = \"$ghtoken\"" "${tmp_config_file}" > "${tmp_config_file}.tmp"
        mv "${tmp_config_file}.tmp" "${tmp_config_file}"
    fi

    ## Change GitHub Token

    if [[ $gltoken ]]; then
        jq ".config.git.token.gitlab = \"$gltoken\"" "${tmp_config_file}" > "${tmp_config_file}.tmp"
        mv "${tmp_config_file}.tmp" "${tmp_config_file}"
    fi

    ## Add Fuzz Domains

    if [[ "${deep_domains[*]}" && "${fuzz_wordlist[*]}" ]]; then

        print_message "${deep_domains[*]}\n${fuzz_wordlist[*]}"

        for i in "${!deep_domains[@]}"; do
            jq ".config.deep_domains += [{
                                            domain: \"${deep_domains[$i]}\",
                                            wordlist: \"${fuzz_wordlist[$i]}\" 
                                        }]" "${tmp_config_file}" > "${tmp_config_file}.tmp"
            mv "${tmp_config_file}.tmp" "${tmp_config_file}"
        done
    fi

    ## Add Brute-Force Wordlists

    if [[ $input_brute_wordlist ]]; then

        while read -r wordlist; do
            [[ -r $wordlist ]] || print_error "Can't read file '$wordlist'"
        done < <(echo $input_brute_wordlist | sed -e "s/\"//g" -e "s/,/\n/g")

        brute_wordlists=$(echo $input_brute_wordlist | sed 's/,/",\ "/g')
    
        jq ".config.subdomain_brute_wordlist += [ \"$brute_wordlists\" ]" "${tmp_config_file}" > "${tmp_config_file}.tmp"
        mv "${tmp_config_file}.tmp" "${tmp_config_file}"
    fi

    ## Add GitHub Repo For Recon

    if [[ $github_recon ]]; then
        
        github_recon_json=$(echo \"$github_recon\" | sed "s/,/\",\ \"/g")

        jq ".config.git.github_recon += [ $github_recon_json ]" "${tmp_config_file}" > "${tmp_config_file}.tmp"
        mv "${tmp_config_file}.tmp" "${tmp_config_file}"
    fi
    
    ## Add GitLab Repo For Recon

    if [[ $gitlab_recon ]]; then

        gitlab_recon_json=$(echo \"$gitlab_recon\" | sed "s/,/\",\ \"/g")

        jq ".config.git.gitlab_recon += [ $gitlab_recon_json ]" "${tmp_config_file}" > "${tmp_config_file}.tmp"
        mv "${tmp_config_file}.tmp" "${tmp_config_file}"
    fi

    ## Change Attack Method

    if [[ $attack_method ]]; then

        if [[ $attack_method = 'default' ]]; then
            attack_method_json=$(echo \"${default_tasks[*]}\" | sed "s/\ /\",\ \"/g")
        else
            while read -r attack; do
                    match=0
                for dtasks in ${default_tasks[*]}; do
                    [[ $dtasks = "$attack" ]] && match=1
                done
                [[ $match = 1 ]] || print_error "Unknowon attack '$attack'"
            done < <(echo $attack_method | sed "s/,/\n/g")
            attack_method_json=$(echo \"$attack_method\" | sed "s/,/\",\ \"/g")
        fi

        jq ".config.attack_method = [$attack_method_json]" "${tmp_config_file}" > "${tmp_config_file}.tmp"
        mv "${tmp_config_file}.tmp" "${tmp_config_file}"
    fi 
    
    if [[ $(jq . $tmp_config_file) ]]; then
        print_message "Current JSON Configuration"
        mv $tmp_config_file $config_file
        jq . $config_file
    else
        print_error "Error in JSON syntax, not writing changes" no_exit
    fi
}

recon() {
    for attack in ${attack_method[*]}; do
        if [[ $attack = "subdomain" ]]; then
            subdomain_recon
        elif [[ $attack = "screenshot" ]]; then
            subdomain_screenshot
        elif [[ $attack = "services" ]]; then
            services_recon
        elif [[ $attack = "deep_domains" ]]; then
            deep_domain_recon
        elif [[ $attack = "leaks" ]]; then
            leaks
        fi
    done
}

init_vars() {
    [[ $config_file ]] || print_error "Missing config file (-c|-config-file)"

    target=$(jq -r '.config.target' $config_file)
    brute_wordlists=($(jq -r '.config.subdomain_brute_wordlist[]' $config_file))

    ghtoken=$(jq -r '.config.git.token.github' $config_file)
    gltoken=$(jq -r '.config.git.token.gitlab' $config_file)
    github_recon=($(jq -r '.config.git.github_recon[]' $config_file))
    gitlab_recon=($(jq -r '.config.git.gitlab_recon[]' $config_file))

    deep_domains=($(jq -r '.config.deep_domains[].domain' $config_file))
    fuzz_wordlist=($(jq -r '.config.deep_domains[].wordlist' $config_file))

    attack_method=($(jq -r '.config.attack_method[]' $config_file))
    recon_dir=$(jq -r '.config.recon_path' $config_file)

    subdomain_webhook=$(jq -r '.config.webhooks.subdomain' $config_file)
    screenshot_webhook=$(jq -r '.config.webhooks.screenshot' $config_file)
    service_webhook=$(jq -r '.config.webhooks.service' $config_file)
    deep_domain_webhook=$(jq -r '.config.webhooks.deep_domain' $config_file)
    leaks_webhook=$(jq -r '.config.webhooks.leaks' $config_file)
    logs_webhook=$(jq -r '.config.webhooks.logs' $config_file)

    script_home=$(dirname $(realpath $0))
    org=$(echo $target | cut -d '.' -f 1)

    subdomain_dir="${recon_dir}/subdomains"
    screenshot_dir="${recon_dir}/screenshots"
    logs_dir="${recon_dir}/logs"
    leaks_dir="${recon_dir}/leaks"
    github_leaks_dir="${recon_dir}/leaks/github"
    gitlab_leaks_dir="${recon_dir}/leaks/gitlab"
    fingerprint_dir="${recon_dir}/fingerprint"
    deep_dir="${recon_dir}/deep_domains"

    if ! [[ -d $subdomain_dir || -d $screenshot_dir || $deep_dir || -d $logs_dir || -d $leaks_dir || -d $fingerprint_dir || -d $github_leaks_dir || -d $gitlab_leaks_dir ]]; then
        print_error "Please run 'init' function"
    fi
}

_test() {
    print_announce "TEST RUN"   
    start_seconds=$SECONDS
    # echo $subdomain_dir
    sleep 10
    end_seconds=$SECONDS
    execution_seconds=$((end_seconds - start_seconds))
    execution_time=$(date -u -d @${execution_seconds} +"%T")
    print_green "Test completed in ${yellow}$execution_time${reset}" "${red}-->${reset} ./tmp/example.txt"
}

main_run() {
    command=$1
    scan_name=$2

    init_vars

    start_date=$(my_date)
    logfile="$logs_dir/$scan_name ($start_date).log"
    
    {
    print_banner
    print_info
    if [[ $logs_webhook ]]; then
        print_message "Uploading Logs..."
    fi
    } |& tee "$logfile"
    
    send_to_discord "Log file for **$scan_name** scan at: \`$start_date\`" "$logs_webhook" "$logfile"
}

## Check dependencies

check_dependencies() {

    if [[ ! $(which discord.sh) ]]; then
        print_error "${bold}discord.sh${bold} (https://github.com/fieu/discord.sh) not found"
    fi

    if [[ ! $(which colordiff) ]]; then
        print_error "${bold}colordiff${reset} not found"
    fi    

    if [[ ! $(which xclip) ]]; then
        print_error "${bold}xclip${reset} not found"
    fi    

    if [[ ! $(which crt.sh) ]]; then
        print_error "${bold}crt.sh${reset} not found"
    fi    

    if [[ ! $(which subfinder) ]]; then
        print_error "${bold}subfinder${reset} not found"
    fi    

    if [[ ! $(which github-subdomains) ]]; then
        print_error "${bold}github-subdomains${reset} not found"
    fi    

    if [[ ! $(which gobuster) ]]; then
        print_error "${bold}gobuster${reset} not found"
    fi    

    if [[ ! $(which httprobe) ]]; then
        print_error "${bold}httprobe${reset} not found"
    fi    

    if [[ ! $(which gobuster) ]]; then
        print_error "${bold}gobuster${reset} not found"
    fi    

    if [[ ! $(which subdomainizer) ]]; then
        print_error "${bold}subdomainizer${reset} not found"
    fi    

    if [[ ! $(which goaltdns) ]]; then
        print_error "${bold}goaltdns${reset} not found"
    fi    

    if [[ ! $(which anew) ]]; then
        print_error "${bold}anew${reset} not found"
    fi    

    if [[ ! $(which gowitness) ]]; then
        print_error "${bold}gowitness${reset} not found"
    fi    

    if [[ ! $(which whois) ]]; then
        print_error "${bold}whois${reset} not found"
    fi    

    if [[ ! $(which nslookup) ]]; then
        print_error "${bold}nslookup${reset} not found"
    fi    

    if [[ ! $(which shodan) ]]; then
        print_error "${bold}shodan${reset} not found"

        if [[ ! $(shodan info &> /dev/null) ]]; then
            print_error "Please configure ${bold}shodan${reset} by running 'shodan init <api key>'"
        fi
    fi

    if [[ ! $(which nmap) ]]; then
        print_error "${bold}nmap${reset} not found"
    fi
    
    if [[ ! $(which waybackurls) ]]; then
        print_error "${bold}waybackurls${reset} not found"
    fi
    
    if [[ ! $(which feroxbuster) ]]; then
        print_error "${bold}feroxbuster${reset} not found"
    fi
    
    if [[ ! $(which gitrob) ]]; then
        print_error "${bold}gitrob${reset} not found"
    fi
    
    if [[ ! $(which trufflehog) ]]; then
        print_error "${bold}trufflehog${reset} not found"
    fi
    
    if [[ ! $(which jq) ]]; then
        print_error "${bold}jq${reset} not found"
    fi

    if [[ ! $(which secretfinder) ]]; then
        print_error "${bold}secretfinder${reset} not found"
    fi
    
    if [[ ! $(which dnsreaper) ]]; then
        print_error "${bold}dnsreaper${reset} not found"
    fi
    
}

## Run functions based on flags

check_dependencies

flags "$@"

case $mode in
    init)
        print_banner
        print_info
        init
        ;;
    config)
        print_banner
        print_info
        config
        ;;
    recon)
        main_run recon "Complete Recon"
        ;;
    subdomain)
        main_run subdomain_recon "Subdomain Recon"
        ;;
    screenshot)
        main_run subdomain_screenshot "Screenshots of Subdomains"
        ;;
    deep)
        main_run deep_domain_recon "Deep Domain Recon"
        ;;
    leaks)
        main_run leaks "Leaks"
        ;;
    gdork)
        init_vars
        print_banner
        print_info
        github_dorking_links
        ;;
    test)
        main_run _test "Test"
        ;;
    *)
        print_error "Invalid mode \"${mode}\"!"
        ;;
esac