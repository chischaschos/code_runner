#! /usr/bin/python
import sys
import json

from StringIO import StringIO
capture = StringIO()
save_stdout = sys.stdout
sys.stdout = capture

obj = compile(sys.argv[1], '<string>', 'exec')
eval(obj)

sys.stdout = save_stdout

print json.dumps({'success': True, 'errors': [], 'output': capture.getvalue()})

