Welcome to thebridge, a member of the CQiNet family.

http://CQiNet.sourceforge.net

Thebridge is an EchoLink compatible conference bridge that runs under 
FreeBSD, Linux, QNX, Mac OS X, Windows and hopefully most other Posix 
compatible operating systems.

If you've never hear of EchoLink then this software probably won't make 
much sense to you.  See: http://www.echolink.org then if you are still 
interested continue here.

The EchoLink system, and by extension this software, are for Ham radio 
operators.  Unfortunately unlike "real" Ham Radio SWLs (short wave 
listeners) are not welcomed so if you're not already a licensed ham it is
unlikely that you will find much of value here, sorry.

If you haven't given up yet but are running *nix and not Windows you are lost,
read the file README instead of this one.


############################################
Updating from previous versions of thebridge
############################################

New versions of thebridge are usually backwards compatible with configuration 
files from earlier releases HOWEVER new variables are added frequently.  Since 
the sample tbd.conf file includes documentation on some features which are 
not mentioned elsewhere it is worthwhile to review the sample configuration 
file with each release to discover new capabilities which you may want to 
take advantage of.  


###########
Portability
###########

A quick word on portability:  I have not attempted to build thebridge on 
Windows using any tools other than Microsoft Visual Studio version 5 or 6.
It shouldn't be too hard to get it to build with other tools if an 
appropriate makefile or project file is created. Make sure the symbol
"_WIN32" is defined.  If you get it running using another tool chain I 
would be interested in hearing about it.


###################
Building on Windows
###################

If you've downloaded the prebuilt version of thebridge (thebridge-x.xx-exe.zip)
the following has already been done for you.  Skip on to configuration...

Extract:
The distrubution file is a Gzip'ed TAR file.  The popular Winzip program
knows how to deal with these kind of files. If you don't have it you can 
download an evaluation copy from www.winzip.com.  When you extract the 
files make sure you preserve the directory structure.  (In Winzip make 
sure the "Use folder names" box is checked.

Make:
Find thebridge.dsp using Windows explorer and double click on it.  This should
cause Microsoft Visual Studio to fire up and load the project.  Click build.
There shouldn't be any errors or warnings displayed during the build process.
If you get warnings or errors I'd be interested in hearing about them.  

The final output of the build process is the thebridge deamon "tbd.exe" which
will be in either the Debug or Release subdirectory depending on the build 
configuration you selected.  The name of thebridge executable is tbd.exe for 
"TheBridge Daemon (and it's also a good excuse to create yet another TLA).  

Well It's a Daemon on *nix systems anyway, on Windows it may be installed
as a Daemon (service) on Windows 2000 or Windows XP, otherwise it's run as
a command line program.  This does not mean that it will run on DOS, thebridge
is a 32bit Windows program. Thebridge uses the Winsock2 API, if the EchoLink 
client program runs on your computer you should be all set.  If your computer 
runs an old version of Windows 95 you may need to upgrade to Winsock2.  


#######################
thebridge Configuration
#######################

There is a single text file "tbd.conf" that is used to configure thebridge.  
Fire up your favorite editor and change the various variables to appropriate 
values.  Refer to the comments in the file for guidance.  

Most sites will only need to change the ConferenceCall, ConferencePass, 
ConferenceQth and WorkingDir settings. 

NOTE: the EchoLink directory servers *WILL NOT ACCEPT* a conference style 
callsign like "*W1AW*" unless you have specifically registered as a conference 
by the EchoLink administrators. I suggest that you test the conference 
using your usual callsign first. See www.echolink.org/el/conf.htm for more 
details.

Lines beginning with ';' or '#' are comments, if you decide to set any of the
optional settings be sure to delete leading ';' character before the 
configuration variable.

--- snip ---
C:\thebridge-0.05> notepad tbd.conf
--- snip ---

What, notepad isn't your favorite editor ?  Nevermind.


#######
Testing
#######

The daemon has two command line switches to aid testing.  The first switch -f
specifies where the configuration is located.  The default is tbd.conf in 
the current directory.

The second switch -d enables debug mode, causing the program to output debug 
information to the screen.  The debug switch may be used multiple times to 
increase the detail level of the information displayed up to a maximum of 
twice.

--- snip ---
C:\thebridge-0.05\debug>tbd
thebridge Version 0.05
PullerLoginAck(): Client 2 successfully updated status.
ParseStationList(): completed successfully, 376 stations listed.
--- snip ---

The first message indicates that the daemon was successful in logging into the
directory server.  Note: the EchoLink servers indicate a successful login
even if the supplied callsign/password combination is unknown, invalid or 
banned.  But the success does indicate that tbd was able to establish an TCP
connection to the server.

The second message is the real good news, our directory request returned 376 
stations.  If your callsign or password were not recognized there would be
0 stations.

If you are not able to get a station list, check the configuration file.  You
might also want to rerun the test using some "-d" switches to help determine
what when wrong.

Unfortunately, due to the nature of the EchoLink protocols it is not
possible to test thebridge further using a single computer.  In particular 
the client program uses the same ports as the server so it's impossible to run
a server and a client on the same host at the same time.  

Even if you have multiple computers you can't test the program unless you also 
have multiple *external, routable* IP addresses.  You can't connect to 
thebridge from another computer on your local LAN if your local LAN is 
connected to the Internet using a NAT box or other form of Internet sharing 
where all of your computers appear to be coming from the same IP address.

The easiest way to complete the testing is to have a couple of friends connect
to thebridge and see if they can talk to each other.  When a station connects
to thebridge you'll see a message similar to the following:

--- snip ---
WD4NMQ           JEFF logged into conference.
W7NTF            GARY logged into conference.
--- snip ---

Once you've verified that thebridge is operating correctly we're ready to 
complete the installation.  Hit Ctrl-C to abort thebridge.

--- snip ---
Received SIGINT, shutting down
PullerLoginAck(): Client 4 successfully updated status.
Logged out, exiting.
C:\thebridge-0.05>
--- snip ---


#######################
Installation as Service
#######################

Installing thebridge as a system service is an option on Windows 2000 and 
XP.  A service is a program that runs in the background without any 
visible component that can also be configured to start automatically when 
the system is booted.  Running thebridge as a service is particularly 
attractive when thebridge is run on a remote server.  I've only tested 
thebridge on Windows 2000, but it should run on Windows NT 4.0 and XP as 
well.  

Once you have configured and tested thebridge you can install it as 
service by specify using the -w and -i command line switches.  The working 
directory must be specified first followed by the -i switch.  

--- snip ---
C:\thebridge-0.05> tbd -w c:\thebridge-0.05 -i
tbd service installed successfully.
C:\thebridge-0.05> 
--- snip ---

Once the service has been installed it may be started using the services applet
located under administrative tools on the control panel.  As you may have 
already guessed thebridge is listed as "tbd".  To start thebridge running
double click on it's name and then click the start button.  Once tbd is
running examine the log and make sure there are no error messages.  You will 
find the log file(s) in the working directory specified when the service 
was installed.

If you want thebridge to start automatically when the system is booted change
the startup time from "Manual" to "Automatic".

You may uninstall the service by using the -u switch.

--- snip ---
C:\thebridge-0.05> tbd -u
tbd service uninstalled.
C:\thebridge-0.05> 
--- snip ---


#############
User Commands
#############

A few commands are available to users that are unique to thebridge.  Commands
are entered on the message line in the same way as a text message, by 
prepending a '.' (period).  Commands are not forwarded to other conference 
users so they are non-intrusive to normal operations.  The command must begin
at the first character on the line.

Commands may be abbreviated to the shortest length that is still unique.  For
example ".stat", ".sta", and ".st" are valid abbreviations for the 
".stats" command, but not ".s" since there are two commands that start with 
the letter 's' (.stats and .sysop).

".help" and ".?"
 
This command does much as you would guess, it lists the available commands.

".list"  (not available on all conferences)

This command lists any bulletins or recorded nets that may be available to 
be played back.  

".lookup <callsign>"

This commands displays the node number, Qth and busy status for a specified
station.  The station must be online or have been online recently for the
information to be available.

".play <bulletin #>", ".stop"   (not available on all conferences)

This command starts playing the selected bulletin or recording.  Any text 
messages that were sent during a net are also replayed sent.  While you are in 
playback mode you will not be listed on the station list of thebridge and 
you will not receive any live conference traffic, voice or text.  To end the
playback enter the .stop command or simply disconnect.

".showip"

This command dumps the user list with IP addresses.  
Format: <callsign> <tab> <IP address> <tab> <'S' | 'R' | 'E'><eol>
The list is terminate by a blank line.  The final character indicates the
users protocol, SpeakFreely, RTP, or EchoLink.  The callsign field will
also contain the user's IP address if the protocol does not provide a callsign.

".stats"

This commands displays interesting (to some) technical statistics about 
the operation of the conference bridge such as when the maximum number of 
users were connected.  

".lurk" and ".delurk" (not available on all conferences)

The EchoLink system is very different than "real" radio in one important way...
everyone knows who is listening.  Sometimes you might only want to monitor a 
channel, but not get involved in a conversation.  This is particularly useful 
for nets when you want to listen, but don't have anything to contribute.
The ".lurk" command allow you to suppress the listing of your callsign as an
active member of the conference, but you will still be able to listen.  You
can rejoin the conference at any time by using the ".delurk" command or by 
simply transmitting.

".uptime"

This command displays the amount of time thebridge has been running since it
was loaded.  I'll admit it, the primary purpose is for bragging rights... "my
conference bridge has been up for ..."

".version"

This command displays the version of thebridge software and the type
of operating system it's running on.

".test"  (not available on all conferences)

This command causes thebridge to record your next transmission and then play
it back to you when you stop transmitting.  This allows you to test your setup
and adjust audio levels etc without assistance.  Audio quality is a very 
subjective thing, it's always best to hear it yourself.  

Note: The UDP protocol used for conferencing is not 100% reliable, the 
".test" command will send you the response "Your next transmission will 
be recorded and played back." to  indicate that your command was received.  
Please do *NOT* make a long test transmission unless you receive the response!  
Otherwise your test transmission will be sent live over the conference bridge.


##############
Sysop Commands
##############

".sysop <password>"

None of the sysop commands are available until you identify yourself as 
an sysop by using the .sysop command and supplying the sysop's password.  
Additionally sysop's are allowed to transmit during the pausetime to give
them slightly higher priority on the channel than normal users.

When using this command please *make* sure that you enter the leading '.' and 
start the command at the beginning of the line, otherwise you may send the 
sysop's password to everyone logged into the conference!  

Once you have logged in successfully you will be greeted with a welcome 
message.  You will remain logged in as an sysop only as long as you are 
connected to thebridge, if you disconnect you will have to login again.

WARNING: Please do not use a "valuable" password for the administrator 
password, it is sent in clear text via UDP to the RTP port.  i.e. it can be 
sniffed.

".admins"

This command simply lists the users who are logged in as administrators or
sysops.  This is a good way of verifying that you are logged in as an sysop 
before issuing commands.  It's also a good way to determine if it's time to 
change the passwords (grin).

".busy [on | off | status]"

This command controls the conference's busy status.  The conference's busy
status is listed in the station directory, additionally connection 
requests from new stations are refused when the conference is busy.  The
status option allows a conference to indicate that it is busy to the directory
servers, but actually continue to accept connections for special purposes.

".connect [-s] [-r] <station>"
".disconnect <station>"
".disconnect ALL"
".discconnect last"
".discconnect ."

These commands allow conference rooms to be linked to increase the capacity 
beyond what is available on a single server.  The .connect command will accept
either a station callsign, conference ID, or IP address.

The .connect command establishes a permanent connection between until a 
.disconnect command is entered by an administrator (of either conference).  If 
the connection fails the connect will be reestablished automatically when the 
path returns.

When thebridge is linked to another thebridge running version 0.33 or later 
then user's callsign and name will be displayed on the linked conference next 
to the conference's callsign in the station list.  

The .connect command can actually be used to connect to any station it is
not restricted to conferences.  If a connection is established to an user 
station he will be able to disconnect using the usual method, this is 
equivalent to an administrator entering the .disconnect command.

The "ALL" option to the ".disconnect" command disconnects all users, not just
users who were connected to using the ".connect" command.

The "LAST" option to the ".disconnect" just disconnects the last station that
connected leaving any other users connected.

The "." option to the ".disconnect" disconnects the station that is talking
currently.

".lurk disable" ".lurk enable" ".lurk <callsign>" ".delurk <callsign>"

Lurking is one of my personal favorite capabilities of thebridge, infact it
was the first command.  However not everyone shares my opinion.  The ability
to disable lurking has been the most requested feature.  The disable option
disables (duh!) the ability for stations to "lurk", the enable option restores
the capability.  By default lurking is enabled.  Stations attempting to lurk
when lurking is disabled will be sent a messages informing them that the 
lurking feature has been disabled.

Sysops can set a specified station's lurking mode.  This is useful to restore
a stations state after thebridge has been (quickly) rebooted.

"message [message text]"

This command may be used by the scripting interface to send text messages
to conference users.  Unlike the normal EchoLink text mode messages received
from the command port are assumed to be commands and need not be prefixed
by a period.


".monitor [disable] <callsign>"

This command allows you to put a station in to a talk only mode. This command
is basically the opposite of the ".mute" command, the monitored client can 
talk, but not listen.  This is useful in certain (unusual) situations such 
as the recent shuttle disaster when you want to listen to a conference, but 
while ensuring local traffic does not interrupt it.

The disable option is used to return a station to full transceive operation.

".mute"  ".mute ."  ".mute <callsign> [<callsign> ...]"  
".unmute <callsign> [<callsign...]"

This command allows you to put a station into a listen only mode.  This 
command is particularly useful during nets to prevent repeater IDs, courtesy 
tones, and confused users from interrupting a net out of turn.  The .mute 
command takes effect immediately and remains in effect as long as the station 
remains logged in or until it is canceled by the .unmute command.

The station that's currently talking may be specified by a dot "." character to
save typing the entire callsign.

If the .mute command is given without an argument a list of stations that are 
currently muted is displayed.

".mute -r" ".mute -c" ".mute -u" ".mute -s" ".mute -t" ".mute -a" ".mute -e"
".unmute -r" ".unmute -c" ".unmute -u" ".unmute -s" ".unmute -t" ".unmute -a"
".unmute -e"

These variations of the .mute and .unmute commands affect a group of stations
at a time and additionally put the conference into a mode were new connections
from stations of that type are automatically muted as well.  These commands
are primarily of use for controlling large nets such as the N2LEN 9/11 net.

 Where the various suffixes mean:

  -a: All users (except yourself)
  -c: tbd conferences
  -e: Echolink conferences
  -r: RF users (-R and -L stations)
  -s: Sysops and Admins
  -t: Station talking
  -u: PC users

You can use more than one option in a command so if you want to mute
both RF users and PC users, but not conferences and sysops as well as a
specific conference you could enter"
".mute -ru *echotest*"

The station that is currently talking are *NOT* muted by these commands unless 
the "t" flag is included.

These are additive, if you mute conferences in one command and then mute rf
users in the next command both remain muted.

".mute chat" ".unmute chat"

This commands allows a sysop to control if text messages are sent to him.
The command affects the sysop issuing the command only, text messages continue 
to be forwarded to other users.  This command is useful for net control 
stations who are trying to read the user list while a lively off topic QSO is 
going on the background in text mode.

".pausetime"  ".pausetime <time constant>"

This command allows the configuration variable PauseTime to be adjusted as
needed during normal operation.  The PauseTime variable sets the minimum gap
between transmissions on the conference.  Stations who jump in before the
minimum time has elapsed will be sent a warning message and will not be
repeated until the minimum pause time has elapsed.

This parameter may help prevent repeater "bouncing" that occurs when multiple 
repeaters or link stations are logged into a  conference room with poor 
operating parameters.   It will also ensure that there's a break between 
transmissions to allow simplex links to leave the conference.

".play4 [-f] [-i] <filename> [displayed name]"

This command allows a recording file to be played all users.  When the file is 
played for all users an optional description may be entered which will appear 
on the station list as the "station" talking.  If the description is omitted 
the "station" will be shown as "QST".  The timing of the playback is 
controlled by the same configuration file variables as the .play command. 
Normally playback will begin as soon as the conference free (no one is 
talking), -f and -i flags are used to modify this behavour.  The -f flag can be
used to force the playback to begin immediately even if someone is talking.
The -i flag can be used to force the playback to wait for IdleTimeout seconds
of inactivity before the bulletin playback begins.

These flags provide the ability for scripts to do things such as automatically
playback a net at a particular while warning any users before hand to allow
them time to finish their QSOs. For example a couple of warning anouncements 
could be played 10 mintutes, 5 minutes and one minute before the net and then 
the bulletin could be played exactly on time using the -f command.

A less driven conference operator might simply use the -i command to play the
bulletin as soon as the conference becomes free after the appointed time. This
would allow QSOs to finish naturally before begining a playback.

".play4 -u <user> <filename>"

This variation of play4 command allows a recording to be played for a specifc
user.

".users"   ".users ?"

The .users command lists the callsign of all conference users in order of login 
along with their attributes.  This command is particularly useful for net
control operators by enabling them to see more stations than will fit in the
EchoLink client's info window.  

The meaning of the attribute characters may be display by the ".user ?" 
command.  They are as follows:

A - User is logged in as an administrator.
S - User is logged in as a sysop.
L - User is a Lurker.
m - User's audio is muted.
M - User's audio and text are muted.
K - User's has been Kicked.
B - User is a linked theBridge conference.
C - User is a linked conference other than thebridge.
F - User is playing a file (using the .play or .test commands).
x - User is not currently active in the conference.
P - User is a permanent connection (connected by a .connect command).
T - User is currently Talking.
0 - User is using Speak Freely protocol.
1 - User is using RTP protocol.
! - User is an old version of thebridge which sent SDES packets containing 
    a private "txt" extension field.
    

".belchfilter"  ".belchfilter <time constant>"

This command allows the configuration variable BelchTime to be adjusted as
needed during normal operation.  The BelchTime variable sets the minimum 
transmission time for -R and -L station before their audio is passed.

This parameter may help prevent repeater "bouncing" that occurs when multiple 
repeaters or link stations are logged into a  conference room with poor 
operating parameters.   It can also help prevent repeater "kurchunkers" from
upsetting the peace.

 
######################
Administrator Commands
######################

".admin <password>"

None of the administrator commands are available until you identify yourself as 
an administrator by using the .admin command and supplying the administrator's 
password.  When using this command please *make* sure that you enter the 
leading '.' and start the command at the beginning of the line, otherwise you 
may send the administrator's password to everyone logged into the conference!  

Once you have logged in successfully you will be greeted with a welcome 
message.  You will remain logged in as an administrator only as long as you
are connected to thebridge, if you disconnect you will have to login again.

An administrator automatically has access to all sysop commands, there is
no need to login as a sysop if you are logged in as a administrator.  

Sysops are typically net control operators, administrator's are typically
node owners.

".allow add <callsign>"

This command adds a new station to the access control list. This command is 
typically used to add stations to private conferences.  

".allow delete <callsign>"  

This command removes a station from the access control list.

".allow list"

This command displays the stations that are allowed access by the access 
control list.

".dns list"

This commands displays the entries in the domain name system (DNS) cache.  The
DNS system converts hostnames such as nawest.echolink.org into IP addresses.

".dns refresh"

This command forces the contents of the DNS cache to be updated.  By default
the DNS cache is updated every 15 minutes. Forcing an update can help correct
problems caused by hostnames entries in the ACL which are tied to dynamic IP 
addresses.

".quote <command line>"

The quote command allows a sysop to send a command to all linked conferences. 
For example a sysop on one conference can mute a station on another conference
by entering ".quote .mute w1abc".  Note that since the command is set to *all* 
linked conferences an error message "w1abc not found" will be generated by


".quickexit"

This command caused thebridge to exit without logging out of the EchoLink
directory servers.  This may be useful when there are communications problems
or under other special situations.  Normally the ".shutdown" command should
be used instead.  This command was formally known as .quit, but that caused
accidents.


".record <filename>" ".record stop"

This command starts recording all conference bridge traffic to disk for latter 
playback.  Traffic recorded includes all conference audio *and* text messages. 
Test sessions and commands sent to thebridge are not recorded.  The recording 
file grows at approximately 129000 bytes a minute while someone is talking. 
The gaps between transmissions are not recorded and do not consume disk space.  
To end the recording enter ".record stop".  Make a note of the filename you 
use when recording, you will need it later.  Recordings are not available for 
playback by users until you explicitly add them to the list of available 
bulletins.

".refresh"

This command causes thebridge to download an update to the in memory (and 
on disk if enabled) station list from the Echolink directory server.


".rehash"

This command causes thebridge to re-read it's configuration file.  This allows
changes to be made to the configuration without having to restart the server.

".set <variable>"
".set <variable> = <value>"

This command allows the administrator to view and set configuration file
variables interactively.  Most, but not all, variables may be set by this
command.  Since the configuration file is not updated by this command any
changes will be lost when thebridge is restarted.


".shutdown"

This command causes thebridge to logout of the EchoLink directory servers
and then exit.


".list add <filename> <description>"

Once a recording has been made it may be made available for user playback 
by adding it to the bulletin list.  Users select bulletins by description, 
they never see the filename.  This provides the ability to change the file 
that is played back without changing the description.  For example a 
description of "Last week's net" could be updated weekly to point to a new 
recording while keeping an archive of older nets.  

".list"

When in logged in as an administrator the .list command shows the filename 
corresponding to the description at the beginning of the line.  This is 
useful for those of us with short memories when using the next command.
  
".list delete <filename>"

As you might expect this removes a bulletin from the list. 

".kick <callsign>"

This command terminates a users connection immediately.  This command is useful 
when you want to disconnect a station completely.  For example a link or 
repeater station has been connected to the conference for a long period of 
time and appears to be unattended and a long net is about to start on the 
conference.  It might be considered a courtesy to dump such connections rather 
than sending tons of undesired traffic out on the airwaves.  The .kick 
command has no lasting effect, the kicked station is free to reconnect 
immediately after being kicked. In our example this would indicate an 
active interest in the net from someone associated with the link or repeater.

".ban add <callsign> [IP Address/HostName]"

If the previous commands were insufficient to correct a problem then the 
.ban command can be used to add a station to the banned list.  Unlike the 
previous commands the banned list is persistent across connections as well as 
system reboots.  A banned station cannot even connect to thebridge. 
Note: Stations are banned independently of station type, i.e. if W1AW is 
banned (what not a league supporter?); W1AW-L and W1AW-R are also banned.  

Additionally stations may be banned by *both* callsign and IP address if 
desired.  Unlike earlier versions of the bridge version 0.41 and later to 
not automatically ban stations by IP address, unless it is specified by
the administrator when the station is banned.
  
".ban list"

This lists the current rogues' gallery of banned stations.

".ban delete <callsign>"

Well they finally fixed their repeater, it's about time!  This command 
removes a station from the banned list.

".info [Info field text]"

The .info command displays and modifies the info (location, Qth) string sent
to the directory server.  If an argument is not specified the .info command
simply displays the current info string.  When an argument is given the
current info string is replaced with the argument and the directory server
is updated with the new string.  The new string is *NOT* persistent, if
tbd is restarted the info string will return to the value specified in tbd.conf.

###############
Script Commands
###############

".chat [on | off]"

The .chat command controls the chat mode of the command inteface.  When the
chat mode is off messages sent to the command port are assumed to be commands
for thebridge and incoming text messages are not forwarded to the command port. 
When chat mode is on messages sent to the command part are forwarded as text
message unless preceeded with ".." to indiate they are commands for the local
system.  When chat mode is on text messages received from the net are 
forwarded to the command port with an result code of TBD_CHAT_TEXT.  See
SCRIPTING.txt for more details.

NB: Although the .chat mode feature is still supported it is depreciated. 
Version 0.84 and later of thebridge provides a separate port for text messages
to replace the .chat mode.  

#########
Operation
#########

Hopefully users of thebridge will not notice much differences between
thebridge and the other conference bridges other than (hopefully) improved
reliability, uptime and the availability of the user commands.

Check the screen from time to time to verify that thebridge is operating
correctly.  


###############################
Bugs/Features/known limitations
###############################

1.  Consider this software to be Beta quality, it is very new and the paint is 
still wet.  One of the primary goals is stability approaching that of the 
operating system and in the FreeBSD or Linux case that says quite a bit.  At 
this point we're probably a long way from that goal.  At least when thebridge 
crashes under FreeBSD or Linux the operating system probably won't and we 
should get a core file that will allow the bug to found and hopefully fixed.  

2. Security is weak.  Currently EchoLink's security is based on 
passwords which are sent in clear text on over the Internet and the relative 
obscurity of the system.  Security through obscurity is no security at all! 

3. If the RunAsUser feature is used under Linux core dumps are disabled. This 
appears to be a security feature inherent in Linux.  If thebridge stops 
running for unexplained reasons please consider running it as root long enough 
to get a core dump to assist with correcting the problem.


######
Thanks
######

Special thanks to WD4NMQ, W7NTF, K7KAJ, and NK6K for helping me debug and 
test the pre-release versions of thebridge.  In particular Jeff WD4NMQ had 
already  done a lot of investigate work into the iLink protocols before I had 
even heard of iLink.  Jeff's server code saved me hours of work !

Thanks to Graeme M0CSH and Jonathan K1RFD for bringing an exciting new mode 
to Ham Radio.

Thanks to N2LEN, K5JD, N7WGR, and KA3LAO for sending in bug reports that 
helped me find and fix some Windows specific bugs.

Thanks to N9YTY for testing thebridge on MacOS X and reporting the results.

Thanks to W7NTF, K1DWU, WB3FFV, and KD6HWC for providing me with access to
their hosts to test thebridge on platforms that I would not otherwise have 
had access to.

Thanks to XE1DVI, IK2XYP, WB5EGI, VK3JED, SM6TKT, W6FM, KD6HWC, W7NTF, VE3EI,
and N2LEE/N4LED for helping Beta test thebridge.

Thanks to the fine folks at sourceforge for hosting this and literally 
thousands of other open source projects.  Please support the OSDN in anyway
you can !


################
How you can help
################

1. Report all bugs. Please provide details on the version of thebridge, the
operating systems, and operating conditions.  Log files and core dumps are 
not only helpful but in many cases essential.

2. Developers are welcome!  If you have ideas and would like contribute to the
development please contact me.

3. Documentation.  It's a well known fact that most programmers/engineers hate
documentation and are usually poor writers.  We need to document the programs
and protocols used by thebridge as well as other programs that will be written.
The CQiNet web site could certainly use some input and a webmaster. If your 
language of choice is not a programming language you can still help !

wb6ymh@cox.net Nov 28, 2004
