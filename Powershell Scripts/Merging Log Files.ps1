#he command Merge-SPlogfile will automatically search the logs for the error ID. Better than that, the command will search ALL the servers in the farm and place a log file on the server that you will the command. 

Merge-SPlogfile –Path c:\log.log –Correlation ba05e237-0680-403a-b9f6-e49f96ac55d4

#That will place a .log file on the C drive of the server which will only contain errors with the correlation ID.