# MC Automatic Backups

## Usage and Background:
MC Automatic Backups is a set of bash scripts designed to automate bringing down a Minecraft server, backing up the files, and restarting the server. I created this because I have my server running on old hardware and if it hard crashes, I want backups in case of world file corruption.
This script provides a warning to players on the MC server of an outage, waits 5 minutes, then shuts down the MC server and copies all files in the MC server directory to a subfolder of the target directory. This subfolder is named the current date in format yyyy-mm-dd. The process will then look for folders in the target directory with names older than 30 days (by default, configurable) and delete those. The the server is started again. 

At certain points, the script writes to the log file. If old backups are deleted, the log will indicate which one(s).

#### How to configure:
1. Configure config.txt
    - !Use absolute file paths.
2. Start MC server using start_server.sh.
3. Run automatic_backup.sh to test and create initial backup.
4. Schedule automatic_backup.sh to run automatically at a given interval greater than or equal to daily.
    - Cronjobs work great.

#### Notes:
This script does not delete files in the source directory however, it's always a good idea to backup your files prior to trying some random script off the internet.
I recommend using this start_server.sh script to start your server before running the backup since it looks for a hardcoded screen name ("minecraft").

## Future Plans:
- Allow for more frequent intervals than daily.
- Allow use of different stop/start scripts.
- Add "try/catch" logic to log errors, kinda.
- Additional configuration items.