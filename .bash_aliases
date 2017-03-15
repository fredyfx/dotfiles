# Drupal Console
if [[ -f ~/.console/console.rc ]]; then
    . ~/.console/console.rc 2>/dev/null;
fi

# Add git completion.
if [[ -f ~/git-completion.bash ]]; then
    . ~/git-completion.bash;
fi

# Aliases
alias phpstorm='echo vadead | sudo -S bash /media/va/52AF7EBE182A63E2/jetbrains/PhpStorm/bin/phpstorm.sh';
alias pycharm='echo vadead | sudo -S bash /media/va/52AF7EBE182A63E2/jetbrains/PyCharm/bin/pycharm.sh';
alias localhost='cd /var/www/html';
alias permissions='sudo chown -R www-data:www-data ../public_html && sudo chmod -R 777 sites/default/files';

alias tsini='cd /var/www/html/vhosts/tsinikopoulos/public_html/';
alias tsinigulp='cd /var/www/html/vhosts/tsinikopoulos/public_html/sites/all/themes/tsinikopoulos && sudo find /usr/lib/node_modules -type f -name "*.info" -exec sudo rm "{}" \+ && modules=$(ls /usr/lib/node_modules) && npm link $modules && gulp';

alias drupaland='cd /var/www/html/vhosts/drupaland/public_html/';
alias drupalandgulp='cd /var/www/html/vhosts/drupaland/public_html/themes/drupaland && sudo find /usr/lib/node_modules -type f -name "*.info" -exec sudo rm "{}" \+ && modules=$(ls /usr/lib/node_modules) && npm link $modules && gulp';

alias rs='cd /var/www/html/vhosts/rigging/public_html/';
alias rsgulp='cd /var/www/html/vhosts/rigging/public_html/sites/all/themes/skeletontheme_testing && sudo find /usr/lib/node_modules -type f -name "*.info" -exec sudo rm "{}" \+ && modules=$(ls /usr/lib/node_modules) && npm link $modules && gulp';

alias bnspro='cd /var/www/html/vhosts/bnspro/public_html/';
alias bnsprogulp='cd /var/www/html/vhosts/bnspro/public_html/ && sudo find /usr/lib/node_modules -type f -name "*.info" -exec sudo rm "{}" \+ && modules=$(ls /usr/lib/node_modules) && npm link $modules && gulp';

alias enalia='cd /var/www/html/vhosts/enalia/public_html/';
# alias enaliagulp='cd /var/www/html/vhosts/enalia/public_html/themes/custom/enalia_classy/ && sudo find /usr/lib/node_modules -type f -name "*.info" -exec sudo rm "{}" \+ && modules=$(ls /usr/lib/node_modules) && npm link $modules && gulp';
alias enaliagulp='cd /var/www/html/vhosts/enalia/public_html/themes/enalia/ && sudo find /usr/lib/node_modules -type f -name "*.info" -exec sudo rm "{}" \+ && modules=$(ls /usr/lib/node_modules) && npm link $modules && gulp';

alias update='echo vadead | sudo -S bash ~/bin/update.sh';

# Git stuff:
alias gc='git commit --signoff -m ';
# alias gl='git log --pretty=format:"%h, %ar: %s"'
alias gl='git log --oneline';
alias gcf='git checkout -- ';
alias gs='git status';
alias gba='git branch --all';
alias grh='git reset --hard';
alias ga='git add ';
alias git-show-tracked-files='git ls-tree --full-tree -r --name-only HEAD';
alias gstf='git-show-tracked-files';

# Postgresql
alias 'psql'='sudo -u postgres psql';

# Report from git log.
function git-log-report() {
    if [[ "$1" ]]; then
        git log --since="$1" --no-merges --date=format:'%Y-%m-%d, %H:%M' --format='%ad: %s.' > report.txt;
        sed -i 's|\([0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}\)\(, \)\([0-9]\{2\}:[0-9]\{2\}\)\(: \)\(.*\)|Date: \1 on \3. Task: \5|g' report.txt;
        echo "";
        echo "\"report.txt\" is ready.";
    else
        echo 'Usage: git-create-report <date>';
    fi
}

# Create a patch (diff) file, for only the tracked files of the repository.
# Useful when the master branch tracks for files than the current branch.
function git-diff-master() {
    alias git-show-tracked-files='git ls-tree --full-tree -r --name-only HEAD';
    for file in $(git-show-tracked-files); do
        # Make sure you skip .gitignore.
        if [[ ! $file = '.gitignore'  ]]; then
            git diff master $file >> $(git rev-parse --abbrev-ref HEAD).patch;
        fi
    done
}
# Create a formatted git patch.
function git-patch-formatted() {
    if [[ $1 && $2 ]]; then
        branchName="$1";
        patchName="$2";
        # Remove a pre-existing patch.
        rm "${patchName}".patch 2> /dev/null;
        git format-patch --binary "${branchName}" --stdout > "${patchName}".patch;
        # Removing the last unnecessary line. Act only after the "--" line.
        sed -i '/^--/,$ {/windows/d}' "${patchName}".patch;
        echo "The ${patchName}.patch was created successfully.";
    else
        echo "Usage: git-format branchName patchName";
    fi
}
# Delete local and remote branch.
# Delete local and remote branch.
function git-delete-branch() {
    if [[ $1 ]]; then
            git checkout master > /dev/null;
        branch_name="$1";
            echo "Deleting local $branch_name branch...";
        git branch -D "$branch_name";
            echo "Deleting remote $branch_name branch...";
        git push origin --delete "$branch_name";
            echo "Your current branches are:";
            git branch -a;
    else
        echo "Usage: git-delete-branch <branch_name>"
    fi
}

# Site audit stuff:
alias siteaudit7='rm -r ~/.drush/commands/site_audit && unzip ~/.drush/commands/site_audit-7*.zip -d ~/.drush/commands/';
alias siteaudit8='rm -r ~/.drush/commands/site_audit && unzip ~/.drush/commands/site_audit-8*.zip -d ~/.drush/commands/';

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# Include Drush bash customizations.
if [ -f "/root/.drush/drush.bashrc" ] ; then
  source /root/.drush/drush.bashrc
fi

# Include Drush completion.
if [ -f "/root/.drush/drush.complete.sh" ] ; then
  source /root/.drush/drush.complete.sh
fi

# Include Drush prompt customizations.
if [ -f "/root/.drush/drush.prompt.sh" ] ; then
  source /root/.drush/drush.prompt.sh
fi

# General functions.
# Create a report from a GA csv.
function google-analytics-report() {
    if [[ $1 ]]; then
        sourceFile="$1";
        cat "$sourceFile" | awk -F ',' '{print $1, $2}' | sed "s|/el/άρθρα/|Άρθρο: |g;s|\(\ \)\([0-9]\{1,3\}\)|\. Θεάσεις: \2\.|g" > article_views.txt;
        echo "The article_views.txt was created successfully.";
    else
        echo "Usage: google_analytics_report sourceFile";
    fi
}

# Display the free space remaining in the Linux partition.
function disk-usage() {
    disk_usage=$(df | head -n 2 | tail -n 1);
    if [[ $(uname) == "MINGW"* ]]; then
        echo "Disk usage ($(echo $disk_usage | awk '{ print $1 }')): $(echo $disk_usage | awk '{ print $6 }').";
    else
        echo "Disk usage ($(echo $disk_usage | awk '{ print $1 }')): $(echo $disk_usage | awk '{ print $5 }').";
        # echo "Disk usage ($(df | head -n 2 | tail -n 1 | awk '{ print $1 }')): $(df | head -n 2 | tail -n 1 | awk '{ print $5 }').";
    fi
}

# Function that pipes to less by default.
function cat-less() {
    if [[ -f $1 ]]; then
        cat $1 | less;
    else
        echo "Usage: cat fileName";
    fi
}

function restore-permissions-folders-files() {
    # Directories.
    find . -type d -exec chmod 775 {} \;
    # Files.
    find . -type f -exec chmod 644 {} \;
}

function docker-clean() {
    docker stop *;
    docker rm -f $(docker ps -a -q);
    docker rmi -f $(docker images --quiet); # -q, --quiet Only show numeric ID
}


# Fix "The following module is missing from the file system..."
# See: https://www.drupal.org/node/2487215
function drupal-fix-missing-module() {
    if [[ $1 ]]; then
        drush sql-query "DELETE from system where name = '"$1"' AND type = 'module';";
    else
        echo "Usage: drupal-fix-missing-module <moduleName>";
    fi
}

function Dropbox-import-dbs() {
    cd  /home/va/Dropbox/dbs/*/;
    for db in *; do
        new_db=$( echo "$db" | sed "s|/home/va/Dropbox/dbs/.*/||g; s|\.sql\.gz||g");
        mysql -u root -p'root' -e "CREATE DATABASE IF NOT EXISTS $new_db;";
        zcat "${new_db}.sql.gz" | mysql -u root -p'root' "$new_db";
    done;
    cd ~;
}

# Vhosts
function vhost-create() {
    if [[ ! -d '/var/www/html/vhosts/' ]]; then
        sudo mkdir /var/www/html/vhosts/;
    fi

    if [[ "$1" ]]; then
      base_path='/var/www/html/vhosts';
      domain="$1";

      if [[ ! -d "${base_path}/${domain}" ]]; then
        sudo mkdir "${base_path}/${domain}";
        sudo mkdir "${base_path}/${domain}/public_html/";
        sudo mkdir "${base_path}/${domain}/logs/";
        # Create an index file.
        echo "<h1>${domain}.local has been created successfully.</h1>" | sudo tee "${base_path}/${domain}/public_html/index.html";

        # Create the Apache config files.
        echo "
<VirtualHost *:80>
    # Enable the site with sudo a2ensite site_name && sudo /etc/init.d/apache2 restart
    ServerName ${domain}.local
    ServerAlias www.${domain}.local
    ServerAdmin ${domain}@localhost
    DocumentRoot /var/www/html/vhosts/${domain}/public_html
    <Directory /var/www/html/vhosts/${domain}/public_html/>
      Options Indexes FollowSymLinks
      AllowOverride All
      Require all granted
    </Directory>
    LogLevel info warn
    ErrorLog /var/www/html/vhosts/${domain}/logs/error.log
    CustomLog /var/www/html/vhosts/${domain}/logs/access.log combined
</VirtualHost>" | sudo tee "/etc/apache2/sites-available/${domain}.local.conf";


        # vim: syntax=apache ts=4 sw=4 sts=4 sr noet
        # See: http://stackoverflow.com/questions/84882/sudo-echo-something-etc-privilegedfile-doesnt-work-is-there-an-alterna
        # echo 'hello' | sudo tee /etc/apache2/sites-available/hello.txt


          # Enable the site.
          sudo a2ensite "${domain}.local";

          echo "127.0.0.1   ${domain}.local" | sudo tee --append /etc/hosts;

          # Restart Apache.
          sudo service apache2 restart;

          echo "Done.";
          echo "You can access the site at http://${domain}.local/";
      else
        echo "${domain} already exists. Skipping...";
      fi
    else
      echo "Usage: vhost-create <hostName>"
    fi
}

function vhost-delete() {
    # Todo: Delete from /etc/hosts
    if [[ "$1" ]]; then
        vhost="$1";

        if [[ -d "/var/www/html/vhosts/${vhost}" ]]; then
	        # Disable the vhost.
	        sudo a2dissite "${vhost}.local";

            # Delete all files associated with this site.
            sudo rm -r /var/www/html/vhosts/${vhost};
            sudo rm "/etc/apache2/sites-available/${vhost}.local.conf";

            # Clean the /etc/hosts
            sudo sed -i "/${vhost}/d" /etc/hosts;

            # Restart Apache.
            sudo service apache2 restart;
            echo "The ${vhost}.local vhost was deleted successfully.";
            echo "Apache was restarted. All set.";
        else
            echo "No such vhost found.";
        fi
    else
        echo "Usage: vhost-delete <hostName>"
    fi
}

function bitbucket-clone-dev-sites() {
    # Todo: Create and loop array.
    for site in tsinikopoulos drupaland riggingservices; do
        vhost-create "$site";
        cd "/var/www/html/vhosts/${site}";
        sudo rm -rf public_html;
        sudo git clone "git@bitbucket.org:drz4007/${site}.git" public_html;
        sudo chown -R www-data:www-data public_html/;
    done
}