if [[ $# -lt 1 ]]
then
    echo "Usage: $0 your_pixiv_id [your_pixiv_password]"
    exit 1
fi
if [[ $# -eq 1 ]]
then
    read -s -p "Enter your Pixiv ID Password: " PASSWORD
    echo
else
    PASSWORD=$2
fi

USERNAME=$1

 echo "Logging in with ${1}..."
 login_page=$(curl --cookie-jar .cjar https://accounts.pixiv.net/login 2> /dev/null)
 post_key_regex='name="post_key" value="([a-z0-9]+)"'

 if [[ $login_page =~ $post_key_regex ]]
 then
     post_key="${BASH_REMATCH[1]}"
     post_data="pixiv_id=${USERNAME}&password=${PASSWORD}&post_key=${post_key}"
 fi

 curl --cookie .cjar --cookie-jar .cjar https://accounts.pixiv.net/login -d $post_data > /dev/null 2>&1
 echo "Done."
