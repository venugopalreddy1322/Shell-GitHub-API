# Shell script to list the collaborators/users of a Repository in GitHub Organization
.   Here in this script listing the admins and users of a Repository, you can modify according to your requirements.
.   I used the official GitHub RestAPI documentaion to write the script.
.   Provided the username and Auth token of GitHub account  using 'export' in the commandprompt.
.    Giving Repo owner, and name details as cmd_args to the script at run-time.
. The function retuns the result in json format so I used JsonParquet 'jq' to filter the result. - need to import it before using.
.   helper function to make sure pass exactly 2 command line arguements while execution 

