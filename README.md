# Sentrifugo Hrm
Open source Hrm tool for office management


## db details ###
      MYSQL_HOST: db
      MYSQL_ROOT_USER: root
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: sentrifugo
      
### Code to deploy ###
      docker-compose up -d
      Complete the configuration at localhost:8080/
      
### Final step ###

      docker exec -it <docker id> bash
Rename the 'install' folder to any name after completing the configuration for getting the login page.  


## Notes ##

### Major Bug

1. Once you proceed through the initial setup steps of Sentrifugo, it is supposed to delete/rename
the `/sentrifugo/install/index.php`. This will make `sentrifugo-url/index.php` actually *execute* instead of redirecting
you to install everytime.

Here's the chunk of code inside index.php:

```
$filepath = 'install/index.php';
if(file_exists($filepath))
{
header("Location: install/index.php");
}else
```

However, the deletion doesn't happen, so you always get redirected to installation.

Therefore, *after you complete initial setup of Sentrifugo*:
1. SSH to the Docker container `sentrifugo-app`.
1. Rename the `/sentrifugo/install/` dir to something else.
1. Verify that going to `<sentrifugo-url>/index.php` takes you to the login page.
