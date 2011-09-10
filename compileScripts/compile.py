import sys, os
if __name__ == '__main__':
	application = "c:/flex_sdk/sdk4.5.1/bin/mxmlc";
	args = sys.argv[1] + " -static-link-runtime-shared-libraries=true";
	execute = "" + application + " " + args;
	print "Execute: " + execute;
	os.system(execute);