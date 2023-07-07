# My BBH scripts

## `misconceived_bounty.sh` (recon)

**Usage:**
```bash
Usage: ./misconceived_bounty.sh target.com GITHUB_TOKEN [exclude grep regex]
```
So far, this script does the following:

1. Echo's out github dorking links (Idea came from Jason Haddix's hunter script)
2. Runs `subfinder` against the target domain
3. Runs `shuffledns` against the target domain to brute force for subdomains
4. Runs `amass` in passive mode
5. Runs [github-search](https://github.com/gwen001/github-search/)/github-subdomains.py (by [@gwen001](https://github.com/gwen001)) against the target domain
6. Runs `subfinder` in recursive mode
7. Runs `goaltdns` against all the previous outputs to alternate the subdomain names
8. Combines all the lists and cleans them:
   - Excludes everything chosen in the regex provided
   - Removes duplicates and sorts the list
   - Parses the subdomains into `httprobe` to make sure they are hosting HTTP
9. Runs `gowitness` on all the subdomains