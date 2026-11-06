# Substitute @NAME@ tokens in bmake bootstrap templates.
#
# Read values from the environment so shell metacharacters in compiler and
# linker flags are copied literally instead of being interpreted by sed.

function substitute(line,    output, key) {
	output = ""
	while (match(line, /@[A-Za-z_][A-Za-z0-9_]*@/)) {
		output = output substr(line, 1, RSTART - 1)
		key = substr(line, RSTART + 1, RLENGTH - 2)
		if (key in ENVIRON)
			output = output ENVIRON[key]
		else
			output = output substr(line, RSTART, RLENGTH)
		line = substr(line, RSTART + RLENGTH)
	}
	return output line
}

{
	print substitute($0)
}
