-- hook function for wrk (https://github.com/wg/wrk) to print errors to stdout
-- printing of errors will cause blocking, so use wisely
response = function(status, headers, body)
	if not ( status == 200 ) then
		io.write(body)
	end
end