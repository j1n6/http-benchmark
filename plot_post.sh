rm perf-data-post.tsv
touch perf-data-post.tsv

/usr/local/Cellar/ab/2.4.12/bin/ab -n 10000 -c 10 -p post_data -T "application/x-www-form-urlencoded" -g "perf-data-post.tsv"  "http://10.0.6.76/"


gnuplot <<- EOF
    # Let's output to a jpeg file
	set terminal png size 1000,600
	# This sets the aspect ratio of the graph
	set size 1, 1
	# The graph title
	set title "Benchmark testing"
	# Where to place the legend/key
	set key left top
	# Draw gridlines oriented on the y axis
	set grid y
	# Specify that the x-series data is time data
	set xdata time
	# Specify the *input* format of the time data
	set timefmt "%s"
	# Specify the *output* format for the x-axis tick labels
	set format x "%S"
	# Label the x-axis
	set xlabel 'seconds'
	# Label the y-axis
	set ylabel "response time (ms)"
	# Tell gnuplot to use tabs as the delimiter instead of spaces (default)
	set datafile separator '\t'
	#
	set output "perf-data-post.png"
	# Plot the data
	plot "perf-data-post.tsv" every ::2 using 2:5 title 'response time' with points
EOF

